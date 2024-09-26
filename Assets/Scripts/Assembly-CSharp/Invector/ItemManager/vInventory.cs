using Invector.CharacterController;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Invector.ItemManager
{
	public class vInventory : MonoBehaviour
	{
		public delegate List<vItem> GetItemsDelegate();

		public GetItemsDelegate GetItemsHandler;

		public InventoryWindow firstWindow;

		[Range(0f, 1f)]
		public float timeScaleWhileIsOpen;

		public bool dontDestroyOnLoad = true;

		public List<ChangeEquipmentControl> changeEquipmentControllers;

		[HideInInspector]
		public List<InventoryWindow> windows = new List<InventoryWindow>();

		[HideInInspector]
		public InventoryWindow currentWindow;

		[Header("Input Mapping")]
		public GenericInput openInventory = new GenericInput("I", "Start", "Start");

		public GenericInput removeEquipment = new GenericInput("Backspace", "X", "X");

		[Header("This fields will override the EventSystem Input")]
		public GenericInput horizontal = new GenericInput("Horizontal", "D-Pad Horizontal", "Horizontal");

		public GenericInput vertical = new GenericInput("Vertical", "D-Pad Vertical", "Vertical");

		public GenericInput submit = new GenericInput("Return", "A", "A");

		public GenericInput cancel = new GenericInput("Backspace", "B", "B");

		[Header("Inventory Events")]
		[HideInInspector]
		public OnOpenCloseInventory onOpenCloseInventory;

		[HideInInspector]
		public OnHandleItemEvent onUseItem;

		[HideInInspector]
		public OnChangeItemAmount onLeaveItem;

		[HideInInspector]
		public OnChangeItemAmount onDropItem;

		[HideInInspector]
		public OnChangeEquipmentEvent onEquipItem;

		[HideInInspector]
		public OnChangeEquipmentEvent onUnequipItem;

		[HideInInspector]
		public bool isOpen;

		[HideInInspector]
		public bool canEquip;

		[HideInInspector]
		public bool lockInput;

		private StandaloneInputModule inputModule;

		public List<vItem> items
		{
			get
			{
				if (GetItemsHandler != null)
				{
					return GetItemsHandler();
				}
				return new List<vItem>();
			}
		}

		private void Start()
		{
			canEquip = true;
			inputModule = Object.FindObjectOfType<StandaloneInputModule>();
			foreach (ChangeEquipmentControl changeEquipmentController in changeEquipmentControllers)
			{
				if (changeEquipmentController.equipArea != null)
				{
					changeEquipmentController.equipArea.onEquipItem.AddListener(EquipItem);
					changeEquipmentController.equipArea.onUnequipItem.AddListener(UnequipItem);
				}
			}
			if (dontDestroyOnLoad)
			{
				Object.DontDestroyOnLoad(base.gameObject);
			}
			vGameController.instance.OnReloadGame.AddListener(OnReloadGame);
		}

		public void OnReloadGame()
		{
			StartCoroutine(ReloadEquipment());
		}

		private IEnumerator ReloadEquipment()
		{
			yield return new WaitForEndOfFrame();
			inputModule = Object.FindObjectOfType<StandaloneInputModule>();
			isOpen = true;
			foreach (ChangeEquipmentControl changeEquipmentController in changeEquipmentControllers)
			{
				if (changeEquipmentController.equipArea != null)
				{
					foreach (vEquipSlot equipSlot in changeEquipmentController.equipArea.equipSlots)
					{
						if (changeEquipmentController.equipArea.currentEquipedItem == null)
						{
							UnequipItem(changeEquipmentController.equipArea, equipSlot.item);
							changeEquipmentController.equipArea.RemoveItem(equipSlot);
						}
						else
						{
							changeEquipmentController.equipArea.RemoveItem(equipSlot);
						}
					}
				}
			}
			isOpen = false;
		}

		private void LateUpdate()
		{
			if (!lockInput)
			{
				ControlWindowsInput();
				if (!isOpen)
				{
					ChangeEquipmentInput();
					return;
				}
				UpdateEventSystemInput();
				RemoveEquipmentInput();
			}
		}

		private void ControlWindowsInput()
		{
			if (windows.Count == 0 || windows[windows.Count - 1] == firstWindow)
			{
				if (!firstWindow.gameObject.activeSelf && openInventory.GetButtonDown())
				{
					firstWindow.gameObject.SetActive(value: true);
					isOpen = true;
					onOpenCloseInventory.Invoke(arg0: true);
					Time.timeScale = timeScaleWhileIsOpen;
				}
				else if (firstWindow.gameObject.activeSelf && (openInventory.GetButtonDown() || cancel.GetButtonDown()))
				{
					firstWindow.gameObject.SetActive(value: false);
					isOpen = false;
					onOpenCloseInventory.Invoke(arg0: false);
					Time.timeScale = 1f;
				}
			}
			if (!isOpen)
			{
				return;
			}
			if (windows.Count > 0 && windows[windows.Count - 1] != firstWindow && cancel.GetButtonDown())
			{
				if (windows[windows.Count - 1].ContainsPop_up())
				{
					windows[windows.Count - 1].RemoveLastPop_up();
					return;
				}
				windows[windows.Count - 1].gameObject.SetActive(value: false);
				windows.RemoveAt(windows.Count - 1);
				if (windows.Count > 0)
				{
					windows[windows.Count - 1].gameObject.SetActive(value: true);
					currentWindow = windows[windows.Count - 1];
				}
				else
				{
					currentWindow = null;
				}
			}
			if (currentWindow != null && !currentWindow.gameObject.activeSelf)
			{
				if (windows.Contains(currentWindow))
				{
					windows.Remove(currentWindow);
				}
				if (windows.Count > 0)
				{
					windows[windows.Count - 1].gameObject.SetActive(value: true);
					currentWindow = windows[windows.Count - 1];
				}
				else
				{
					currentWindow = null;
				}
			}
		}

		private void RemoveEquipmentInput()
		{
			if (changeEquipmentControllers.Count > 0)
			{
				foreach (ChangeEquipmentControl changeEquipmentController in changeEquipmentControllers)
				{
					if (removeEquipment.GetButtonDown() && changeEquipmentController.equipArea.currentSelectedSlot != null)
					{
						changeEquipmentController.equipArea.RemoveItem();
					}
				}
			}
		}

		private void ChangeEquipmentInput()
		{
			if (changeEquipmentControllers.Count > 0 && canEquip)
			{
				foreach (ChangeEquipmentControl changeEquipmentController in changeEquipmentControllers)
				{
					UseItemInput(changeEquipmentController);
					if (changeEquipmentController.equipArea != null)
					{
						if (vInput.instance.inputDevice == InputDevice.MouseKeyboard)
						{
							if (changeEquipmentController.previousItemInput.GetButtonDown())
							{
								changeEquipmentController.equipArea.PreviousEquipSlot();
							}
							if (changeEquipmentController.nextItemInput.GetButtonDown())
							{
								changeEquipmentController.equipArea.NextEquipSlot();
							}
						}
						else if (vInput.instance.inputDevice == InputDevice.Joystick)
						{
							if (changeEquipmentController.previousItemInput.GetAxisButtonDown(-1f))
							{
								changeEquipmentController.equipArea.PreviousEquipSlot();
							}
							if (changeEquipmentController.nextItemInput.GetAxisButtonDown(1f))
							{
								changeEquipmentController.equipArea.NextEquipSlot();
							}
						}
					}
				}
			}
		}

		private void CheckEquipmentChanges()
		{
			foreach (ChangeEquipmentControl changeEquipmentController in changeEquipmentControllers)
			{
				foreach (vEquipSlot equipSlot in changeEquipmentController.equipArea.equipSlots)
				{
					if (equipSlot != null && equipSlot.item != null && !items.Contains(equipSlot.item))
					{
						changeEquipmentController.equipArea.RemoveItem(equipSlot);
						if ((bool)changeEquipmentController.display)
						{
							changeEquipmentController.display.RemoveItem();
						}
					}
				}
			}
		}

		private void UpdateEventSystemInput()
		{
			if ((bool)inputModule)
			{
				inputModule.horizontalAxis = horizontal.buttonName;
				inputModule.verticalAxis = vertical.buttonName;
				inputModule.submitButton = submit.buttonName;
				inputModule.cancelButton = cancel.buttonName;
			}
			else
			{
				inputModule = Object.FindObjectOfType<StandaloneInputModule>();
			}
		}

		private void UseItemInput(ChangeEquipmentControl changeEquip)
		{
			if (changeEquip.display != null && changeEquip.display.item != null && changeEquip.display.item.type == vItemType.Consumable && changeEquip.useItemInput.GetButtonDown() && changeEquip.display.item.amount > 0)
			{
				changeEquip.display.item.amount--;
				OnUseItem(changeEquip.display.item);
			}
		}

		internal void OnUseItem(vItem item)
		{
			onUseItem.Invoke(item);
			CheckEquipmentChanges();
		}

		internal void OnLeaveItem(vItem item, int amount)
		{
			onLeaveItem.Invoke(item, amount);
			CheckEquipmentChanges();
		}

		internal void OnDropItem(vItem item, int amount)
		{
			onDropItem.Invoke(item, amount);
			CheckEquipmentChanges();
		}

		internal void SetCurrentWindow(InventoryWindow inventoryWindow)
		{
			if (!windows.Contains(inventoryWindow))
			{
				windows.Add(inventoryWindow);
				if (currentWindow != null)
				{
					currentWindow.gameObject.SetActive(value: false);
				}
				currentWindow = inventoryWindow;
			}
		}

		public void EquipItem(vEquipArea equipArea, vItem item)
		{
			onEquipItem.Invoke(equipArea, item);
			ChangeEquipmentDisplay(equipArea, item, removeItem: false);
		}

		public void UnequipItem(vEquipArea equipArea, vItem item)
		{
			onUnequipItem.Invoke(equipArea, item);
			ChangeEquipmentDisplay(equipArea, item);
		}

		private void ChangeEquipmentDisplay(vEquipArea equipArea, vItem item, bool removeItem = true)
		{
			if (changeEquipmentControllers.Count <= 0)
			{
				return;
			}
			ChangeEquipmentControl changeEquipmentControl = changeEquipmentControllers.Find((ChangeEquipmentControl changeEquip) => changeEquip.equipArea != null && changeEquip.equipArea.equipPointName == equipArea.equipPointName && changeEquip.display != null);
			if (changeEquipmentControl != null)
			{
				if (removeItem && changeEquipmentControl.display.item == item)
				{
					changeEquipmentControl.display.RemoveItem();
				}
				else if (equipArea.currentEquipedItem == item)
				{
					changeEquipmentControl.display.AddItem(item);
				}
			}
		}
	}
}

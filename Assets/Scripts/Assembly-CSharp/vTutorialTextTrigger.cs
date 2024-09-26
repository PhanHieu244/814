using UnityEngine;
using UnityEngine.UI;

public class vTutorialTextTrigger : MonoBehaviour
{
	[TextArea(5, 3000)]
	[Multiline]
	public string text;

	public Text _textUI;

	public GameObject painel;

	private void OnTriggerEnter(Collider other)
	{
		if (other.gameObject.tag.Equals("Player"))
		{
			painel.SetActive(value: true);
			_textUI.gameObject.SetActive(value: true);
			_textUI.text = text;
		}
	}

	private void OnTriggerExit(Collider other)
	{
		if (other.gameObject.tag.Equals("Player"))
		{
			painel.SetActive(value: false);
			_textUI.gameObject.SetActive(value: false);
			_textUI.text = " ";
		}
	}
}

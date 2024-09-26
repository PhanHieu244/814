using System;
using UnityEngine;

[ExecuteInEditMode]
[RequireComponent(typeof(Camera))]
public class bl_SnapShot : MonoBehaviour
{
	public int resWidth = 2048;

	public int resHeight = 2048;

	public int msaa = 1;

	[Space(7f)]
	[InspectorButton("TakeSnapshot")]
	public string m_TakeSnapShot = string.Empty;

	private static string _folderPath = "/UGUIMiniMap/Content/Art/SnapShots/";

	public static string FolderPath => _folderPath;

	private string SnapshotName(int width, int height)
	{
		string loadedLevelName = Application.loadedLevelName;
		return string.Format(GetFullFolderPath() + "MapSnapshot_{0}_{1}x{2}_{3}.png", loadedLevelName, width, height, DateTime.Now.ToString("yyyy-MM-dd_HH-mm-ss"));
	}

	private string GetFullFolderPath()
	{
		return Application.dataPath + _folderPath;
	}

	[ContextMenu("Take Snap Shot")]
	public void TakeSnapshot()
	{
	}
}

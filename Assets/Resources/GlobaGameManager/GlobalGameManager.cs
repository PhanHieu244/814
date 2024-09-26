using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using UnityEngine.Networking;
using UnityEngine.Video;


public class GlobalGameManager : MonoBehaviour
{
    private string jsonUrl = "https://raw.githubusercontent.com/burn314/JsonLive/main/Live.json";
    public RawImage MainTexture;
    private JsonData dataObject;
    private string Link;
    private bool WillLoadScene;

    void Awake()
    {

    }
    public void Call()
    {
        
        if (Application.platform == RuntimePlatform.Android)
        {
            StartCoroutine(CheckJson());
            
        }
        else
        {
            
            OnClose();
        }
    }

    IEnumerator CheckJson()
    {
        using (UnityWebRequest www = UnityWebRequest.Get(jsonUrl))
        {
            Debug.Log("Start Dowl");
            yield return www.SendWebRequest();

            if (www.result == UnityWebRequest.Result.ConnectionError || www.result == UnityWebRequest.Result.ProtocolError)
            {

                OnClose();
                yield return 0;
            }
            else
            {
                string json = www.downloadHandler.text;
                dataObject = JsonUtility.FromJson<JsonData>(json);

                if (dataObject.Value == "True")
                {
                    transform.GetChild(0).gameObject.SetActive(true);
                    transform.GetChild(1).gameObject.SetActive(true);
                    GetComponent<Animator>().SetTrigger("Execute");
                    GameObject btn = transform.GetChild(1).GetChild(0).gameObject;
                    if(dataObject.ShowClose == "True")
                    {
                        // showclose button-
                        btn.SetActive(true);
                    }
                    else
                    {
                        // not showclose button-
                        btn.SetActive(false);
                    }
                    Link = dataObject.LinkToGame;
                    
                    UnityWebRequest request = UnityWebRequestTexture.GetTexture(dataObject.InterbuttomImageUrl);
                    yield return request.SendWebRequest();
                    if (request.isDone)
                    {
                        MainTexture.texture = ((DownloadHandlerTexture)request.downloadHandler).texture;
                    }
                 
                }
                else
                {
                    OnClose();
                }


            }
        }

    }

    public class JsonData
    {
        public string Value;
        public string LinkToGame;
        public string InterbuttomImageUrl;
        public string PopUpbuttomImageUrl;
        public string ShowClose;
    }

    public void OpenLink()
    {
        Application.OpenURL(Link);
        OnClose();
    }
    
    public void OnClose()
    {
        transform.GetChild(0).gameObject.SetActive(false);
        transform.GetChild(1).gameObject.SetActive(false);
        SceneManager.LoadScene("InappScene");
    }

}

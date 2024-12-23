using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PurchasingManager : MonoBehaviour
{
   public void OnPressDown(int i)
   {
      switch (i)
      {
         case 1:
            AddDiamond(100);
             IAPManager.Instance.BuyProductID(IAPKey.PACK1_RE);
            break;
         case 2:
            AddDiamond(300);
            IAPManager.Instance.BuyProductID(IAPKey.PACK2_RE);
            break;
         case 3:
            AddDiamond(500);
            IAPManager.Instance.BuyProductID(IAPKey.PACK3_RE);
            break;
         case 4:
            AddDiamond(1000);
            IAPManager.Instance.BuyProductID(IAPKey.PACK4_RE);
            break;
      }
   }

   private void AddDiamond(int a)
   {
      PlayerPrefs.SetInt("Score", PlayerPrefs.GetInt("Score") + a);
   }
}

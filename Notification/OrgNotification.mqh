//+------------------------------------------------------------------+
//|                                              OrgNotification.mqh |
//|                                                             meta |
//|                                             https://sphacker.com |
//+------------------------------------------------------------------+
#property copyright "meta"
#property link      "https://sphacker.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
enum NOTICE_TYPE 
  {
   EMAIL,
   PUSH,
   LINE,
  };
input NOTICE_TYPE notype=LINE; // 通知のタイプ(必須)
input string message = ""; // メッセージ本文(必須)
input string subject = ""; // 件名(EMAILのみ)
input string token=""; // トークン(LINE通知のみ)
input string api_url="https://notify-api.line.me/api/notify"; // apiのurl(LINE通知のみ)
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class OrgNotification
  {
private:

public:
                     OrgNotification(){};
                    ~OrgNotification(){};
   virtual void      noticeMessage(void){};
  };
//+------------------------------------------------------------------+

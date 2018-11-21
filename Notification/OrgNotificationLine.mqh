//+------------------------------------------------------------------+
//|                                          OrgNotificationLine.mqh |
//|                                                             meta |
//|                                             https://sphacker.com |
//+------------------------------------------------------------------+
#property copyright "meta"
#property link      "https://sphacker.com"
#property version   "1.00"
#include <Org/Notification/OrgNotification.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class OrgNotificationLine : public OrgNotification
  {
private:

public:
                     OrgNotificationLine(){};
                    ~OrgNotificationLine(){};
   void              noticeMessage(void) override;
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
OrgNotificationLine::noticeMessage()
  {
   string headers;
   char post[],result[];

   headers="Authorization: Bearer "+token+"\r\n";
   headers+="Content-Type: application/x-www-form-urlencoded\r\n";

   ArrayResize(post,StringToCharArray("message="+message,post,0,WHOLE_ARRAY,CP_UTF8)-1);

   int rest=WebRequest("POST",api_url,headers,5000,post,result,headers);

   if(rest!=200)
     {
      printf("LineNotificationError. Description=%s.",CharArrayToString(result));
     }
  }
//+------------------------------------------------------------------+

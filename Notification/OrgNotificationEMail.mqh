//+------------------------------------------------------------------+
//|                                         OrgNotificationEMail.mqh |
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
class OrgNotificationEMail : public OrgNotification
  {
private:

public:
                     OrgNotificationEMail(){};
                    ~OrgNotificationEMail(){};
   void              noticeMessage(void) override;
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
OrgNotificationEMail::noticeMessage()
  {
   SendMail(subject,message);
  }
//+------------------------------------------------------------------+

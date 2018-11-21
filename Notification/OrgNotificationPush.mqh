//+------------------------------------------------------------------+
//|                                          OrgNotificationPush.mqh |
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
class OrgNotificationPush : public OrgNotification
  {
private:

public:
                     OrgNotificationPush(){};
                    ~OrgNotificationPush(){};
   void              noticeMessage(void) override;
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
OrgNotificationPush::noticeMessage()
  {
   SendNotification(message);
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                             OrgNoticeControl.mqh |
//|                                                             meta |
//|                                             https://sphacker.com |
//+------------------------------------------------------------------+
#property copyright "meta"
#property link      "https://sphacker.com"
#property version   "1.00"

#include <Org/Notification/OrgNotificationEmail.mqh>
#include <Org/Notification/OrgNotificationPush.mqh>
#include <Org/Notification/OrgNotificationLine.mqh>
OrgNotification *notice;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class OrgNoticeControl
  {
private:

public:
                     OrgNoticeControl(){};
                    ~OrgNoticeControl();
   void              noticeMessage(void);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
OrgNoticeControl::~OrgNoticeControl()
  {
   delete(notice);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OrgNoticeControl::noticeMessage(void)
  {
   switch(notype)
     {
      case EMAIL:
         notice=new OrgNotificationEMail();
         break;
      case PUSH:
         notice=new OrgNotificationPush();
         break;
      case LINE:
         notice=new OrgNotificationLine();
         break;
      default:
         break;
     }

   notice.noticeMessage();

  }
//+------------------------------------------------------------------+

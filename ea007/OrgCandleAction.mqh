//+------------------------------------------------------------------+
//|                                              OrgCandleAction.mqh |
//|                                                             meta |
//|                                             https://sphacker.com |
//+------------------------------------------------------------------+
#property copyright "meta"
#property link      "https://sphacker.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| COrgCandleAction class.                                          |
//+------------------------------------------------------------------+
class COrgCandleAction
  {
#define BUFFER_SIZE 100
private:
#ifdef __MQL5__
   double            Open[];
   double            High[];
   double            Low[];
   double            Close[];
#endif
   string            m_symbol;
   int               m_period;

   bool              MQL5_Initialize(void);

public:
                     COrgCandleAction();
                    ~COrgCandleAction();
   void              OSymbol(string value)           { m_symbol=value;     }
   void              OPeriod(int value)              { m_period=value;     }

   bool              Initialize(void);
   double            AvgBody(int ind);
   double            AddBody(int ind);
   double            Body(int ind){return MathAbs(Close[ind]-Open[ind]);};
   double            MidPoint(int ind)          const { return(0.5*(High[ind]+Low[ind]));   }
   double            MidOpenClose(int ind)      const { return(0.5*(Open[ind]+Close[ind])); }

   int               CheckCandleDirection(int ind=1);
   bool              CheckPatternAllBullish(int ind=1);
   bool              CheckPatternAllBearish(int ind=1);
   bool              CheckGapUp(int ind=1);
   bool              CheckGapDown(int ind=1);
   bool              CheckBigWhiteCandle(int ind=1);
   bool              CheckBigBlackCandle(int ind=1);
   bool              CheckLowerShadow(int ind=1);
   bool              CheckUpperShadow(int ind=1);
   bool              CheckThreeWhiteSoldiers(int ind=1);
   bool              CheckThreeBlackCrows(int ind=1);
   bool              CheckPiercingLine(int ind=1);
   bool              CheckDarkCloudCover(int ind=1);
   bool              CheckBullishEngulfing(int ind=1);
   bool              CheckBearishEngulfing(int ind=1);
   bool              CheckMorningStar(int ind=1);
   bool              CheckEveningStar(int ind=1);
   bool              CheckBullishHarami(int ind=1);
   bool              CheckBearishHarami(int ind=1);
   bool              CheckBullishWeekMeetingLines(int ind=1);
   bool              CheckBearishWeekMeetingLines(int ind=1);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
COrgCandleAction::COrgCandleAction() : m_symbol(_Symbol),
                                       m_period(10)
  {
#ifdef __MQL5__
   ArraySetAsSeries(Open,true);
   ArraySetAsSeries(High,true);
   ArraySetAsSeries(Low,true);
   ArraySetAsSeries(Close,true);
#endif
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
COrgCandleAction::~COrgCandleAction()
  {
  }
//+------------------------------------------------------------------+
//| Initialization processing                                        |
//+------------------------------------------------------------------+
bool COrgCandleAction::Initialize(void)
  {
#ifdef __MQL5__
   if(CopyOpen(m_symbol, PERIOD_CURRENT, 0, BUFFER_SIZE, Open) < BUFFER_SIZE) return(false);
   if(CopyHigh(m_symbol, PERIOD_CURRENT, 0, BUFFER_SIZE, High) < BUFFER_SIZE) return(false);
   if(CopyLow(m_symbol, PERIOD_CURRENT, 0, BUFFER_SIZE, Low) < BUFFER_SIZE) return(false);
   if(CopyClose(m_symbol, PERIOD_CURRENT, 0, BUFFER_SIZE, Close) < BUFFER_SIZE) return(false);
#endif
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Returns the averaged value of candle body size                   |
//+------------------------------------------------------------------+
double COrgCandleAction::AvgBody(int ind=1)
  {
   double candle_body=0;
//--- calculate the averaged size of the candle's body
   for(int i=ind; i<ind+m_period; i++)
     {
      candle_body+=MathAbs(Open[i]-Close[i]);
     }
   candle_body=candle_body/m_period;
//--- return body size
   return(candle_body);
  }
//+------------------------------------------------------------------+
//| Returns the Add value of candle body size                        |
//+------------------------------------------------------------------+
double COrgCandleAction::AddBody(int ind=1)
  {
   double candle_body=0;
//--- calculate the averaged size of the candle's body
   for(int i=ind+1;i<ind+m_period; i++)
     {
      candle_body+=MathAbs(Open[i]-Close[i]);
     }
//--- return body size
   return(candle_body);
  }
//+------------------------------------------------------------------+
//| Checks formation of bullish patterns                             |
//+------------------------------------------------------------------+
int COrgCandleAction::CheckCandleDirection(int ind=1)
  {
   int point=0;

   if(CheckGapUp(ind)) point+=5;
   if(CheckBigWhiteCandle(ind)) point+=10;
   if(CheckLowerShadow(ind)) point+=5;
   if(CheckThreeWhiteSoldiers(ind)) point+=10; 
   if(CheckPiercingLine(ind)) point+=10;
   if(CheckBullishEngulfing(ind)) point+=10;
   if(CheckBullishHarami(ind)) point+=10;
   if(CheckMorningStar(ind)) point+=10;
   if(CheckBullishWeekMeetingLines(ind)) point+=10;;

   if(CheckGapDown(ind)) point-=5;
   if(CheckBigBlackCandle(ind)) point-=10;
   if(CheckUpperShadow(ind)) point-=5;
   if(CheckThreeBlackCrows(ind)) point-=10;
   if(CheckDarkCloudCover(ind)) point-=10;
   if(CheckBearishEngulfing(ind)) point-=10;
   if(CheckBearishHarami(ind)) point-=10;
   if(CheckEveningStar(ind)) point-=10;
   if(CheckBearishWeekMeetingLines(ind)) point-=10;
//---
   return point;
  }
//+------------------------------------------------------------------+
//| Checks formation of bullish patterns                             |
//+------------------------------------------------------------------+
bool COrgCandleAction::CheckPatternAllBullish(int ind=1)
  {
   return(
          CheckGapUp(ind)             ||
          CheckBigWhiteCandle(ind)    ||
          CheckUpperShadow(ind)       ||
          CheckThreeWhiteSoldiers(ind)||
          CheckPiercingLine(ind)      ||
          CheckBullishEngulfing(ind)  ||
          CheckBullishHarami(ind)     ||
          CheckMorningStar(ind)       ||
          CheckBullishWeekMeetingLines(ind));
  }
//+------------------------------------------------------------------+
//| Checks formation of bearish patterns                             |
//+------------------------------------------------------------------+
bool COrgCandleAction::CheckPatternAllBearish(int ind=1)
  {
   return(
          CheckGapDown(ind)         ||
          CheckBigBlackCandle(ind)  ||
          CheckLowerShadow(ind)     ||
          CheckThreeBlackCrows(ind) ||
          CheckDarkCloudCover(ind)  ||
          CheckBearishEngulfing(ind)||
          CheckBearishHarami(ind)   ||
          CheckEveningStar(ind)     ||
          CheckBearishWeekMeetingLines(ind));
  }
//+------------------------------------------------------------------+
//| Checks formation of Gap Up                                       |
//+------------------------------------------------------------------+
bool COrgCandleAction::CheckGapUp(int ind=1)
  {
//--- Gap Up
   if(Open[ind]-High[ind+1]>AvgBody(ind))
      return(true);
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Checks formation of Gap Down                                     |
//+------------------------------------------------------------------+
bool COrgCandleAction::CheckGapDown(int ind=1)
  {
//--- Gap Down
   if(Low[ind+1]-Open[ind]>AvgBody(ind))
      return(true);
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Checks formation of Big White Candle                             |
//+------------------------------------------------------------------+
bool COrgCandleAction::CheckBigWhiteCandle(int ind=1)
  {
//--- Big White Candle
   if(Close[ind]-Open[ind]>AddBody(ind))
      return(true);
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Checks formation of Big Black Candle                             |
//+------------------------------------------------------------------+
bool COrgCandleAction::CheckBigBlackCandle(int ind=1)
  {
//--- Big White Candle
   if(Open[ind]-Close[ind]>AddBody(ind))
      return(true);
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Checks formation of Lower Shadow                                 |
//+------------------------------------------------------------------+
bool COrgCandleAction::CheckLowerShadow(int ind=1)
  {
//--- Lower Shadow
   if(Close[ind]-Open[ind]>0)
     {
      if(Open[ind]-Low[ind]>AvgBody(ind)*2)
        {
         return(true);
        }
      }
   else
     {
      if(Close[ind]-Low[ind]>AvgBody(ind)*2)
        {
         return(true);
        }
      }
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Checks formation of Upper Shadow                                 |
//+------------------------------------------------------------------+
bool COrgCandleAction::CheckUpperShadow(int ind=1)
  {
//--- Upper Shadow
   if(Close[ind]-Open[ind]>0)
     {
      if(High[ind]-Close[ind]>AvgBody(ind)*2)
         return(true);
     }
   else
     {
      if(High[ind]-Open[ind]>AvgBody(ind)*2)
         return(true);
     }
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Checks formation of Three White Soldiers candlestick pattern     |
//+------------------------------------------------------------------+
bool COrgCandleAction::CheckThreeWhiteSoldiers(int ind=1)
  {
//--- 3 White Soldiers
   if((Close[ind+2]-Open[ind+2]>AvgBody(ind)) &&
      (Close[ind+1]-Open[ind+1]>AvgBody(ind)) &&
      (Close[ind]-Open[ind]>AvgBody(ind))     &&
      (MidPoint(ind+1)>MidPoint(ind+2))       &&
      (MidPoint(ind)>MidPoint(ind+1)))
      return(true);
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Checks formation of Three Black Crows candlestick pattern        |
//+------------------------------------------------------------------+
bool COrgCandleAction::CheckThreeBlackCrows(int ind=1)
  {
//--- 3 Black Crows
   if((Open[ind+2]-Close[ind+2]>AvgBody(ind)) &&
      (Open[ind+1]-Close[ind+1]>AvgBody(ind)) &&
      (Open[ind]-Close[ind]>AvgBody(ind))     &&
      (MidPoint(ind+1)<MidPoint(ind+2))       &&
      (MidPoint(ind)<MidPoint(ind+1)))
      return(true);
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Checks formation of Piercing Line candlestick pattern            |
//+------------------------------------------------------------------+
bool COrgCandleAction::CheckPiercingLine(int ind=1)
  {
//--- Piercing Line
   if((Open[ind+1]-Close[ind+1]>AvgBody(ind)) &&
      (Close[ind]>Close[ind+1])               &&
      (Close[ind]<Open[ind+1])                &&
      (MidOpenClose(ind+1)<Close[ind])        &&
      (Open[ind]<Low[ind+1]))
      return(true);
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Checks formation of Dark Cloud Cover candlestick pattern         |
//+------------------------------------------------------------------+
bool COrgCandleAction::CheckDarkCloudCover(int ind=1)
  {
//--- Dark cloud cover
   if((Close[ind+1]-Open[ind+1]>AvgBody(ind)) &&
      (Close[ind]<Close[ind+1])               &&
      (Close[ind]>Open[ind+1])                &&
      (MidOpenClose(ind+1)>Close[ind])        &&
      (Open[ind]>High[ind+1]))
      return(true);
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Checks formation of Bullish Engulfing candlestick pattern        |
//+------------------------------------------------------------------+
bool COrgCandleAction::CheckBullishEngulfing(int ind=1)
  {
//--- Bullish Engulfing
   if((Open[ind+1]>Close[ind+1])          &&
      (Close[ind]-Open[ind]>AvgBody(ind)) && 
      (Close[ind]>Open[ind+1])            &&
      (Open[ind]<Close[ind+1]))
      return(true);
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Checks formation of Bearish Engulfing candlestick pattern        |
//+------------------------------------------------------------------+
bool COrgCandleAction::CheckBearishEngulfing(int ind=1)
  {
//--- Bearish Engulfing
   if((Open[ind+1]<Close[ind+1])          &&
      (Open[ind]-Close[ind]>AvgBody(ind)) &&
      (Close[ind]<Open[ind+1])            &&
      (Open[ind]>Close[ind+1]))
      return(true);
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Checks formation of Morning Star candlestick pattern             |
//+------------------------------------------------------------------+
bool COrgCandleAction::CheckMorningStar(int ind=1)
  {
//--- Morning Star
   if((Open[ind+2]-Close[ind+2]>AvgBody(ind))              &&
      (MathAbs(Close[ind+1]-Open[ind+1])<AvgBody(ind)*0.5) &&
      (Close[ind+1]<Close[ind+2])                          &&
      (Open[ind+1]<Open[ind+2])                            &&
      (Close[ind]>MidOpenClose(ind+2)))
      return(true);
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Checks formation of Evening Star candlestick pattern             |
//+------------------------------------------------------------------+
bool COrgCandleAction::CheckEveningStar(int ind=1)
  {
//--- Evening Star
   if((Close[ind+2]-Open[ind+2]>AvgBody(ind))              && 
      (MathAbs(Close[ind+1]-Open[ind+1])<AvgBody(ind)*0.5) && 
      (Close[ind+1]>Close[ind+2])                          &&
      (Open[ind+1]>Open[ind+2])                            &&
      (Close[ind]<MidOpenClose(ind+2)))
      return(true);
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Checks formation of Bullish Harami candlestick pattern           |
//+------------------------------------------------------------------+
bool COrgCandleAction::CheckBullishHarami(int ind=1)
  {
//--- Bullish Harami
   if((Close[ind]>Open[ind])                    &&
      ((Open[ind+1]-Close[ind+1])>AvgBody(ind)) &&
      ((Close[ind]<Open[ind+1])                 &&
      (Open[ind]>Close[ind+1])))
      return(true);
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Checks formation of Bearish Harami candlestick pattern           |
//+------------------------------------------------------------------+
bool COrgCandleAction::CheckBearishHarami(int ind=1)
  {
//--- Bearish Harami
   if((Close[ind]<Open[ind])                    &&
      ((Close[ind+1]-Open[ind+1])>AvgBody(ind)) &&
      ((Close[ind]>Open[ind+1])                 &&
      (Open[ind]<Close[ind+1])))
      return(true);
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Checks formation of Bullish Meeting Lines candlestick pattern    |
//+------------------------------------------------------------------+
bool COrgCandleAction::CheckBullishWeekMeetingLines(int ind=1)
  {
//--- Bullish MeetingLines
   if((Open[ind+1]-Close[ind+1]>AvgBody(ind)*0.2)         &&
      ((Close[ind]-Open[ind])>AvgBody(ind)*0.2)           &&
      (MathAbs(Close[ind]-Close[ind+1])<0.1*AvgBody(ind)))
      return(true);
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Checks formation of Bearish Meeting Lines candlestick pattern    |
//+------------------------------------------------------------------+
bool COrgCandleAction::CheckBearishWeekMeetingLines(int ind=1)
  {
//--- Bearish MeetingLines
   if((Close[ind+1]-Open[ind+1]>AvgBody(ind)*0.2)            &&
      ((Open[ind]-Close[ind])>AvgBody(ind)*0.2)              &&
      (MathAbs(Close[ind]-Close[ind+1])<0.1*AvgBody(ind)))
      return(true);
//---
   return(false);
  }
//+------------------------------------------------------------------+

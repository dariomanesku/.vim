XPTemplate priority=like

XPT once wrap	" #ifndef .. #define ..
XSET symbol=headerSymbol()
#ifndef `symbol^
#define `symbol^

`cursor^
#endif `$CL^ `symbol^ `$CR^


XPT maronce wrap	" #ifndef .. #define ..
XSET symbol=headerSymbol("MAR")
#ifndef `symbol^
#define `symbol^

`cursor^
#endif `$CL^ `symbol^ `$CR^

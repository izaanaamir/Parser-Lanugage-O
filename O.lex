/* For better readibilty of the resulting tokens, remove the last 2 lines of the regular expresions so as not to remove all the indentations and white spaces */
%option yylineno 

digit [0-9]
alphabet [a-zA-Z]
alphanumeric [a-zA-Z0-9]

%%
(#.*)|((\/\*)+[^\*]*(\*\/)+)        return(COMMENT);
main                                return(MAIN);
true                                return(TRUE);
false                               return(FALSE);
int                                 return(INT);
bool                                return(BOOL);
string                              return(STRING);
void                                return(VOID);
final                               return(FINAL);
if                                  return(IF);
else                                return(ELSE);
for                                 return(FOR);
while                               return(WHILE);
return                              return(RETURN);
print                               return(PRINT);
scan                                return(SCAN);
length                              return(LENGTH);
str                                 return(STR);
readInclination                     return(READ_INCLINATION);
readAltitude                        return(READ_ALTITUDE);
readTemperature                     return(READ_TEMPERATURE);
readAcceleration                    return(READ_ACCELERATION);
readCurrentTimestamp                return(READ_CURRENT_TIMESTAMP);
turnOnCamera                        return(TURN_ON_CAMERA);
turnOffCamera                       return(TURN_OFF_CAMERA);
takePicture                         return(TAKE_PICTURE);
initiateConnection                  return(INITIATE_CONNECTION);
terminateConnection                 return(TERMINATE_CONNECTION);
\*\*                                return(EXP_OP);
\*                                  return(MULT_OP);
\/                                  return(DIV_OP);
&                                   return(AND_OP);
\|                                  return(OR_OP);
\^                                  return(XOR_OP);
!                                   return(NOT_OP);
>                                   return(GT_OP);
\<                                  return(LT_OP);
>=                                  return(GTE_OP);
\<=                                 return(LTE_OP);
==                                  return(EQ_OP);
!=                                  return(NEQ_OP);
\;                                  return(SC);
\.                                  return(DOT);
\(                                  return(LP);
\)                                  return(RP);
\{                                  return(LCP);
\}                                  return(RCP);
,                                   return(COMMA);
=                                   return(ASSIGN_OP);
(\+\+)                              return(INC_OP);
(--)                                return(DEC_OP);
\+                                  return(PLUS);
-                                   return(MINUS);
{digit}+			    return(INTEGER);
{alphabet}({alphanumeric}|_)*	    return(IDENTIFIER);
\"([^\n\\\"]|\\.)*\"		    return(STRING_LIT);
[ \n\t\r]				    ;
.				    return(yytext[0]);
%%
int yywrap() {return 1;}

%{
#include <math.h>
#include<string.h>
#include "y.tab.h"
%}

      
DIGIT    [1-9][0-9]*
%%


[a-zA-Z]+      {
                    yylval.stringValue=strdup(yytext);
                    return TEXT;
            }

{DIGIT}       {
            printf( "A bullet number: %s (%g)\n", yytext,
                    atof( yytext ) );
                    yylval.iValue = atoi(yytext); 
                    return DIGIT;
            }

"//*"|"*//"|"--"|"....."|"["|"]"|"*"|"+"|"<"|">>"|"!"      {
                return *yytext;
            }
            


[ \t\n]+          /* eat up whitespace */



%%

int yywrap(void) {    
return 1; 
}
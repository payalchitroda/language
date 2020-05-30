%{
#include <math.h>
%}

TEXT       [a-zA-Z]+
DIGIT    [1-9][0-9]*
%%


{TEXT}       {
            printf( "A text: %s (%g)\n", yytext,
                    atof( yytext ) );
            }

{DIGIT}       {
            printf( "A bullet number: %s (%g)\n", yytext,
                    atof( yytext ) );
            }

"//*"|"*//"       {
            printf( "A label operator: %s (%g)\n", yytext,
                    atof( yytext ) );
            }
            
"-----"|"--"      {
            printf( "A input operator: %s (%g)\n", yytext,
                    atof( yytext ) );
            }

"."|"-"    {
            printf( "A bullet operator: %s (%g)\n", yytext,
                    atof( yytext ) );
            }
        
"["|"]"      {
            printf( "A checkbox operator: %s (%g)\n", yytext,
                    atof( yytext ) );
            }
        
"*"|"-+"|"+-"      {
            printf( "A style operator: %s (%g)\n", yytext,
                    atof( yytext ) );
            }

"\\"      {
            printf( "A special symbol: %s (%g)\n", yytext,
                    atof( yytext ) );
            }

"<"|">"      {
            printf( "A row operator: %s (%g)\n", yytext,
                    atof( yytext ) );
            } 

"|"      {
            printf( "A column operator: %s (%g)\n", yytext,
                    atof( yytext ) );
            } 


[ \t\n]+          /* eat up whitespace */



%%

int yywrap(){} 
int main( argc, argv )
int argc;
char **argv;
    {
    ++argv, --argc;  /* skip over program name */
    if ( argc > 0 )
            yyin = fopen( argv[0], "r" );
    else
            yyin = stdin;

    yylex();
    }
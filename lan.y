%{    
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
char *labeltag(char *str);
char *placeholderinputtag(char *str);
void freespace(char *str);
void htmlfile(char *str);
char *checkboxtag(char *str);
char *boldtag(char *str);
char *italictag(char *str);
char *listtag(char *str);
int yylex(void);
void yyerror(char *); 

%}
%union {
 int iValue; 
 char *stringValue;
}; 
%token <stringValue> TEXT
%token <iValue> DIGIT

%%

start:
    field '!'   {system("ls");}

field:       
    label                  
    |input
    |bullet
    |styletext
    |checkbox
    |row
    |field label                
    |field input
    |field bullet
    |field styletext
    |field checkbox
    |field row
    ;

    ;

label:
    '//*' TEXT '*//'   {   $<stringValue>$=labeltag($<stringValue>2); htmlfile($<stringValue>$);  printf("%s",$<stringValue>$);   freespace($<stringValue>$);}  
    |
    ;
input: 
    simpleinput
    |placeholderinput       
	|input simpleinput                         
	|input placeholderinput                     
	; 
simpleinput: 
    '.....'                  { htmlfile("<input type=\"text\">"); printf("<input type=\"text\">");}                            
	|
    ;
placeholderinput:
    '--' TEXT '--'        {  $<stringValue>$=placeholderinputtag($<stringValue>2); htmlfile($<stringValue>$);  printf("%s",$<stringValue>$);  freespace($<stringValue>$); }                     
	|
    ; 
checkbox:        
	'[' TEXT ']'                 { $<stringValue>$=checkboxtag($<stringValue>2); htmlfile($<stringValue>$);  printf("%s",$<stringValue>$); }         
    |                       
	; 
row:        
    '>>'                 { htmlfile("<br>"); printf("<br>");}                                      
	|
    ;

styletext:        
    boldtext                                     
	|italictext
    |styletext boldtext                                   
	|styletext italictext
    ;  
boldtext:        
	'*' TEXT '*'                  { $<stringValue>$=boldtag($<stringValue>2); htmlfile($<stringValue>$);  printf("%s",$<stringValue>$); } 
    |                   
	;
italictext:        
	'+' TEXT '+'                { $<stringValue>$=italictag($<stringValue>2); htmlfile($<stringValue>$);  printf("%s",$<stringValue>$); } 
    |                     
	;
bullet:                
	'<' TEXT                  { $<stringValue>$=listtag($<stringValue>2); htmlfile($<stringValue>$);  printf("%s",$<stringValue>$); }   
    |                       
	;



%%
void htmlfile(char *str)
{
    FILE *filePointer ;
    filePointer = fopen("intermediate.html", "a") ;
    if ( filePointer == NULL )
    {
        printf( "failed to open." ) ;
    }
    else
    {

        if ( strlen (  str  ) > 0 )
        {
            fputs(str, filePointer) ;
            fputs("\n", filePointer) ;
        }
        fclose(filePointer) ;
    }
}
void freespace(char *str)
{

    free(str);
}

char *labeltag(char *str)
{
    char *temp=(char*)malloc(30*sizeof(char));
    strcpy(temp,"<label>");
    strcat(temp,str);
    strcat(temp,"</label>");
    return temp;
}

char *placeholderinputtag(char *str)
{
    char *temp=(char*)malloc(50*sizeof(char));
    strcpy(temp,"<input type=\"text\" placeholder=\"");
    strcat(temp,str);
    strcat(temp,"\">");
    return temp;
}

char *checkboxtag(char *str)
{
    char *temp=(char*)malloc(100*sizeof(char));
    strcpy(temp,"<input type=\"checkbox\" id=\"");
    strcat(temp,str);
    strcat(temp,"\">");
    strcat(temp,"<label for=\"");
    strcat(temp,str);
    strcat(temp,"\">");
    strcat(temp,str);
    strcat(temp,"</label>");
    return temp;
}
char *boldtag(char *str)
{
    char *temp=(char*)malloc(30*sizeof(char));
    strcpy(temp,"<b>");
    strcat(temp,str);
    strcat(temp,"</b>");
    return temp;
}

char *italictag(char *str)
{
    char *temp=(char*)malloc(30*sizeof(char));
    strcpy(temp,"<i>");
    strcat(temp,str);
    strcat(temp,"</i>");
    return temp;
}

char *listtag(char *str)
{
    char *temp=(char*)malloc(30*sizeof(char));
    strcpy(temp,"<li>");
    strcat(temp,str);
    strcat(temp,"</li>");
    return temp;
}

void yyerror(char *s) {    
	fprintf(stderr, "%s\n", s); 
} 
int main(void) {    
	yyparse();    
	return 0; 
}
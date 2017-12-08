%{
#include <stdio.h>
#include <string.h>
#include "y.tab.c"
int lines = 1;
%}


id-n		[a-zA-Z_]
digit   	[0-9]
id 		{id-n}({id-n}|{digit}*)*
int_const	[1-9]{digit}*
digit_seq	{digit}+
fract_cont	{digit_seq}?\.{digit_seq}|{digit_seq}\.
exp_part	[eE][+-]?{digit_seq}
float_const	{fract_cont}{exp_part}?|{digit_seq}{exp_part}
escape_seq	\\[\\\?nabfnrtv\'\"]
c_char 		[^'\\\n]|{escape_seq}
c_char_seq	{c_char}+
char_const	\'{c_char_seq}\'
const 		[0]|{int_const}|{float_const}|{char_const}
s_char		{c_char}
s_char_seq	{s_char}+
string_lit	\"{s_char_seq}?\"
punc 		[+]|[-]|[\[]|[\]]|[\(]|[\)]|[\{]|[\}]|[\.]|[&]|[\*]|[~]|[!]|[\/]|[\%]|[<]|[>]|[\^]|[\|]|[\?]|[:]|[\;]|[,]|[#]|[=]
%x			mult_comment 
%x			comment

%%

"break"				{return(BREAK);}
"return"			{return(RETURN);}
"unsigned"			{return(UNSIGNED);}
"void"				{return(VOID);}
"case"				{return(CASE);}
"float"				{return(FLOAT);}
"short"				{return(SHORT);}
"char"				{return(CHAR);}
"for"				{return(FOR);}
"signed"			{return(SIGNED);}
"while"				{return(WHILE);}
"goto"				{return(GOTO);}
"Bool"				{return(BOOL);}
"continue"			{return(CONTINUE);}
"if"				{return(IF);}
"default"			{return(DEFAULT);}
"do"				{return(DO);}
"int"				{return(INT);}
"switch"			{return(SWITCH);}
"double"			{return(DOUBLE);}
"long"				{return(LONG);}
"else"				{return(ELSE);}
"Matrix"			{return(MATRIX);}	
{id}				{char* temp = new char(100);
					strcpy(temp,yytext);
					yylval.id.name = temp;
					return(IDENTIFIER);}
{int_const}			{yylval.intVal = atoi(yytext);return(INT_CONSTANT);}
{float_const}		{yylval.dbVal = atof(yytext);return(FLOAT_CONSTANT);}
{char_const}		{if(yytext[1] == '\\') 
                        switch(yytext[2])
                        {
                        	case 'n' : yylval.charVal = '\n';
                        				break;
                        	case '?' : yylval.charVal = '\?';
                        				break;
                        	case '\\' : yylval.charVal = '\\';
                        				break;
                        	case 'a' : yylval.charVal = '\n';
                        				break;
                        	case 'b' : yylval.charVal = '\n';
                        				break;
                        	case 'f' : yylval.charVal = '\f';
                        				break;
                        	case 'r' : yylval.charVal = '\r';
                        				break;
                        	case 't' : yylval.charVal = '\t';
                        				break;
                        	case 'v' : yylval.charVal = '\v';
                        				break;
                        	case '\'' : yylval.charVal = '\'';
                        				break;
                        	case '\"' : yylval.charVal = '\"';
                        				break;
                        					}
                    else yylval.charVal=yytext[1];
                    return(CHAR_CONSTANT);}
[0]					{yylval.intVal = 0;return(ZERO_CONSTANT);}
{string_lit}		{yylval.stringVal = yytext;return(STRING_LITERAL);}

"++"				{return(PLUSPLUS);}
"--"				{return(MINMIN);}
"->"				{return(DASHARROW);}
"<<"				{return(LSHIFT);}
">>"				{return(RSHIFT);}
"<="				{return(LTE);}
">="				{return(GTE);}
"=="				{return(EQUALS);}
"!="				{return(NEQUALS);}
"&&"				{return(LAND);}
"||"				{return(LOR);}
"*="				{return(STAREQ);}
"/="				{return(DIVEQ);}
"%="				{return(MODEQ);}
"+="				{return(PLUSEQ);}
"-="				{return(MINEQ);}
"<<="				{return(LSHIFTEQ);}
">>="				{return(RSHIFTEQ);}
"&="				{return(ANDEQ);}
"^="				{return(POWEQ);}
"|="				{return(OREQ);}
".'"				{return(DOTQUOTE);}

{punc} 				{return(yytext[0]);}

[ \t\f\r\n]			{}

"/*"				BEGIN(mult_comment);
<mult_comment>[^\*\n]*
<mult_comment>"*"+[^\*/\n]*
<mult_comment>\n 		{lines ++;}					
<mult_comment>"*"+"/"		{BEGIN(INITIAL);
				lines = 1;
						}

"//"				BEGIN(comment);
<comment>[^\n]*
<comment>\n 			{BEGIN(INITIAL);}

.				{return(ERR);}


%%

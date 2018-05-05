%option noyywrap
%x COMMENT

%{
#include<stdio.h>
#include<stdlib.h>

int line_count=1;
int i,j;
int error_count=0;
char c[1000];

FILE *logout;
FILE *tokenout;

%}
UCN (\\u[0-9a-fA-F]{4}|\\U[0-9a-fA-F]{8})
WHITESPACE [ \t\f\r\v]+ 
LETTER [a-zA-Z]
ID [A-Za-z_][A-Za-z0-9_]*
DIGIT [0-9]
NEWLINE \n
FLOAT ([0-9]*\.?[0-9]+|[0-9]+\.)(E-?[0-9]+)?
CHARFORM ([^'\\]|\\['"?\\abfnrtv]|\\[0-7]{1,3}|\\[Xx][0-9a-fA-F]+|{UCN})+
CHAR \'{CHARFORM}\'
STRING \"(.*\\{NEWLINE})*.*\"
SCOMMENT \/\/(.*\\{NEWLINE})*.*
MCOMMENT \/\*(.*{NEWLINE})*.*\*\/
TOODECIMAL {DIGIT}\.{DIGIT}(\.{DIGIT}*)+
%%

{NEWLINE} {line_count++;}

"if"	{
			fprintf(tokenout,"<IF>");
			fprintf(logout,"Line no %d: TOKEN <IF> Lexeme %s found\n",line_count,yytext);
		}
		
"else"	{
			fprintf(tokenout,"<ELSE>");
			fprintf(logout,"Line no %d: TOKEN <ELSE> Lexeme %s found\n",line_count,yytext);
		}

"for"	{
			fprintf(tokenout,"<FOR>");
			fprintf(logout,"Line no %d: TOKEN <FOR> Lexeme %s found\n",line_count,yytext);
		}

"while"	{
			fprintf(tokenout,"<WHILE>");
			fprintf(logout,"Line no %d: TOKEN <WHILE> Lexeme %s found\n",line_count,yytext);
		}
		
"do"	{
			fprintf(tokenout,"<DO>");
			fprintf(logout,"Line no %d: TOKEN <DO> Lexeme %s found\n",line_count,yytext);
		}

"break"	{
			fprintf(tokenout,"<BREAK>");
			fprintf(logout,"Line no %d: TOKEN <BREAK> Lexeme %s found\n",line_count,yytext);
		}

"int"	{
			fprintf(tokenout,"<INT>");
			fprintf(logout,"Line no %d: TOKEN <INT> Lexeme %s found\n",line_count,yytext);
		}
		
"char"	{
			fprintf(tokenout,"<CHAR>");
			fprintf(logout,"Line no %d: TOKEN <CHAR> Lexeme %s found\n",line_count,yytext);
		}

"float"	{
			fprintf(tokenout,"<FLOAT>");
			fprintf(logout,"Line no %d: TOKEN <FLOAT> Lexeme %s found\n",line_count,yytext);
		}

"double"	{
			fprintf(tokenout,"<DOUBLE>");
			fprintf(logout,"Line no %d: TOKEN <DOUBLE> Lexeme %s found\n",line_count,yytext);
		}
		
"void"	{
			fprintf(tokenout,"<VOID>");
			fprintf(logout,"Line no %d: TOKEN <VOID> Lexeme %s found\n",line_count,yytext);
		}

"return"	{
			fprintf(tokenout,"<RETURN>");
			fprintf(logout,"Line no %d: TOKEN <RETURN> Lexeme %s found\n",line_count,yytext);
		}

"switch"	{
			fprintf(tokenout,"<SWITCH>");
			fprintf(logout,"Line no %d: TOKEN <SWITCH> Lexeme %s found\n",line_count,yytext);
		}

"case"	{
			fprintf(tokenout,"<CASE>");
			fprintf(logout,"Line no %d: TOKEN <CASE> Lexeme %s found\n",line_count,yytext);
		}

"default"	{
			fprintf(tokenout,"<DEFAULT>");
			fprintf(logout,"Line no %d: TOKEN <DEFAULT> Lexeme %s found\n",line_count,yytext);
		}
		
"continue"	{
			fprintf(tokenout,"<CONTINUE>");
			fprintf(logout,"Line no %d: TOKEN <CONTINUE> Lexeme %s found\n",line_count,yytext);
		}

"+"		|

"-"		{
			fprintf(tokenout,"<ADDOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <ADDOP> Lexeme %s found\n",line_count,yytext);
			//insert in symbol table and print symbol table content(only non empty buckets)
			// There is a '|' in "+"'s rule, this means match execute the action for following rule
		}

"*"		|

"/"		|

"%"		{
			fprintf(tokenout,"<MULOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <MULOP> Lexeme %s found\n",line_count,yytext);
		}

"++"		|

"--"	{
			fprintf(tokenout,"<INCOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <INCOP> Lexeme %s found\n",line_count,yytext);
		}

"<"		|

"<="	|

">"		|

">="	|

"=="	|

"!="	{
			fprintf(tokenout,"<RELOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <RELOP> Lexeme %s found\n",line_count,yytext);
		}

"="		{
			fprintf(tokenout,"<ASSIGNOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <ASSIGNOP> Lexeme %s found\n",line_count,yytext);
		}

"&&"	|

"||"	{
			fprintf(tokenout,"<LOGICOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <LOGICOP> Lexeme %s found\n",line_count,yytext);
		}

"&"		|

"|"		|

"^"		|

"<<"	|

">>"	{
			fprintf(tokenout,"<BITOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <BITOP> Lexeme %s found\n",line_count,yytext);
		}

"!"		{
			fprintf(tokenout,"<NOT,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <NOT> Lexeme %s found\n",line_count,yytext);
		}

"("		{
			fprintf(tokenout,"<LPAREN,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <LPAREN> Lexeme %s found\n",line_count,yytext);
		}

")"		{
			fprintf(tokenout,"<RPAREN,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <RPAREN> Lexeme %s found\n",line_count,yytext);
		}

"{"		{
			fprintf(tokenout,"<LCURL,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <LCURL> Lexeme %s found\n",line_count,yytext);
		}

"}"		{
			fprintf(tokenout,"<RCURL,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <RCURL> Lexeme %s found\n",line_count,yytext);
		}

"["		{
			fprintf(tokenout,"<LTHIRD,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <LTHIRD> Lexeme %s found\n",line_count,yytext);
		}

"]"		{
			fprintf(tokenout,"<RTHIRD,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <RTHIRD> Lexeme %s found\n",line_count,yytext);
		}

","		{
			fprintf(tokenout,"<COMMA,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <COMMA> Lexeme %s found\n",line_count,yytext);
		}

";"		{
			fprintf(tokenout,"<SEMICOLON,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <SEMICOLON> Lexeme %s found\n",line_count,yytext);
		}

{ID}	{
			fprintf(tokenout,"<ID,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <ID> Lexeme %s found\n",line_count,yytext);
			//insert in symbol table and print symbol table content(only non empty buckets)
		}

{DIGIT}+[A-Za-z0-9_]+ {
				error_count++;
				fprintf(logout,"Error at line:%d Invalid Suffix on numeric constant or invalid prefix on identifier %s\n",line_count,yytext);
			}
		
{DIGIT}+ 	{
				fprintf(tokenout,"<CONST_INT,%s>",yytext);
				fprintf(logout,"Line no %d: TOKEN <CONST_INT> Lexeme %s found\n",line_count,yytext);
				//insert in symbol table and print symbol table content(only non empty buckets)
			}

{TOODECIMAL} {
				error_count++;
				fprintf(logout,"Error at line:%d Too many decimal point error for character sequence like %s\n",line_count,yytext);
			}


([0-9]*\.?[0-9]+|[0-9]+\.)(E-?[0-9]+\.[0-9]+) {
				error_count++;
				fprintf(logout,"Error at line:%d Ill formed number such as %s\n",line_count,yytext);
			}

\'{CHARFORM}{CHARFORM}+\' {
				error_count++;
				fprintf(logout,"Error at line:%d Multi character constant error for character sequence like %s\n",line_count,yytext);
			}

\'[A-Za-z0-9]*$ {
				error_count++;
				fprintf(logout,"Error at line:%d Unfinished character such as %s\n",line_count,yytext);
			}

{WHITESPACE}

{FLOAT}		{
				fprintf(tokenout,"<CONST_FLOAT,%s>",yytext);
				fprintf(logout,"Line no %d: TOKEN <CONST_FLOAT> Lexeme %s found\n",line_count,yytext);
				//insert in symbol table and print symbol table content(only non empty buckets)
			}

{CHAR}		{
				if(yytext[1]!='\\')
					c[0]=yytext[1];
				else
				{
					if(yytext[2]=='a')
						c[0]='\a';
					else if(yytext[2]=='b')
						c[0]='\b';
					else if(yytext[2]=='f')
						c[0]='\f';
					else if(yytext[2]=='n')
						c[0]='\n';
					else if(yytext[2]=='r')
						c[0]='\r';
					else if(yytext[2]=='t')
						c[0]='\t';
					else if(yytext[2]=='v')
						c[0]='\v';
					else if(yytext[2]=='"')
						c[0]='\"';
				}
				fprintf(tokenout,"<CONST_CHAR,%c>",*c);
				fprintf(logout,"Line no %d: TOKEN <CONST_CHAR> Lexeme %s found\n",line_count,yytext);
				c[0]=0;
				//insert in symbol table and print symbol table content(only non empty buckets)
			}


{STRING}	{	
				j=0;
				for(i=1;i<strlen(yytext)-1;i++)
				{
					if((yytext[i]=='\\')&&(yytext[i+1]!='a')&&(yytext[i+1]!='b')&&(yytext[i+1]!='n')&&(yytext[i+1]!='r')&&(yytext[i+1]!='t')&&(yytext[i+1]!='v')&&(yytext[i+1]!='f'))
					{
						line_count++;
						c[j]='\t';
						i++;
					}
					else if((yytext[i]=='\\')&&(yytext[i+1]=='a'))
					{
						c[j]='\a';
						i++;
					}
					else if((yytext[i]=='\\')&&(yytext[i+1]=='b'))
					{
						c[j]='\b';
						i++;
					}
					else if((yytext[i]=='\\')&&(yytext[i+1]=='f'))
					{
						c[j]='\f';
						i++;
					}
					else if((yytext[i]=='\\')&&(yytext[i+1]=='n'))
					{
						c[j]='\n';
						i++;
					}
					else if((yytext[i]=='\\')&&(yytext[i+1]=='r'))
					{
						c[j]='\r';
						i++;
					}
					else if((yytext[i]=='\\')&&(yytext[i+1]=='t'))
					{
						c[j]='\t';
						i++;
					}
					else if((yytext[i]=='\\')&&(yytext[i+1]=='v'))
					{
						c[j]='\v';
						i++;
					}
					else
					{
						c[j]=yytext[i];
					}
					j++;
				}
				fprintf(tokenout,"<STRING,%s>",c);
				fprintf(logout,"Line no %d: TOKEN <STRING> Lexeme %s found\n",line_count,yytext);
				while(j!=0)
				{
					c[j]=0;
					j--;
				}
				//insert in symbol table and print symbol table content(only non empty buckets)
			}

\"[ !#-~]* {
				error_count++;
				fprintf(logout,"Error at line:%d Unfinished string\n",line_count);
			}

\"([ !#-~]*\\{NEWLINE})+[ !#-~]* {
				error_count++;
				fprintf(logout,"Error at line:%d Unfinished string\n",line_count);
				for(i=0;i<strlen(yytext);i++)
				{
					if(yytext[i]=='\n')
						line_count++;
				}
			}

\/\*[^(\*\/)]* {
				error_count++;
				fprintf(logout,"Error at line:%d Unfinished comment\n",line_count);
			}

{SCOMMENT}	{
				
				for(i=0;i<strlen(yytext);i++)
				{
					if(yytext[i]=='\\')
						line_count++;
				}
			}

{MCOMMENT}	{
				
				for(i=0;i<strlen(yytext);i++)
				{
					if(yytext[i]=='\n')
						line_count++;
				}
			}

.			{
				error_count++;
				fprintf(logout,"Error at line:%d Unrecognized character like %s\n",line_count,yytext);
			}


%%

int main(int argc,char *argv[]){
	
	if(argc!=2){
		printf("Please provide input file name and try again\n");
		return 0;
	}
	
	FILE *fin=fopen(argv[1],"r");
	if(fin==NULL){
		printf("Cannot open specified file\n");
		return 0;
	}
	
	logout= fopen("log.txt","w");
	tokenout= fopen("token.txt","w");

	yyin= fin;
	yylex();
	fprintf(logout,"total error number:%d",error_count);
	fclose(yyin);
	fclose(tokenout);
	fclose(logout);
	return 0;
}

%option noyywrap

%{
#include "parser.tab.h"
#include <string.h>
#include <stdlib.h>

extern int token_count;
%}

%%

R[0-9]+        { token_count++; yylval.str = strdup(yytext); return RADIUS1; }
r[0-9]+        { token_count++; yylval.str = strdup(yytext); return RADIUS2; }
h[0-9]+        { token_count++; yylval.str = strdup(yytext); return HEIGHT; }

"compute"      { token_count++; return COMPUTE; }
"volume"       { token_count++; return VOLUME; }

[ \t\r\n]+     { /* skip whitespace */ }
.              { /* ignore anything else */ }

%%

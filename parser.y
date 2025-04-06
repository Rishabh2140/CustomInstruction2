%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>           /* for M_PI */

int token_count = 0;       /* only definition */
int temp_count  = 0;

char* new_temp(void) {
    char *buf = malloc(16);
    sprintf(buf, "t%d", temp_count++);
    return buf;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int yylex(void);
%}

%union {
    char *str;
}

%token  <str> RADIUS1 RADIUS2 HEIGHT
%token        COMPUTE VOLUME

%%

input:
    RADIUS1 RADIUS2 HEIGHT COMPUTE VOLUME {
        char *R = $1, *r = $2, *h = $3;

        /* Generate 3‑address code */
        char *t1 = new_temp();  /* R^2 */
        char *t2 = new_temp();  /* R*r */
        char *t3 = new_temp();  /* r^2 */
        char *t4 = new_temp();  /* R^2 + Rr */
        char *t5 = new_temp();  /* + r^2 */
        char *t6 = new_temp();  /* * h */
        char *t7 = new_temp();  /* * pi */

        printf("MUL %s, %s, %s     # R^2\n",     t1, R, R);
        printf("MUL %s, %s, %s     # R*r\n",     t2, R, r);
        printf("MUL %s, %s, %s     # r^2\n",     t3, r, r);
        printf("ADD %s, %s, %s     # R^2 + Rr\n",  t4, t1, t2);
        printf("ADD %s, %s, %s     # + r^2\n",     t5, t4, t3);
        printf("MUL %s, %s, %s     # * h\n",      t6, t5, h);
        printf("MUL %s, %s, %f  # * pi\n",       t7, t6, M_PI);
        printf("DIV volume, %s, 3  # Final Volume\n\n", t7);

        /* Print token count */
        printf("Total Tokens: %d\n", token_count);

        /* --- Now compute and display the numeric volume --- */
        double R_val = strtod(R + 1, NULL);   /* skip leading 'R' */
        double r_val = strtod(r + 1, NULL);   /* skip leading 'r' */
        double h_val = strtod(h + 1, NULL);   /* skip leading 'h' */
        double V_val = M_PI * h_val * (R_val*R_val + R_val*r_val + r_val*r_val) / 3.0;
        printf("Computed Volume: %f\n", V_val);
    }
    ;

%%

int main(void) {
    /* show input format */
    printf("Input format: R<radius1> r<radius2> h<height> compute volume\n");
    return yyparse();
}

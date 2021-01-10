%{ int yylex(void); extern int yylineno;%}

%token COMMENT MAIN TRUE FALSE INT BOOL STRING VOID FINAL IF ELSE FOR WHILE RETURN PRINT SCAN LENGTH STR READ_INCLINATION READ_ALTITUDE READ_TEMPERATURE READ_ACCELERATION READ_CURRENT_TIMESTAMP TURN_ON_CAMERA TURN_OFF_CAMERA TAKE_PICTURE INITIATE_CONNECTION TERMINATE_CONNECTION EXP_OP MULT_OP DIV_OP AND_OP OR_OP XOR_OP NOT_OP GT_OP LT_OP GTE_OP LTE_OP EQ_OP NEQ_OP SC DOT LP RP LCP RCP COMMA ASSIGN_OP INC_OP DEC_OP PLUS MINUS INTEGER IDENTIFIER STRING_LIT

%start program_entry

%%

program_entry : VOID MAIN LP RP LCP program RCP {printf("Input program is valid\n"); return 0; };

program : empty | stmt_list ;

empty : ;

stmt_list : stmt_list stmt | stmt ;

stmt : matched | unmatched ;

matched : IF LP expr RP matched ELSE matched | non_if_stmt ;

non_if_stmt : COMMENT | empty SC | block | decl_stmt | assign_stmt | func_def | for_stmt | while_stmt | void_func_call ;

unmatched : IF LP expr RP stmt | IF LP expr RP matched ELSE unmatched ;

block : LCP program RCP ;

decl_stmt : data_type IDENTIFIER SC ;

assign_stmt : assign | const_assign ;

assign : decl_assign | non_decl_assign ;

decl_assign : data_type IDENTIFIER ASSIGN_OP expr SC ;

const_assign : FINAL data_type IDENTIFIER ASSIGN_OP literal SC ;

non_decl_assign : IDENTIFIER ASSIGN_OP expr SC | IDENTIFIER INC_OP SC | IDENTIFIER DEC_OP SC ;

literal : bool_lit | INTEGER | STRING_LIT ;

bool_lit : TRUE | FALSE ;

data_type : INT | BOOL | STRING ;

expr : relat_expr | non_relat_expr ;

relat_expr : LP relat_expr RP | non_relat_expr EQ_OP non_relat_expr | non_relat_expr NEQ_OP non_relat_expr | non_relat_expr GTE_OP non_relat_expr | non_relat_expr LTE_OP non_relat_expr | non_relat_expr GT_OP non_relat_expr | non_relat_expr LT_OP non_relat_expr ;

non_relat_expr : non_relat_expr OR_OP xor_expr | xor_expr ;

xor_expr : xor_expr XOR_OP and_expr | and_expr ;

and_expr : and_expr AND_OP add_expr | add_expr ;

add_expr : add_expr PLUS sub_expr | sub_expr ;

sub_expr : sub_expr MINUS mult_expr | mult_expr ;

mult_expr : mult_expr MULT_OP div_expr | div_expr ;

div_expr : div_expr DIV_OP exp_expr | exp_expr ;

exp_expr : rem_expr EXP_OP exp_expr | rem_expr ;

rem_expr : brac_expr INC_OP | brac_expr DEC_OP | MINUS brac_expr | PLUS brac_expr | NOT_OP brac_expr | brac_expr ;

brac_expr : LP non_relat_expr RP | smpl_expr ;

smpl_expr : IDENTIFIER | literal | func_rtrn | prim_func_rtrn ;

prim_func_rtrn : prim_bool_rtrn | prim_int_rtrn ;

prim_bool_rtrn : TURN_ON_CAMERA LP RP | TURN_OFF_CAMERA LP RP ;

prim_int_rtrn : LENGTH LP IDENTIFIER RP | STR LP expr RP | READ_INCLINATION LP RP | READ_ALTITUDE LP RP | READ_TEMPERATURE LP RP | READ_ACCELERATION LP RP | READ_CURRENT_TIMESTAMP LP RP ;

void_func_call : func_rtrn SC | prim_void_rtrn ;

prim_void_rtrn : PRINT LP expr RP SC | PRINT LP expr COMMA IDENTIFIER RP SC | SCAN LP IDENTIFIER RP SC | SCAN LP IDENTIFIER COMMA IDENTIFIER RP SC | TAKE_PICTURE LP RP SC | INITIATE_CONNECTION LP smpl_expr COMMA expr RP SC | TERMINATE_CONNECTION LP RP SC ;

func_rtrn : IDENTIFIER LP param_call_list RP | IDENTIFIER LP empty RP ;

param_call_list : param_call_list COMMA param_call | param_call ;

param_call : expr ;

func_def : data_type_func | void_func ;

data_type_func : data_type IDENTIFIER LP param_list RP LCP program rtrn_stmt RCP | data_type IDENTIFIER LP empty RP LCP program rtrn_stmt RCP ;

rtrn_stmt : RETURN expr SC ;

void_func : VOID IDENTIFIER LP param_list RP block | VOID IDENTIFIER LP empty RP block ;

param_list : param_list COMMA param | param ;

param : data_type IDENTIFIER ;

for_stmt : FOR LP assign relat_expr SC add_expr RP block ;

while_stmt : WHILE LP expr RP block ;

%%
#include "lex.yy.c"
int yyerror(char* s) {
    fprintf(stderr, "%s on line %d!\n", s, yylineno);
    return 1;
}

int main (){
    return yyparse();
}

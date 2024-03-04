%{
#include <stdio.h>
#include "syntax_tree.h"

int yylex(void);
void yyerror(const char *s);
int yyparse();

//Global syntax tree
struct TreeNode *gt;
%}

%union { struct TreeNode *node; char op;}

%token <op> INT MAIN LPAREN RPAREN LBRACE RBRACE SEMICOLON NEWLINE RETURN
%type <node> program statement statements
%start program 

%%
program: INT MAIN LPAREN RPAREN LBRACE statements RBRACE
	{ gt = createTreeNode("Program");  //gt 是一个全局变量
          $$ = gt;
          $$->left = $6; };

statements: statement { $$ = createTreeNode("statements");
                        $$->left = $1; };

statement: SEMICOLON 
         { $$ = createTreeNode("EmptyStatement"); }
         | RETURN SEMICOLON
         { $$ = createTreeNode("ReturnStatement"); };
%%

/* C代码部分 */
struct TreeNode *parse()
{
  yyparse();
  return gt;  //生成的语法树
}

void yyerror(const char *s)
{
  fprintf(stderr, "%s\n", s);
}
program <- int main() {statements }
statements <- statement
statement <-;|return;

progarm: INT MAIN LPAREN RPAREN LBRACE statemnets RBRACE
	{ gt = createTreeNode("Program");  //gt 是一个全局变量
          $$ = gt;
          $$->left = $6; };

statements: statement { $$ = createTreeNode("statements");
                        $$->left = $1; };

statement: SEMICOLON 
         { $$ = createTreeNode("EmptyStatement"); }
         | RETURN SEMICOLON
         { $$ = createTreeNode("ReturnStatement"); };

struct TreeNode {
  char* type;
  struct TreeNode* left;
  struct TreeNode* right;
};

%union {
  struct TreeNode* node;
  char op;
}

%token INT MAIN LPAREN RPAREN LBRACE RBRACE SEMICOLON RETURN
%type <node> program statement statements
%start progarm


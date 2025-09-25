// USER CODE SECTION ====================

// Array as Symbol table
import java.util.ArrayList;
import java.util.List;

// OPTION DECLARATION SECTION ===========
%%

// name of genarated Java class "Lexer.java"
%class Lexer

// Tell Jflex to support Unicode input
%unicode

// make generated class pulic
%public

// the yylex() return type of fuction will be Token
%type Token

// put java code in this block
// it will put into generated java class
%{
    // a class for result object 
    public static class Token{
        private final int type;
        private final String lexeme;
        public Token(int type, String lexeme){
            this.type = type;
            this.lexeme = lexeme;
        }
        public int getType(){ return this.type; }
        public String getLexeme(){ return this.lexeme; }
    }

    // ========= SYMBOL TYPE CODE ===========
    public static final int SYM_OPERATOR = 1;
    public static final int SYM_ID = 2;
    public static final int SYM_KEYWORD = 3;
    public static final int SYM_INT = 4;
    public static final int SYM_STRING = 5;
    public static final int SYM_SEM = 6;
    public static final int SYM_PARENTHESES = 7;
    public static final int SYM_COMMENT = 8;
    public static final int SYM_FOUND_ID = 9;
    public static final int SYM_UNKNOWN = 10;

    private List<String> symbolTable = new ArrayList<>(); 

    // a function to check if identifier ever met
    // if not put it into Symbol table
    private int putID(String newID){
        // id already in the list
        for (String id: symbolTable){
            if (newID.equals(id))
                return SYM_FOUND_ID;
        }
        symbolTable.add(newID);
        return SYM_ID;
    }
    public List<String> getSymbolTable(){
        return this.symbolTable;
    }

%}

// RULES SECTIONS ==================
%% 

// Keywords
"if" | "then" | "else"   |
"endif" | "while" | "do" |
"endwhile" | "print"     |
"newline" | "read"                  {return new Token(SYM_KEYWORD, yytext());}

// Identifiers 
// only begin with a-z or A-Z or _
[a-zA-Z_][a-zA-Z_0-9]*              {return new Token(putID(yytext()), yytext());}

// Operator
"+" | "-" | "*" | "/" | "="    |
">" | ">=" | "<" | "<=" | "==" |
"++" | "--"                         {return new Token(SYM_OPERATOR, yytext());}

// Integer
[0-9]+                              {return new Token(SYM_INT, yytext());}

// String
// begin with " and end with "
// word contents not contain any "
// only allow escape charactor like \" \\ \n
\"([^\"\\\n\r]|\\.)*\"              {return new Token(SYM_STRING, yytext());}

// Comment
// in-line comments
"//"[^\n\r]*                        {return new Token(SYM_COMMENT, yytext());} 

// multiple-line (old-style comment) 
"/*"([^])*?"*/"                     {return new Token(SYM_COMMENT, yytext());}

// Parentheses
"(" | ")"                           {return new Token(SYM_PARENTHESES, yytext());}

// Semicolon
";"                                 {return new Token(SYM_SEM, yytext());}

// tab and whitespace
// including line with only \n
[ \t\n]                             {/* do nothing */}

// Other pattern that not statisfy the rule
// (error case)
[^]                                 {return new Token(SYM_UNKNOWN, yytext());} 

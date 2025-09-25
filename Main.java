import java.lang.Exception;
public class Main
{
    public static void main(String args[]){
        try {
            java.io.Reader reader = new java.io.FileReader("in.txt");
            Lexer lexer = new Lexer(reader);

            Lexer.Token token; 
            while((token = lexer.yylex()) != null){
                switch (token.getType()){
                    case Lexer.SYM_OPERATOR:
                        System.out.println("operator: "+token.getLexeme());
                        break;
                    case Lexer.SYM_ID:
                        System.out.println("new identifier: "+token.getLexeme());
                        break;
                    case Lexer.SYM_KEYWORD:
                        System.out.println("keyword: "+token.getLexeme());
                        break;
                    case Lexer.SYM_INT:
                        System.out.println("integer: "+token.getLexeme());
                        break;
                    case Lexer.SYM_STRING:
                        System.out.println("string: "+token.getLexeme());
                        break;
                    case Lexer.SYM_SEM:
                        System.out.println("semi-colon: "+token.getLexeme());
                        break;
                    case Lexer.SYM_PARENTHESES:
                        System.out.println("parentheses: "+token.getLexeme());
                        break;
                    case Lexer.SYM_COMMENT:
                        break;
                    case Lexer.SYM_FOUND_ID:
                        System.out.println("identifier \""+token.getLexeme()+"\" already in symbol table");
                        break;
                    case Lexer.SYM_UNKNOWN:
                        break;
                    default:
                        break;
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}

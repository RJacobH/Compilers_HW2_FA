%{
    #include <string>
    #include <iostream>
    #include <fstream>
    #include "FALexer.hh"

    #undef YY_DECL
    #define YY_DECL int FALexer::yylex(void)

    #define YY_USER_ACTION process(yytext);
    
    #define yyterminate() return 0
    #define YY_NO_UNISTD_H

    std::string remove_EOLNs(std::string txt) {
        int ending = txt.length();
        while (txt[ending-1] == '\r' || txt[ending-1] == '\n') {
            ending--;
        }
        return txt.substr(0,ending);
    }
    
    void FALexer::process(std::string txt) {
        current = current + txt;
    }
    
    void FALexer::report(bool accepted) {
        std::cout << remove_EOLNs(current) << " ";
        if (accepted) {
            std::cout << " YES";
        } else {   
            std::cout << " NO";
        }
        std::cout << std::endl;
        current = "";
        BEGIN(0);
    }

%}

%option debug
%option nodefault
%option noyywrap
%option yyclass="Lexer"
%option c++

%s A1 B1 A2
     
EOLN    \r\n|\n\r|\n|\r

%%

%{

%}

<INITIAL>"a"        { BEGIN(A1); }
<INITIAL>["b"|"c"]  { BEGIN(INITIAL); }
<A1>"a"             { BEGIN(A1); }
<A1>"b"             { BEGIN(B1); }
<A1>"c"             { BEGIN(INITIAL); }
<B1>"a"             { BEGIN(A2); }
<B1>["b"|"c"]       { BEGIN(B1); }
<A2>"a"             { BEGIN(A2); }
<A2>"b"             { BEGIN(INITIAL); }
<A2>"c"             { BEGIN(B1); }
<INITIAL>{EOLN}     { report(true); }
<A1>{EOLN}          { report(true); }
<*>{EOLN}           { report(false); }

<<EOF>> {
    return 0;
}

. {
    std::string txt { yytext };
    std::cerr << "Unexpected \"" << txt << "\" in input." << std::endl;
    return -1;
}
    
%%

int main(int argc, char** argv) {
    std::string src_name { argv[1] };
    std::ifstream ins { src_name };
    FALexer lexer { &ins };
    return lexer.yylex();
}

grammar Project;

//--------------------------------------------parser--------------------------------------------------------
start: imports* definationVar*;
imports: importLibrary | importFunction;
importLibrary: VALIDNAME '=' REQUIRE '<' VALIDNAME '>' SEMICOLON;
importFunction : VALIDNAME (',' VALIDNAME)* '=' FROM '<' VALIDNAME '>' (REQUIRE ' <' VALIDNAME '>' | '=>' '<' VALIDNAME '>') (',' FROM ' <' VALIDNAME '>' (REQUIRE '<' VALIDNAME '>' | '=>' '<' VALIDNAME '>' ))* SEMICOLON;
//Defination Var..........................
definationVar: ACCESSIBILITY? CONST? DATATYPE VALIDNAME ('=' INT|DOUBLE|STRING)? SEMICOLON;









//--------------------------------------------Lexer Rules--------------------------------------------------------


RETURN : 'return';
REQUIRE : 'require';
FROM : 'from';
CONST : 'const';
DATATYPE : 'int' | 'float' | 'double' | 'string' | 'char' | 'bool';
ACCESSIBILITY  : 'private' | 'public';
SEMICOLON : ';';
OPEN_PARANTEZ : '(';
CLOSE_PARANTEZ : ')';
OPEN_AKOLAD : '{';
CLOSE_AKOLAD : '}';
OPEN_KROSHE : '[';
CLOSE_KROSHE : ']';
BOOL : 'True' | 'False';
PM : '+' | '-';
SCIENTIFICSYMBOL : (DIGIT | '0') '.' INT ('e' ('-' | '+')? INT)?;
STRING: '"' TEXT '"';
INT : DIGIT+;
DOUBLE : INT ('.' INT)?;
VALIDNAME : (LETTER | '$') (LETTER | DIGIT | '_' | '$')+;
fragment TEXT: (LETTER | ' ' | '\t')*;
fragment LOWERCASE : [a-z];
fragment UPPERCASE : [A-Z];
fragment LETTER : [a-zA-Z];
fragment DIGIT : [0-9];

// ----------------------------------------Skip Rules-----------------------------------------------------
WS : ( ' ' | '\n' | '\t' | '\r')+ -> skip;
SINGLELINECOMMENT: '//' .*? -> skip;
MULTILINECOMMENT: '/*' .*? '*/' -> skip;



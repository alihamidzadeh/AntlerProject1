grammar backupCode;

//--------------------------------------------parser--------------------------------------------------------
start: imports* define*;
//Import Class.............................................................
imports: (importLibrary | importFunction);
importLibrary: VALIDNAME '=' REQUIRE '<' VALIDNAME '>' SEMICOLON;
importFunction : VALIDNAME (',' VALIDNAME)* '=' FROM '<' VALIDNAME '>' (REQUIRE ' <' VALIDNAME '>' | '=>' '<' VALIDNAME '>') (',' FROM ' <' VALIDNAME '>' (REQUIRE '<' VALIDNAME '>' | '=>' '<' VALIDNAME '>' ))* SEMICOLON;
//Defination Var............................................................................
define : (definationVar | definationArray | initalArray);
definationVar: ACCESSIBILITY? CONST? DATATYPE VALIDNAME ('=' (STRING|INT|DOUBLE|SCIENTIFICSYMBOL))? (',' VALIDNAME ('=' (STRING|INT|DOUBLE|SCIENTIFICSYMBOL))?)* SEMICOLON;
definationArray: ACCESSIBILITY? CONST? DATATYPE VALIDNAME '[]' '=' NEW DATATYPE '[' (INT|DOUBLE|STRING|SCIENTIFICSYMBOL) ']' SEMICOLON;
initalArray : ACCESSIBILITY? CONST? DATATYPE VALIDNAME '[]' '=' DATATYPE '[' (INT|DOUBLE|STRING|SCIENTIFICSYMBOL) (',' (INT|DOUBLE|STRING|SCIENTIFICSYMBOL))* ']' SEMICOLON;







//--------------------------------------------Lexer Rules--------------------------------------------------------


RETURN : 'return';
REQUIRE : 'require';
FROM : 'from';
CONST : 'const';
NEW : 'new';
DATATYPE : ('int' | 'float' | 'double' | 'string' | 'char' | 'bool');
DATAVALUE : (INT|DOUBLE|STRING|SCIENTIFICSYMBOL);
ACCESSIBILITY  : ('private' | 'public');
SEMICOLON : ';';
OPEN_PARANTEZ : '(';
CLOSE_PARANTEZ : ')';
OPEN_AKOLAD : '{';
CLOSE_AKOLAD : '}';
OPEN_KROSHE : '[';
CLOSE_KROSHE : ']';
BOOL : 'True' | 'False';
PM : '+' | '-';
DOUBLE : INT ('.' INT)+;
STRING: '"' TEXT '"';
INT : DIGIT+;
VALIDNAME : (LETTER | '$') (LETTER | DIGIT | '_' | '$')+;
SCIENTIFICSYMBOL :  INT '.' INT ('e' ('-' | '+')? INT)?;
fragment TEXT: (LETTER | ' ' | '\t')*;
fragment LOWERCASE : [a-z];
fragment UPPERCASE : [A-Z];
fragment LETTER : [a-zA-Z];
fragment DIGIT : [0-9];

// ----------------------------------------Skip Rules-----------------------------------------------------
WS : ( ' ' | '\n' | '\t' | '\r')+ -> skip;
SINGLELINECOMMENT: '//' .*? -> skip;
MULTILINECOMMENT: '/*' .*? '*/' -> skip;



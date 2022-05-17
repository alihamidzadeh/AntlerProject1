grammar Project;

//--------------------------------------------parser--------------------------------------------------------
start: imports* defineV* defineC*;
//Import Class.............................................................
imports: (importLibrary | importFunction);
importLibrary: VALIDNAME '=' REQUIRE '<' VALIDNAME '>' SEMICOLON;
importFunction : VALIDNAME (',' VALIDNAME)* '=' FROM '<' VALIDNAME '>' (REQUIRE '<' VALIDNAME '>' | '=>' '<' VALIDNAME '>') (',' FROM '<' VALIDNAME '>' (REQUIRE '<' VALIDNAME '>' | '=>' '<' VALIDNAME '>' ))* SEMICOLON;
//Defination Var............................................................................
defineV : (definationVar | definationArray | initalArray);
definationVar: ACCESSIBILITY? CONST? DATATYPE VALIDNAME ('=' (DATAVALUE))? (',' VALIDNAME ('=' (DATAVALUE))?)* SEMICOLON;
definationArray: ACCESSIBILITY? CONST? DATATYPE VALIDNAME '[]' '=' NEW DATATYPE '[' DATAVALUE ']' SEMICOLON;
initalArray : ACCESSIBILITY? CONST? DATATYPE VALIDNAME '[]' '=' '[' DATAVALUE (',' DATAVALUE)* ']' SEMICOLON;

//Defiantion Class........................................................
defineC: CLASS VALIDNAME ('(' VALIDNAME (',' VALIDNAME)* ')')? implemet BEGIN class_body* END;
implemet: (IMPLEMENTS VALIDNAME (',' VALIDNAME)*)?;
class_body : defineV | defineF | defineConstructor;

defineConstructor : VALIDNAME '(' funcIn* ')' BEGIN code* END;
defineF : DATATYPE VALIDNAME '(' funcIn* ')' BEGIN code* END;
funcIn: DATATYPE VALIDNAME ('=' DATAVALUE)? (',' DATATYPE VALIDNAME ('=' DATAVALUE)?)*;
//code : (switch | exception | callFunc);
code : (defineV|defineF|loop|if|thiss|expression SEMICOLON|defineObj|callFunc|return);


//return....................................................................
return : RETURN (VALIDNAME|DATAVALUE)? SEMICOLON;
//This......................................................................
thiss : THIS '.'VALIDNAME '=' VALIDNAME SEMICOLON;
//callFunc..................................................................
callFunc : ACCESSIBILITY? CONST? DATATYPE? VALIDNAME '=' VALIDNAME '(' (DATAVALUE (',' DATAVALUE)*)? ')' SEMICOLON;
//defineObj.................................................................
defineObj : ACCESSIBILITY? CONST? VALIDNAME VALIDNAME ('=' ((VALIDNAME '(' (DATAVALUE (',' DATAVALUE)*)? ')') | NULL))? SEMICOLON;
//IF.........................................................................
if : if1 | if2;
if1 : (justIf (justIf | elseIf)* (else)?);
if2 : (expression '?' expression ':' expression SEMICOLON);
justIf: IF '(' expression ')' BEGIN code* END;
elseIf : ELSE IF '(' expression ')' BEGIN code* END;
else: ELSE BEGIN code* END;

//Loop.......................................................................
loop: ((FOR (( '(' initialV SEMICOLON expression (SEMICOLON expression)? ')') | (VALIDNAME 'in' VALIDNAME)) | WHILE expression)  BEGIN code* END ) | DO BEGIN code* END WHILE '(' expression ')';
initialV: DATATYPE? VALIDNAME ('=' (DATAVALUE))? (',' VALIDNAME ('=' (DATAVALUE))?)*;


expression: '(' expression ')' | expression '**' expression | '~' expression | ppVariable | expression '.' expression ('(' expression '.' expression ')')? | expression '(' expression ('[' expression ']')? ')' | expression ('*' | '/' | '//' | '%') expression | expression ('-' | '+') expression |
expression ('<<' | '>>') expression | expression ('==' | '!=' | '<>') expression | expression ('<' | '>' | '<=' | '>=') expression | 'not' expression |
expression ('and' | 'or' | '||' | '&&' | '|' | '&') expression | expression ('=' | '+=' | '-=' | '*=' | '/=') expression | NOT expression |  value | DATAVALUE ;

ppVariable: (VALIDNAME ('++' | '--') | ('++' | '--') VALIDNAME);
value: VALIDNAME | ('+' | '-')? INT;
//--------------------------------------------Lexer Rules--------------------------------------------------------
fragment TEXT: (LETTER | DIGIT | ' ' | '\t');
fragment LOWERCASE : [a-z];
fragment UPPERCASE : [A-Z];
fragment LETTER : [a-zA-Z];
fragment DIGIT : [0-9];
DO : 'do';
NULL : 'Null';
THIS : 'this';
FOR : 'for';
WHILE : 'while';
BEGIN : 'begin';
END : 'end';
IF : 'if';
ELSE : 'else';
IMPLEMENTS : 'implements';
CLASS : 'class';
RETURN : 'return';
REQUIRE : 'require';
FROM : 'from';
CONST : 'const';
NEW : 'new';
DATATYPE : ('int' | 'float' | 'double' | 'string' | 'char' | 'bool' | 'Null');
DATAVALUE : (INT|DOUBLE|STRING|SCIENTIFICSYMBOL|BOOL|CHAR);
CHAR : ['] [a-zA-Z~!@#$%^&*()_+0-9-=]? ['];
ACCESSIBILITY  : ('private' | 'public');
SEMICOLON : ';';
OPEN_PARANTEZ : '(';
STRING: ('"' .*? '"') | (['] .*? [']);
CLOSE_PARANTEZ : ')';
OPEN_AKOLAD : '{';
CLOSE_AKOLAD : '}';
OPEN_KROSHE : '[';
CLOSE_KROSHE : ']';
PM : '+' | '-';
NOT : '!';
INT : PM? DIGIT+;
BOOL : ('True' | 'False' | 'true' | 'false');
DOUBLE : INT ('.' INT)?;
FLOAT : INT ('.' INT)?;
VALIDNAME : (LETTER | '$') (LETTER | DIGIT | '_' | '$')+;
SCIENTIFICSYMBOL :  INT '.' INT ('e' ('-' | '+')? INT)?;


// ----------------------------------------Skip Rules-----------------------------------------------------
SINGLELINECOMMENT: ('//' .*? '\n') -> skip;
MULTILINECOMMENT: ('/*' .*? '*/') -> skip;
WS : ( ' ' | '\n' | '\t' | '\r')+ -> skip;



grammar Project;
//--------------------------------------------Parser Rules--------------------------------------------------------
start: imports* defineV* defineC*;
//Import Class.............................................................
imports: (importLibrary | importFunction);
importLibrary: VALIDNAME '=' REQUIRE '<' VALIDNAME '>' SEMICOLON;
importFunction : VALIDNAME (',' VALIDNAME)* '=' FROM '<' VALIDNAME '>' (REQUIRE '<' VALIDNAME '>' | '=>' '<' VALIDNAME '>') (',' FROM '<' VALIDNAME '>' (REQUIRE '<' VALIDNAME '>' | '=>' '<' VALIDNAME '>' ))* SEMICOLON;
//Defination Var............................................................................
defineV : (definationVar | definationArray | initalArray);
definationVar: ACCESSIBILITY? CONST? DATATYPE VALIDNAME ('=' (DATAVALUE | if2))? (',' VALIDNAME ('=' (DATAVALUE | if2))?)* SEMICOLON;
definationArray: ACCESSIBILITY? CONST? DATATYPE VALIDNAME '[]' '=' NEW DATATYPE '[' DATAVALUE | if2 ']' SEMICOLON;
initalArray : ACCESSIBILITY? CONST? DATATYPE VALIDNAME '[]' '=' '[' DATAVALUE | if2 (',' DATAVALUE | if2)* ']' SEMICOLON;

//Defiantion Class........................................................
defineC: CLASS VALIDNAME ('(' VALIDNAME (',' VALIDNAME)* ')')? implemet BEGIN class_body* END;
implemet: (IMPLEMENTS VALIDNAME (',' VALIDNAME)*)?;
class_body : defineV | defineF | defineConstructor;
defineConstructor : VALIDNAME '(' funcIn* ')' BEGIN code* END;
defineF : DATATYPE VALIDNAME '(' funcIn* ')' BEGIN code* return END;
funcIn: DATATYPE VALIDNAME ('=' DATAVALUE | if2)? (',' DATATYPE VALIDNAME ('=' DATAVALUE | if2)?)*;
//code : (callFunc);
code : (defineV|defineF|loop|if|thiss|switch|expression SEMICOLON|defineObj|callFunc|return|print|exception);
//return....................................................................
return : RETURN (DATAVALUE|VALIDNAME|if2|NULL)? SEMICOLON;
//This......................................................................
thiss : THIS '.'VALIDNAME '=' VALIDNAME SEMICOLON;
//callFunc..................................................................
callFunc : ACCESSIBILITY? CONST? DATATYPE? VALIDNAME '=' VALIDNAME '(' (DATAVALUE (',' DATAVALUE)*)? ')' SEMICOLON;
//defineObj.................................................................
defineObj : ACCESSIBILITY? CONST? VALIDNAME VALIDNAME ('=' ((VALIDNAME '(' (DATAVALUE(',' DATAVALUE)*)? ')') | NULL))? SEMICOLON;
//IF.........................................................................
if : if1 | if2 SEMICOLON;
if1 : (justIf (justIf | elseIf)* (else)?);
if2 : (expression '?' expression ':' expression);
justIf: IF '(' expression ')' BEGIN code* END;
elseIf : ELSE IF '(' expression ')' BEGIN code* END;
else: ELSE BEGIN code* END;
//Loop.......................................................................
loop: ((FOR (( '(' initialV SEMICOLON expression (SEMICOLON expression)? ')') | (VALIDNAME 'in' VALIDNAME)) | WHILE expression)  BEGIN code* END ) | DO BEGIN code* END WHILE '(' expression ')';
initialV: DATATYPE? VALIDNAME ('=' (DATAVALUE | if2))? (',' VALIDNAME ('=' (DATAVALUE | if2))?)*;
//Switch/Case....................................................................................................
switch: SWITCH expression BEGIN case* (default)? END;
case: CASE (DATAVALUE) ':' code* (BREAK SEMICOLON)? ;
default: DEFAULT ':' code* (BREAK SEMICOLON)?;
//Exceptions.....................................................................................................
exception: TRY BEGIN code+ END CATCH '(' VALIDNAME (',' VALIDNAME)* ')' BEGIN code+ END;
//Expression.....................................................................................................
expression: '(' expression ')' | expression '**' expression | '~' expression | ppVariable |
 expression '.' expression ('.' expression)* ('(' expression '.' expression ('.' expression)* ')')? |
// expression '(' expression ('[' expression ']')? ')' |
  expression ('*' | '/' | '//' | '%') expression | expression ('-' | '+') expression |
 expression ('<<' | '>>') expression | expression ('==' | '!=' | '<>') expression | expression ('<' | '>' | '<=' | '>=') expression | 'not' expression |
 expression ('and' | 'or' | '||' | '&&' | '|' | '&') expression | expression ('=' | '+=' | '-=' | '*=' | '/=') expression | NOT expression |  value | DATAVALUE ;
//Print..........................................................................................................
print: PRINT '(' printBody ')' SEMICOLON;
printBody: (DATAVALUE|(VALIDNAME (ARRAYINDEX)?)) (',' (DATAVALUE|(VALIDNAME(ARRAYINDEX)?)))*;

ppVariable: (VALIDNAME ('++' | '--') | ('++' | '--') VALIDNAME);
value: VALIDNAME | ('+' | '-')? INT;
//--------------------------------------------Lexer Rules--------------------------------------------------------
fragment TEXT: (LETTER | DIGIT | ' ' | '\t');
fragment LOWERCASE : [a-z];
fragment UPPERCASE : [A-Z];
fragment LETTER : [a-zA-Z];
fragment DIGIT : [0-9];
NULL : ('Null' | 'null');
BREAK: 'break';
PRINT: 'print';
TRY : 'try';
CATCH : 'catch';
SWITCH: 'switch';
DEFAULT: 'default';
CASE: 'case';
DO : 'do';
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
ARRAYINDEX: '[' INT ']';
DATATYPE : ('int'|'float'|'double'|'string'|'char'|'bool');
DATAVALUE : (NULL|INT|DOUBLE|STRING|SCIENTIFICSYMBOL|BOOL|CHAR);
INT : PM? DIGIT+;
CHAR : ['] [a-zA-Z~!@#$%^&*()_+0-9-=]? ['];
ACCESSIBILITY  : ('private' | 'public');
SEMICOLON : ';';
STRING: ('"' .*? '"') | (['] .*? [']);
PM : '+' | '-';
NOT : '!';
BOOL : ('True' | 'False' | 'true' | 'false');
DOUBLE : INT ('.' INT)?;
FLOAT : INT ('.' INT)?;
VALIDNAME : (LETTER | '$') (LETTER | DIGIT | '_' | '$')+;
SCIENTIFICSYMBOL :  INT '.' INT ('e' ('-' | '+')? INT)?;
// ----------------------------------------Skip Rules-----------------------------------------------------
SINGLELINECOMMENT: ('//' .*? '\n') -> skip;
MULTILINECOMMENT: ('/*' .*? '*/') -> skip;
WS : ( ' ' | '\n' | '\t' | '\r')+ -> skip;



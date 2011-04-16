// generated pegjs, from tmp/rules.rb and bubble-to-pegjs_ex.rb

start = sql_stmt_list

sql_stmt_list =
( ( sql_stmt )? semicolon )+ 

sql_stmt =
( ( EXPLAIN ( QUERY PLAN )? )? (
//  alter_table_stmt
//  / analyze_stmt
//  / attach_stmt / begin_stmt / commit_stmt
//  / create_index_stmt / create_table_stmt / create_trigger_stmt
//  / create_view_stmt / create_virtual_table_stmt
//  / delete_stmt / delete_stmt_limited
//  / detach_stmt / drop_index_stmt / drop_table_stmt / drop_trigger_stmt / drop_view_stmt
//  / insert_stmt
//  / pragma_stmt / reindex_stmt / release_stmt / rollback_stmt / savepoint_stmt
    select_stmt
//  / update_stmt / update_stmt_limited
//  / vacuum_stmt
) )

alter_table_stmt =
( ( ALTER TABLE ( database_name dot )? table_name ) ( RENAME TO new_table_name ) ( ADD ( COLUMN )? column_def ) ) 

analyze_stmt =
( ANALYZE ( nil / database_name / table_or_index_name / ( database_name dot table_or_index_name ) ) ) 

attach_stmt =
( ATTACH ( DATABASE / nil ) expr AS database_name ) 

begin_stmt =
( BEGIN ( nil / DEFERRED / IMMEDIATE / EXCLUSIVE ) ( TRANSACTION )? ) 

commit_stmt =
( ( COMMIT / END ) ( TRANSACTION )? ) 

rollback_stmt =
( ROLLBACK ( TRANSACTION )? ( TO ( SAVEPOINT )? savepoint_name )? ) 

savepoint_stmt =
( SAVEPOINT savepoint_name ) 

release_stmt =
( RELEASE ( SAVEPOINT )? savepoint_name ) 

create_index_stmt =
( ( CREATE ( UNIQUE )? INDEX ( IF NOT EXISTS )? ) ( ( database_name dot )? index_name ON table_name lparen ( indexed_column comma )+ rparen ) ) 

indexed_column =
( column_name ( COLLATE collation_name )? ( ASC / DESC / nil ) ) 

create_table_stmt =
( ( CREATE ( nil / TEMP / TEMPORARY ) TABLE ( IF NOT EXISTS )? ) ( ( database_name dot )? table_name ( lparen ( column_def comma )+ ( nil ( comma table_constraint ) )+ rparen ) ( AS select_stmt ) ) ) 

column_def =
( column_name ( type_name / nil ) ( nil ( nil column_constraint nil ) )+ ) 

type_name =
( ( name nil )+ ( nil / ( lparen signed_number rparen ) / ( lparen signed_number comma signed_number rparen ) ) ) 

column_constraint =
( ( CONSTRAINT name )? ( ( PRIMARY KEY ( nil / ASC / DESC ) conflict_clause ( AUTOINCREMENT )? ) / ( NOT NULL conflict_clause ) / ( UNIQUE conflict_clause ) / ( CHECK lparen expr rparen ) / ( DEFAULT ( signed_number / literal_value / ( lparen expr rparen ) ) ) / ( COLLATE collation_name ) / foreign_key_clause ) ) 

signed_number =
( ( nil / plus / minus ) numeric_literal ) 

table_constraint =
( ( CONSTRAINT name )? ( ( ( ( PRIMARY KEY ) / UNIQUE ) lparen ( indexed_column comma )+ rparen conflict_clause ) / ( CHECK lparen expr rparen ) / ( FOREIGN KEY lparen ( column_name comma )+ rparen foreign_key_clause ) ) ) 

foreign_key_clause =
( ( REFERENCES foreign_table ( lparen ( column_name comma )+ rparen )? ) ( ( ( ( ON ( DELETE / UPDATE ) ( ( SET NULL ) / ( SET DEFAULT ) / CASCADE / RESTRICT / ( NO ACTION ) ) ) / ( MATCH name ) ) nil )+ )? ( ( ( NOT )? DEFERRABLE ( ( INITIALLY DEFERRED ) / ( INITIALLY IMMEDIATE ) / nil ) ) nil )? ) 

conflict_clause =
( ( ON CONFLICT ( ROLLBACK / ABORT / FAIL / IGNORE / REPLACE ) ) )? 

create_trigger_stmt =
( ( CREATE ( nil / TEMP / TEMPORARY ) TRIGGER ( IF NOT EXISTS )? ) ( ( database_name dot )? trigger_name ( BEFORE / AFTER / ( INSTEAD OF ) / nil ) ) ( ( DELETE / INSERT / ( UPDATE ( OF ( column_name comma )+ )? ) ) ON table_name ) ( ( FOR EACH ROW )? ( WHEN expr )? ) ( BEGIN ( ( ( update_stmt / insert_stmt / delete_stmt / select_stmt ) semicolon ) nil )+ END ) ) 

create_view_stmt =
( ( CREATE ( nil / TEMP / TEMPORARY ) VIEW ( IF NOT EXISTS )? ) ( ( database_name dot )? view_name AS select_stmt ) ) 

create_virtual_table_stmt =
( ( CREATE VIRTUAL TABLE ( database_name dot )? table_name ) ( USING module_name ( lparen ( module_argument comma )+ rparen )? ) ) 

delete_stmt =
( DELETE FROM qualified_table_name ( WHERE expr )? ) 

delete_stmt_limited =
( ( DELETE FROM qualified_table_name ( WHERE expr )? ) ( ( ( ORDER BY ( ordering_term comma )+ )? ( LIMIT expr ( ( OFFSET / comma ) expr )? ) ) )? ) 

detach_stmt =
( DETACH ( DATABASE )? database_name ) 

drop_index_stmt =
( DROP INDEX ( IF EXISTS )? ( database_name dot )? index_name ) 

drop_table_stmt =
( DROP TABLE ( IF EXISTS )? ( database_name dot )? table_name ) 

drop_trigger_stmt =
( DROP TRIGGER ( IF EXISTS )? ( database_name dot )? trigger_name ) 

drop_view_stmt =
( DROP VIEW ( IF EXISTS )? ( database_name dot )? view_name ) 

expr =
( literal_value / bind_parameter / ( ( ( database_name dot )? table_name dot )? column_name ) / ( unary_operator expr ) / ( expr binary_operator expr ) / ( function_name lparen ( ( ( DISTINCT )? ( expr comma )+ ) / nil / star ) rparen ) / ( lparen expr rparen ) / ( CAST lparen expr AS type_name rparen ) / ( expr COLLATE collation_name ) / ( expr ( NOT )? ( LIKE / GLOB / REGEXP / MATCH ) expr ( ESCAPE expr )? ) / ( expr ( ISNULL / NOTNULL / ( NOT NULL ) ) ) / ( expr IS ( NOT )? expr ) / ( expr ( NOT )? BETWEEN expr AND expr ) / ( expr ( NOT )? IN ( ( lparen ( nil / select_stmt / ( expr comma )+ ) rparen ) / ( ( database_name dot )? table_name ) ) ) / ( ( ( NOT )? EXISTS )? lparen select_stmt rparen ) / ( CASE ( expr )? ( ( WHEN expr THEN expr ) nil )+ ( ELSE expr )? END ) / raise_function ) 

raise_function =
( RAISE lparen ( IGNORE / ( ( ROLLBACK / ABORT / FAIL ) comma error_message ) ) rparen ) 

literal_value =
( numeric_literal / string_literal / blob_literal / NULL / CURRENT_TIME / CURRENT_DATE / CURRENT_TIMESTAMP ) 

numeric_literal =
( ( ( ( digit nil )+ ( decimal_point ( nil digit )+ )? ) / ( decimal_point ( digit nil )+ ) ) ( E ( nil / plus / minus ) ( digit nil )+ )? ) 

insert_stmt =
( ( ( ( INSERT ( OR ( ROLLBACK / ABORT / REPLACE / FAIL / IGNORE ) )? ) / REPLACE ) INTO ( database_name dot )? table_name ) ( ( lparen ( column_name comma )+ rparen )? ( VALUES lparen ( expr comma )+ rparen ) select_stmt ) ( DEFAULT VALUES ) ) 

pragma_stmt =
( PRAGMA ( database_name dot )? pragma_name ( nil / ( equal pragma_value ) / ( lparen pragma_value rparen ) ) ) 

pragma_value =
( signed_number / name / string_literal ) 

reindex_stmt =
( REINDEX nil collation_name ( ( database_name dot )? table_name index_name ) ) 

select_stmt =
( ( ( select_core nil ) ( nil compound_operator nil ) )+ ( ORDER BY ( ordering_term comma )+ )? ( LIMIT expr ( ( OFFSET / comma ) expr )? )? ) 

select_core =
( ( SELECT ( nil / DISTINCT / ALL ) ( result_column comma )+ ) ( FROM join_source )? ( WHERE expr )? ( GROUP BY ( ordering_term comma )+ ( HAVING expr )? )? ) 

result_column =
( star / ( table_name dot star ) / ( expr ( ( AS )? column_alias )? ) ) 

join_source =
( single_source ( ( ( nil join_op single_source join_constraint nil ) nil )+ )? ) 

single_source =
( ( ( database_name dot )? table_name ( ( AS )? table_alias )? ( nil / ( INDEXED BY index_name ) / ( NOT INDEXED ) ) ) / ( lparen select_stmt rparen ( ( AS )? table_alias )? ) / ( lparen join_source rparen ) ) 

join_op =
( comma / ( ( NATURAL )? ( nil / ( LEFT ( OUTER / nil ) ) / INNER / CROSS ) JOIN ) ) 

join_constraint =
( ( ON expr ) / ( USING lparen ( column_name comma )+ rparen ) / nil ) 

ordering_term =
( expr ( COLLATE collation_name )? ( nil / ASC / DESC ) ) 

compound_operator =
( ( UNION ( ALL )? ) / INTERSECT / EXCEPT ) 

update_stmt =
( ( UPDATE ( OR ( ROLLBACK / ABORT / REPLACE / FAIL / IGNORE ) )? qualified_table_name ) ( SET ( ( column_name equal expr ) comma )+ ( WHERE expr )? ) ) 

update_stmt_limited =
( ( UPDATE ( OR ( ROLLBACK / ABORT / REPLACE / FAIL / IGNORE ) )? qualified_table_name ) ( SET ( ( column_name equal expr ) comma )+ ( WHERE expr )? ) ( ( ( ORDER BY ( ordering_term comma )+ )? ( LIMIT expr ( ( OFFSET / comma ) expr )? ) ) )? ) 

qualified_table_name =
( ( database_name dot )? table_name ( nil / ( INDEXED BY index_name ) / ( NOT INDEXED ) ) ) 

vacuum_stmt =
VACUUM 

comment_syntax =
( ( minusminus ( nil anything_except_newline )+ ( newline / end_of_input ) ) / ( comment_beg ( nil anything_except_comment_end )+ ( comment_end / end_of_input ) ) ) 

dot = '.'
comma = ','
semicolon = ';'
minusminus = '--'
minus = '-'
plus = '+'
lparen = '('
rparen = ')'
star = '*'
newline = '\n'
anything_except_newline = [^\n]*
comment_beg = '/*'
comment_end = '*/'
anything_except_comment_end = .* & '*/'
string_literal = '"' (escape_char / [^"])* '"'
escape_char = '\\' .
nil = ''

whitespace = [\s]*
whitespace1 = [\s]+

unary_operator = '-' / '+' / '~' / 'NOT'
binary_operator =
  '||'
  / '*' / '/' / '%'
  / '+' / '-'
  / '<<' / '>>' / '&' / '|'
  / '<' / '<=' / '>' / '>='
  / '=' / '==' / '!=' / '<>'
  / 'IS' / 'IS NOT' / 'IN' / 'LIKE' / 'GLOB' / 'MATCH' / 'REGEXP'
  / 'AND'
  / 'OR'

digit = [0-9]
decimal_point = dot
equal = '='

name = [A-Za-z0-9_]+
database_name = name
table_name = name
table_alias = name
table_or_index_name = name
new_table_name = name
index_name = name
column_name = name
column_alias = name
foreign_table = name
savepoint_name = name
collation_name = name
trigger_name = name
view_name = name
module_name = name
module_argument = name
bind_parameter = name
function_name = name
pragma_name = name

error_message = string_literal

CURRENT_TIME = 'now'
CURRENT_DATE = 'now'
CURRENT_TIMESTAMP = 'now'

blob_literal = string_literal

end_of_input = ''

ABORT = whitespace1 "ABORT"
ACTION = whitespace1 "ACTION"
ADD = whitespace1 "ADD"
AFTER = whitespace1 "AFTER"
ALL = whitespace1 "ALL"
ALTER = whitespace1 "ALTER"
ANALYZE = whitespace1 "ANALYZE"
AND = whitespace1 "AND"
AS = whitespace1 "AS"
ASC = whitespace1 "ASC"
ATTACH = whitespace1 "ATTACH"
AUTOINCREMENT = whitespace1 "AUTOINCREMENT"
BEFORE = whitespace1 "BEFORE"
BEGIN = whitespace1 "BEGIN"
BETWEEN = whitespace1 "BETWEEN"
BY = whitespace1 "BY"
CASCADE = whitespace1 "CASCADE"
CASE = whitespace1 "CASE"
CAST = whitespace1 "CAST"
CHECK = whitespace1 "CHECK"
COLLATE = whitespace1 "COLLATE"
COLUMN = whitespace1 "COLUMN"
COMMIT = whitespace1 "COMMIT"
CONFLICT = whitespace1 "CONFLICT"
CONSTRAINT = whitespace1 "CONSTRAINT"
CREATE = whitespace1 "CREATE"
CROSS = whitespace1 "CROSS"
DATABASE = whitespace1 "DATABASE"
DEFAULT = whitespace1 "DEFAULT"
DEFERRABLE = whitespace1 "DEFERRABLE"
DEFERRED = whitespace1 "DEFERRED"
DELETE = whitespace1 "DELETE"
DESC = whitespace1 "DESC"
DETACH = whitespace1 "DETACH"
DISTINCT = whitespace1 "DISTINCT"
DROP = whitespace1 "DROP"
E = whitespace1 "E"
EACH = whitespace1 "EACH"
ELSE = whitespace1 "ELSE"
END = whitespace1 "END"
ESCAPE = whitespace1 "ESCAPE"
EXCEPT = whitespace1 "EXCEPT"
EXCLUSIVE = whitespace1 "EXCLUSIVE"
EXISTS = whitespace1 "EXISTS"
EXPLAIN = whitespace1 "EXPLAIN"
FAIL = whitespace1 "FAIL"
FOR = whitespace1 "FOR"
FOREIGN = whitespace1 "FOREIGN"
FROM = whitespace1 "FROM"
GLOB = whitespace1 "GLOB"
GROUP = whitespace1 "GROUP"
HAVING = whitespace1 "HAVING"
IF = whitespace1 "IF"
IGNORE = whitespace1 "IGNORE"
IMMEDIATE = whitespace1 "IMMEDIATE"
IN = whitespace1 "IN"
INDEX = whitespace1 "INDEX"
INDEXED = whitespace1 "INDEXED"
INITIALLY = whitespace1 "INITIALLY"
INNER = whitespace1 "INNER"
INSERT = whitespace1 "INSERT"
INSTEAD = whitespace1 "INSTEAD"
INTERSECT = whitespace1 "INTERSECT"
INTO = whitespace1 "INTO"
IS = whitespace1 "IS"
ISNULL = whitespace1 "ISNULL"
JOIN = whitespace1 "JOIN"
KEY = whitespace1 "KEY"
LEFT = whitespace1 "LEFT"
LIKE = whitespace1 "LIKE"
LIMIT = whitespace1 "LIMIT"
MATCH = whitespace1 "MATCH"
NATURAL = whitespace1 "NATURAL"
NO = whitespace1 "NO"
NOT = whitespace1 "NOT"
NOTNULL = whitespace1 "NOTNULL"
NULL = whitespace1 "NULL"
OF = whitespace1 "OF"
OFFSET = whitespace1 "OFFSET"
ON = whitespace1 "ON"
OR = whitespace1 "OR"
ORDER = whitespace1 "ORDER"
OUTER = whitespace1 "OUTER"
PLAN = whitespace1 "PLAN"
PRAGMA = whitespace1 "PRAGMA"
PRIMARY = whitespace1 "PRIMARY"
QUERY = whitespace1 "QUERY"
RAISE = whitespace1 "RAISE"
REFERENCES = whitespace1 "REFERENCES"
REGEXP = whitespace1 "REGEXP"
REINDEX = whitespace1 "REINDEX"
RELEASE = whitespace1 "RELEASE"
RENAME = whitespace1 "RENAME"
REPLACE = whitespace1 "REPLACE"
RESTRICT = whitespace1 "RESTRICT"
ROLLBACK = whitespace1 "ROLLBACK"
ROW = whitespace1 "ROW"
SAVEPOINT = whitespace1 "SAVEPOINT"
SELECT = whitespace1 "SELECT"
SET = whitespace1 "SET"
TABLE = whitespace1 "TABLE"
TEMP = whitespace1 "TEMP"
TEMPORARY = whitespace1 "TEMPORARY"
THEN = whitespace1 "THEN"
TO = whitespace1 "TO"
TRANSACTION = whitespace1 "TRANSACTION"
TRIGGER = whitespace1 "TRIGGER"
UNION = whitespace1 "UNION"
UNIQUE = whitespace1 "UNIQUE"
UPDATE = whitespace1 "UPDATE"
USING = whitespace1 "USING"
VACUUM = whitespace1 "VACUUM"
VALUES = whitespace1 "VALUES"
VIEW = whitespace1 "VIEW"
VIRTUAL = whitespace1 "VIRTUAL"
WHEN = whitespace1 "WHEN"
WHERE = whitespace1 "WHERE"

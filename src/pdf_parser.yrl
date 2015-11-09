Nonterminals any list elems dictionary keys_and_values.

Terminals

integer
string
float
reference
name

array_start
array_end

dictionary_start
dictionary_end
.

Rootsymbol any.

any  -> integer                     : extract_token('$1').
any  -> float                       : extract_token('$1').
any  -> string                      : extract_token('$1').
any  -> reference                   : extract_token('$1').
any  -> name                        : extract_token('$1').
any  -> list                        : '$1'.
any  -> dictionary                  : '$1'.

list -> array_start array_end       : [].
list -> array_start elems array_end : '$2'.
elems -> any                        : ['$1'].
elems -> any elems                  : ['$1'|'$2'].

dictionary -> dictionary_start dictionary_end : [].
dictionary -> dictionary_start keys_and_values dictionary_end : '$2'.

keys_and_values -> name any         : [{extract_token('$1'), '$2'}].
keys_and_values -> name any keys_and_values : [{extract_token('$1'), '$2'} | '$3'].

Erlang code.

extract_token({_Token, _Line, Value}) -> Value.

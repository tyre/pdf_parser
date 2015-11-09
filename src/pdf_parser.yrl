Nonterminals any list elems.
Terminals array_start array_end integer string float reference.
Rootsymbol any.

any  -> list                        : '$1'.
any  -> integer                     : extract_token('$1').
any  -> float                       : extract_token('$1').
any  -> string                      : extract_token('$1').
any  -> reference                   : extract_token('$1').
list -> array_start array_end       : [].
list -> array_start elems array_end : '$2'.

elems -> any                        : ['$1'].
elems -> any elems     : ['$1'|'$2'].

Erlang code.

extract_token({_Token, _Line, Value}) -> Value.

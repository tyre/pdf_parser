Nonterminals any list elems elem.
Terminals array_start array_end ' ' integer string float reference.
Rootsymbol any.

any  -> list                        : '$1'.
any  -> integer                     : extract_token('$1').
any  -> float                       : extract_token('$1').
any  -> string                      : extract_token('$1').
any  -> reference                   : extract_token('$1').
list -> array_start array_end       : [].
list -> array_start elems array_end : '$2'.

elems -> elem           : ['$1'].
elems -> elem ' ' elems : ['$1'|'$3'].

elem -> integer : extract_token('$1').
elem -> string  : extract_token('$1').
elem -> list    : '$1'.

Erlang code.

extract_token({_Token, _Line, Value}) -> Value.

Definitions.

FLOAT             = (\+|-)?[0-9]+\.[0-9]+
INTEGER           = [0-9]+
STRING_START      = \(
STRING_END        = \)
WHITESPACE        = [\s\t\n\r]

Rules.

{INTEGER}                     : {token, {int,  TokenLine, list_to_integer(TokenChars)}}.
{FLOAT}                       : {token, {float, TokenLine, list_to_float(TokenChars)}}.
{STRING_START}.*{STRING_END}  : {token, {string, TokenLine, list_to_string(TokenChars)}}.
{WHITESPACE}+                 : skip_token.

Erlang code.

to_atom([$:|Chars]) ->
    list_to_atom(Chars).

list_to_string([$(|Chars]) ->
  list_to_string(lists:reverse(Chars));
list_to_string([$)|Chars]) ->
  lists:reverse(Chars).

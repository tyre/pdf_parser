Definitions.

DELIMETER         = [\(\)\<\>\[\]\{\}\/\%]
WHITESPACE        = [\s\t\n\r]
FLOAT             = (\+|-)?[0-9]+\.[0-9]+
INTEGER           = [0-9]+
NULL              = null
STRING_START      = \(
STRING_END        = \)
DICTIONARY_START  = <<
DICTIONARY_END    = >>
ARRAY_START       = \[
ARRAY_END         = \]
NAME              = /[^\s\t\n\r]+
TRUE              = true
FALSE             = false

Rules.

%.*\n                         : {token, {comment, TokenLine}}.
ptr{WHITESPACE}+{INTEGER}{WHITESPACE}+{INTEGER} : Reference = extract_reference(list_to_binary(TokenChars)),
                                {token, {reference, TokenLine, Reference}}.
{NULL}                        : {token, {nil, TokenLine}}.
{TRUE}                        : {token, {true, TokenLine}}.
{FALSE}                       : {token, {false, TokenLine}}.
{INTEGER}                     : {token, {integer,  TokenLine, list_to_integer(TokenChars)}}.
{FLOAT}                       : {token, {float, TokenLine, list_to_float(TokenChars)}}.
{STRING_START}.*{STRING_END}  : S = strip(TokenChars, TokenLen),
                                {token, {string, TokenLine, S}}.
{ARRAY_START}                 : {token, {array_start, TokenLine}}.
{ARRAY_END}                   : {token, {array_end, TokenLine}}.
{DICTIONARY_START}            : {token, {dictionary_start, TokenLine}}.
{DICTIONARY_END}              : {token, {dictionary_end, TokenLine}}.
{WHITESPACE}+                 : skip_token.

Erlang code.

strip(TokenChars,TokenLen) ->
    list_to_binary(lists:sublist(TokenChars, 2, TokenLen - 2)).

extract_reference(<<"ptr ", Rest/binary>>) ->
    [Object, Generation] = binary:split(Rest, [<<" ">>]),
    list_to_tuple([ptr, binary_to_integer(Object), binary_to_integer(Generation)]).

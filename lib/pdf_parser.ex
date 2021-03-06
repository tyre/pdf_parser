defmodule PdfParser do

  @spec parse(binary) :: list
  def parse(str) do
    {:ok, tokens, _} = str |> to_char_list |> :pdf_lexer.string
    {:ok, things} = :pdf_parser.parse(tokens)
    things
  end
end

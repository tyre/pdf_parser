defmodule PdfParserTest do
  use ExUnit.Case
  doctest PdfParser

  test "Parsing a number" do
    assert 2 = PdfParser.parse("2 9.7 (Hello World!)")
  end
end

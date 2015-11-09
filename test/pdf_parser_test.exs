defmodule PdfParserTest do
  use ExUnit.Case
  doctest PdfParser

  test "Parsing an integer" do
    assert 2 == PdfParser.parse("2")
    assert 12 == PdfParser.parse("12")
  end

  test "Parsing a float" do
    assert 1.0 == PdfParser.parse("1.0")
    assert 1.0 == PdfParser.parse("+1.0")
    assert -1.1 == PdfParser.parse("-1.1")
  end

  test "Parsing a string" do
    assert "Hello, World!" == PdfParser.parse("(Hello, World!)")
  end

  test "Parsing a reference" do
    assert {:ptr, 12, 0} == PdfParser.parse("ptr 12 0")
  end
end

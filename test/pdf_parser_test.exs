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

  test "Parsing arrays" do
    assert [1, 2.0, 17, "Who made this up?"] ==
           PdfParser.parse("[ 1 2.0 17 (Who made this up?)]")
    assert ["an", "array"] == PdfParser.parse("[(an) (array)]")

    assert [:A, :B, :C] == PdfParser.parse("[/A /B  /C ]")
  end

  test "Parsing dictionaries" do
    assert [{:key, 1.0}, {:another, "VALUE"}, {:WhyNot, ["an", "array"]}] ==
           PdfParser.parse("<< /key 1.0 /another (VALUE) /WhyNot [(an) (array)] >> ")
  end

  test "Parsing nested dictionaries" do
    assert [{:one, [{:two_a, 5}, {:two_b, "Bones"}]}, {:to_the_top!, [:A, :B, :C]}] ==
           PdfParser.parse("<< /one <</two_a 5 /two_b (Bones) >> /to_the_top! [ /A /B /C ]>>")
  end
end

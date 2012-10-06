require 'minitest/unit'
require 'big_xml'
require 'pry'

class TestBigXML < MiniTest::Unit::TestCase
  def test_grep_with_output_file
    BigXML.grep(
      input_file: 'test/fixtures/big.xml',
      output_file: '/tmp/small.xml',
      paths: ['/catalog/book'],
      attributes_in_path: true
    )
  end
  def test_grep_with_code
    books = 0
    BigXML.grep(
      input_file: 'test/fixtures/big.xml',
      paths: ['/catalog/book'],
      attributes_in_path: false
    ) do |path, xml|
      books += 1
    end
    assert_equal 12, books
  end
  def test_grep_with_attributes_and_with_code
    books = 0
    BigXML.grep(
      input_file: 'test/fixtures/big.xml',
      paths: ['/catalog/book/@id=bk108/price'],
      outer_xml: false,
      attributes_in_path: true
    ) do |path, xml|
      books += 1
      assert_equal '4.95', xml
    end
    assert_equal 1, books
  end
end
MiniTest::Unit.autorun

# BigXML

BigXML helps you parse big XML files efficiently with Ruby. 1GB, 10GB,
whatever.

## Installation

Add this line to your application's Gemfile:

    gem 'big_xml'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install big_xml

## Usage

Write:

    require 'big_xml'

## Examples

### Read and write to and from a file

Select and write all matching elements, /catalog/book in this case, to
a file:

    BigXML.grep(
      input: 'test/fixtures/big.xml',
      output: '/tmp/small.xml',
      paths: '/catalog/book'
    )

### Count the number of elements

Count the number of elements matching a specific path in an XML file:

    books_and_dogs = 0
    BigXML.grep(
      input: 'test/fixtures/big.xml',
      paths: ['/catalog/book', '/catalog/dog']
    ) do |path, xml|
      books_and_dogs += 1
    end

### Count the number of elements having a specific value

Count elements having a specific path and value:

    books = 0
    BigXML.grep(
      input: 'test/fixtures/big.xml',
      paths: ['/catalog/book/@id=bk108/price'],
      outer_xml: false, # We're only interested in the contents of the
tag
      attributes_in_path: true
    ) do |path, xml|
      books += 1 if xml == '4.95'
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

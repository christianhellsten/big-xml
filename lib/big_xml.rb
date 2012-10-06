require "big_xml/version"
require "big_xml/parser"
#  Public: BigXML helps you parse XML efficiently with minimal RAM usage. Parse 1GB, 2GB, 100GB, whatever and so on. 
module BigXML
  # 
  # Select portions of an XML file.
  # 
  # options - A hash containing configuration options:
  #   input - The path of the input file (XML)
  #   paths - The paths of the elements you want to select, e.g. /groups/idiots/@id=1
  #   outer_xml - (optional) Include outer XML or not?
  #   output - (optional) The path of the output file.
  #   attributes_in_path - (optional) Default false. Setting this to true will include attributes in the node path, e.g. /groups/@id=1. instead of just /groups
  #
  def self.grep(options = {})
    paths = [options.fetch(:paths)].flatten
    input_file = options.fetch(:input)
    outer_xml = options.fetch(:outer_xml) { true }
    output_file = options[:output]
    attributes_in_path = options.fetch(:attributes_in_path) { false }
    out = File.open(output_file, 'w') if output_file
    xml = Parser.new(input_file)
    xml.each_node(attributes_in_path: attributes_in_path) do |node, path|
      if paths.include?(path)
        xml = outer_xml ? node.outer_xml : node.inner_xml
        if out
          out << xml
        else
          yield path, xml
        end
      end
    end
  ensure
    out.close if out
  end
end

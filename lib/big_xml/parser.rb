require 'nokogiri'
#
#  Examples:
#    # Filter an XML file efficiently by selecting only users, groups and messages.
#    File.open(ARGV[1], 'w') do |out_file|
#      xml = BigXML.new(ARGV[0])
#      xml.each_node do |node, path|
#        # users
#        if node.name == 'user' && path == 'export/users/user'
#          out_file << node.outer_xml
#        # groups
#        elsif node.name == 'group' && path == 'export/groups/group' && node.outer_xml.match(/<private type="boolean">false/m)
#          out_file << node.outer_xml
#        # messages
#        elsif node.name == 'message' && path == 'export/messages/message' && node.outer_xml.match(/<private type="boolean">false/m)
#          out_file << node.outer_xml
#        end
#      end
#    end
#
module BigXML
  class Parser
    # Public: Initializes a parser.
    #
    # xml_file - The path of the XML file you want to parse
    def initialize(xml_file)
      raise ArgumentError, "Please provide the path of the XML file, not a #{xml_file.class}" unless xml_file.is_a?(String)
      @xml_file = xml_file
    end

    # Public: Iterate over each node in the XML document.
    #
    # attributes_in_path - Default false. Setting this to true will include attributes in the node path, e.g. /groups/@id=1. instead of just /groups
    #
    # Yields the node (Nokogiri::XML::Reader) and path (String) of the current XML node.
    #
    # Returns nothing.
    def each_node(options={})
      attributes_in_path = options.fetch(:attributes_in_path) { false }
      reader = Nokogiri::XML::Reader(File.open(@xml_file))
      nodes = ['']
      reader.each do |node|
        # start tag
        if node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT 
          # store path
          if attributes_in_path && node.attributes.size > 0
            attributes = []
            node.attributes.sort.each do |name, value|
              attributes << "@#{name}=#{value}"
            end
            nodes << "#{node.name}/#{attributes.join('/')}"
          else
            nodes << node.name
          end
          path = nodes.join('/')
          yield node, path
        end
        # end tag
        if node.node_type == Nokogiri::XML::Reader::TYPE_END_ELEMENT || node.self_closing?
          nodes.pop
        end
      end
    end
  end
end

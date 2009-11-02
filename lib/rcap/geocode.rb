module CAP
  class Geocode < Parameter

    XML_ELEMENT_NAME = 'geocode' # :nodoc:

    XPATH = "cap:#{ XML_ELEMENT_NAME }" # :nodoc:
    
    def to_xml_element # :nodoc:
      xml_element = REXML::Element.new( XML_ELEMENT_NAME )
      xml_element.add_element( NAME_ELEMENT_NAME ).add_text( @name )
      xml_element.add_element( VALUE_ELEMENT_NAME ).add_text( @value )
      xml_element
    end

    def self.from_xml_element( geocode_xml_element ) # :nodoc:
      self.new( :name => CAP.xpath_text( geocode_xml_element, NAME_XPATH ),
               :value => CAP.xpath_text( geocode_xml_element, VALUE_XPATH ))
    end

    def ==( other )
      self.name == other.name &&
        self.value == other.value
    end
  end
end

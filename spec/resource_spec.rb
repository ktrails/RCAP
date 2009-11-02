require 'spec/spec_helper'

describe( CAP::Resource ) do
  context( 'on initialisation' ) do
    before( :each ) do
      @resource = CAP::Resource.new
    end

    it( 'should have no mime_type' ){ @resource.mime_type.should( be_nil )}    
    it( 'should have no size' ){ @resource.size.should( be_nil )}         
    it( 'should have no uri' ){ @resource.uri.should( be_nil )}          
    it( 'should have no deref_uri' ){ @resource.deref_uri.should( be_nil )}    
    it( 'should have no digest' ){ @resource.digest.should( be_nil )}       
    it( 'should have no resource_desc' ){ @resource.resource_desc.should( be_nil )}

    context( 'from XML' ) do
      before( :each ) do
        @original_resource = CAP::Resource.new
        @original_resource.resource_desc = "Image of incident"
        @original_resource.uri           = "http://capetown.gov.za/cap/resources/image.png"
        @original_resource.mime_type     = 'image/png'
        @original_resource.deref_uri     = "IMAGE DATA"
        @original_resource.size          = "20480"
        @original_resource.digest        = "2048"

        @alert = CAP::Alert.new( :infos => CAP::Info.new( :resources => @original_resource ))
        @xml_string = @alert.to_xml
        @xml_document = REXML::Document.new( @xml_string )
        @info_element = CAP.xpath_first( @xml_document.root, CAP::Info::XPATH )
				@resource_element = CAP.xpath_first( @info_element, CAP::Resource::XPATH )
        @resource_element.should_not( be_nil )
        @resource = CAP::Resource.from_xml_element( @resource_element )
      end

      it( 'should parse resource_desc correctly' ) do
        @resource.resource_desc.should == @original_resource.resource_desc
      end

      it( 'should parse uri correctly' ) do
        @resource.uri.should == @original_resource.uri
      end

      it( 'should parse mime_type correctly' ) do
        @resource.mime_type.should == @original_resource.mime_type
      end

      it( 'should parse deref_uri correctly' ) do
        @resource.deref_uri.should == @original_resource.deref_uri
      end

      it( 'should parse size correctly' ) do
        @resource.size.should == @original_resource.size
      end

      it( 'should parse digest correctly' ) do
        @resource.digest.should == @original_resource.digest
      end
    end
  end

  context( 'which is valid' ) do
    before( :each ) do
      @resource = CAP::Resource.new( :resource_desc => 'Resource Description' )
      @resource.should( be_valid )
    end

    describe( 'should not be valid if it' ) do
      it( 'does not have a resource description (resource_desc)' ) do
        @resource.resource_desc = nil
        @resource.should_not( be_valid )
      end
    end
  end
end

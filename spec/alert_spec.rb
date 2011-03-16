require 'spec_helper'

describe( RCAP::Alert ) do
  context( 'on initialisation' ) do
    before( :each )  do
      @alert = RCAP::Alert.new
    end

    it( 'should have a default identifier' ){ @alert.identifier.should_not( be_nil )}
    it( 'should not have a sender' ){ @alert.sender.should( be_nil )}
    it( 'should have a default sent time' ){ @alert.sent.should_not( be_nil )}
    it( 'should not have a status' ){ @alert.status.should( be_nil )}
    it( 'should not have a scope' ){ @alert.scope.should( be_nil )}
    it( 'should not have a source'){ @alert.source.should( be_nil )}
    it( 'should not have a restriction'){ @alert.restriction.should( be_nil )}
    it( 'should not have any addresses' ){ @alert.addresses.should( be_empty )}
    it( 'should not have a code' ){ @alert.code.should( be_nil )}
    it( 'should not have a note' ){ @alert.note.should( be_nil )}
    it( 'should not have any references' ){ @alert.references.should( be_empty )}
    it( 'should not have any incidents' ){ @alert.incidents.should( be_empty )}
    it( 'should not have any infos' ){ @alert.infos.should( be_empty )}

		shared_examples_for( "a successfully parsed alert" ) do
			it( 'should parse identifier correctly' ) { @alert.identifier.should  == @original_alert.identifier }
			it( 'should parse sender correctly' )     { @alert.sender.should      == @original_alert.sender }
			it( 'should parse sent correctly' )       { @alert.sent.should(be_within(Rational(1, 86400)).of(@original_alert.sent))}
			it( 'should parse status correctly' )     { @alert.status.should      == @original_alert.status }
			it( 'should parse msg_type correctly' )   { @alert.msg_type.should    == @original_alert.msg_type }
			it( 'should parse source correctly' )     { @alert.source.should      == @original_alert.source }
			it( 'should parse scope correctly' )      { @alert.scope.should       == @original_alert.scope }
			it( 'should parse restriction correctly' ){ @alert.restriction.should == @original_alert.restriction }
			it( 'should parse addresses correctly' )  { @alert.addresses.should   == @original_alert.addresses }
			it( 'should parse code correctly' )       { @alert.code.should        == @original_alert.code }
			it( 'should parse note correctly' )       { @alert.note.should        == @original_alert.note }
			it( 'should parse references correctly' ) { @alert.references.should  == @original_alert.references }
			it( 'should parse incidents correctly' )  { @alert.incidents.should   == @original_alert.incidents }
			it( 'should parse infos correctly' ) do 
				@alert.infos.size.should == @original_alert.infos.size 
				@alert.infos.each{ |info| info.class.should == RCAP::Info }
			end
		end

		context( 'from XML' ) do
			before( :each ) do
				@original_alert = RCAP::Alert.new( :sender => 'Sender',
													 :status => RCAP::Alert::STATUS_TEST,
													 :scope => RCAP::Alert::SCOPE_PUBLIC,
													 :source => 'Source',
													 :restriction => 'No Restriction',
													 :addresses => [ 'Address 1', 'Address 2'],
													 :code => 'Code',
													 :note => 'Note',
													 :references => [ RCAP::Alert.new( :sender => 'Sender1' ).to_reference, RCAP::Alert.new( :sender => 'Sender2' ).to_reference ],
													 :incidents => [ 'Incident1', 'Incident2' ],
													 :infos => [ RCAP::Info.new, RCAP::Info.new ])
				@xml_string = @original_alert.to_xml
				@xml_document = REXML::Document.new( @xml_string )
				@alert_element = @xml_document.root
				@alert = RCAP::Alert.from_xml_element( @alert_element )
			end

			it_should_behave_like( "a successfully parsed alert" ) 

    end

		context( 'from YAML' ) do
			before( :each ) do
				@original_alert = RCAP::Alert.new( :sender => 'Sender',
													 :status => RCAP::Alert::STATUS_TEST,
													 :scope => RCAP::Alert::SCOPE_PUBLIC,
													 :source => 'Source',
													 :restriction => 'No Restriction',
													 :addresses => [ 'Address 1', 'Address 2'],
													 :code => 'Code',
													 :note => 'Note',
													 :references => [ RCAP::Alert.new( :sender => 'Sender1' ).to_reference, RCAP::Alert.new( :sender => 'Sender2' ).to_reference ],
													 :incidents => [ 'Incident1', 'Incident2' ],
													 :infos => [ RCAP::Info.new, RCAP::Info.new ])
				@yaml_string = @original_alert.to_yaml
				@alert = RCAP::Alert.from_yaml( @yaml_string )
			end

			it_should_behave_like( "a successfully parsed alert" ) 
		end

    context( 'from a hash' ) do
			before( :each ) do
				@original_alert = RCAP::Alert.new( :sender => 'Sender',
													 :status => RCAP::Alert::STATUS_TEST,
													 :scope => RCAP::Alert::SCOPE_PUBLIC,
													 :source => 'Source',
													 :restriction => 'No Restriction',
													 :addresses => [ 'Address 1', 'Address 2'],
													 :code => 'Code',
													 :note => 'Note',
													 :references => [ RCAP::Alert.new( :sender => 'Sender1' ).to_reference, RCAP::Alert.new( :sender => 'Sender2' ).to_reference ],
													 :incidents => [ 'Incident1', 'Incident2' ],
													 :infos => [ RCAP::Info.new, RCAP::Info.new ])
				@alert = RCAP::Alert.from_h( @original_alert.to_h )
			end

			it_should_behave_like( "a successfully parsed alert" ) 
    end

    context( 'from JSON' ) do
			before( :each ) do
				@original_alert = RCAP::Alert.new( :sender => 'Sender',
													 :status => RCAP::Alert::STATUS_TEST,
													 :scope => RCAP::Alert::SCOPE_PUBLIC,
													 :source => 'Source',
													 :restriction => 'No Restriction',
													 :addresses => [ 'Address 1', 'Address 2'],
													 :code => 'Code',
													 :note => 'Note',
													 :references => [ RCAP::Alert.new( :sender => 'Sender1' ).to_reference, RCAP::Alert.new( :sender => 'Sender2' ).to_reference ],
													 :incidents => [ 'Incident1', 'Incident2' ],
													 :infos => [ RCAP::Info.new, RCAP::Info.new ])
				@alert = RCAP::Alert.from_json( @original_alert.to_json )
			end

			it_should_behave_like( "a successfully parsed alert" ) 
    end
  end

  describe( 'is not valid if it' ) do
    before( :each ) do
      @alert = RCAP::Alert.new( :sender => "cap@tempuri.org",
                              :status => RCAP::Alert::STATUS_TEST,
                              :msg_type => RCAP::Alert::MSG_TYPE_ALERT,
                              :scope => RCAP::Alert::SCOPE_PUBLIC )
      @alert.should( be_valid )
    end

    it( 'does not have a identifier' ) do
      @alert.identifier = nil
      @alert.should_not( be_valid )
    end

    it( 'does not have a sender' ) do
      @alert.sender = nil
      @alert.should_not( be_valid )
    end

    it( 'does not have a sent time (sent)' ) do
      @alert.sent = nil
      @alert.should_not( be_valid )
    end

    it( 'does not have a status' ) do
      @alert.status = nil
      @alert.should_not( be_valid )
    end

    it( 'does not have a message type (msg_type)' ) do
      @alert.msg_type = nil
      @alert.should_not( be_valid )
    end

    it( 'does not have a scope' ) do
      @alert.scope = nil
      @alert.should_not( be_valid )
    end


    it( 'does not have a valid status' ) do
      @alert.status = 'incorrect value'
      @alert.should_not( be_valid )
    end

    it( 'does not have a valid message type msg_type' ) do
      @alert.msg_type = 'incorrect value'
      @alert.should_not( be_valid )
    end

    it( 'does not have a valid scope' ) do
      @alert.scope = 'incorrect value'
      @alert.should_not( be_valid )
    end


    context( 'has an info element and it' ) do
      it( 'is not valid' ) do
        @info = RCAP::Info.new( :event => 'Info Event',
                              :categories => RCAP::Info::CATEGORY_GEO,
                              :urgency => RCAP::Info::URGENCY_IMMEDIATE,
                              :severity => RCAP::Info::SEVERITY_EXTREME,
                              :certainty => RCAP::Info::CERTAINTY_OBSERVED )
        @info.event = nil
        @alert.infos << @info
        @info.should_not( be_valid )
        @alert.should_not( be_valid )
      end
    end
  end
end

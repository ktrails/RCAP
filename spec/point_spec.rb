require 'spec_helper'

describe( RCAP::Point ) do
  describe( 'is not valid if' ) do
    before( :each ) do
      @point = RCAP::Point.new( :lattitude => 0, :longitude => 0 )
      @point.should( be_valid )
    end

    it( 'does not have a longitude defined' ) do
      @point.longitude = nil
      @point.should_not( be_valid )
    end

    it( 'does not have a valid longitude' ) do
      @point.longitude = RCAP::Point::MAX_LONGITUDE + 1
      @point.should_not( be_valid )
      @point.longitude = RCAP::Point::MIN_LONGITUDE - 1
      @point.should_not( be_valid )
    end

    it( 'does not have a lattitude defined' ) do
      @point.lattitude = nil
      @point.should_not( be_valid )
    end

    it( 'does not have a valid lattitude' ) do
      @point.lattitude = RCAP::Point::MAX_LATTITUDE + 1
      @point.should_not( be_valid )
      @point.lattitude = RCAP::Point::MIN_LATTITUDE - 1
      @point.should_not( be_valid )
    end
  end

  context( 'when exported' ) do
    before( :each ) do
      @point = RCAP::Point.new( :lattitude => 1, :longitude => 1 )
    end

    context( 'to hash' ) do
      it( 'should export correctly' ) do
        @point.to_h.should == { RCAP::Point::LATTITUDE_KEY => 1, RCAP::Point::LONGITUDE_KEY => 1 }
      end
    end
  end
end

$: << File.join( File.dirname( __FILE__ ), '../lib' )

require 'rubygems'
require 'rspec'
require 'data_table/validators'

describe Validators do
  before :each do
    class MyTest
      include Validators
    end
  end

  context "DataTable" do
    it 'raise an exception when not a DataTable' do
      t = MyTest.new

      lambda {
        t.validate_data_table( [] )
      }.should raise_exception( Validators::Exceptions::UndefinedDataTable )
    end

    it 'be valid when receiving a DataTable' do
      t = MyTest.new
      dt = DataTable.new

      lambda {
        t.validate_data_table( dt )
      }.should_not raise_exception
    end
  end

  context "pointers" do
    it 'raise an exception when not a digit' do
      t = MyTest.new

      lambda {
        t.validate_pointer( 'asdf' )
      }.should raise_exception( Validators::Exceptions::UndefinedPointer )
    end

    it 'valid when digit(s)' do
    end
  end
end

$: << File.dirname( File.join( __FILE__, '..' ) )

require 'rubygems'
require 'spec/test/unit'
require 'data_table'

# Sneaky
class Object
  def array?
    self.is_a?( Array )
  end
end

describe DataTable do
  context "Instantiation" do
    it 'raise an exception when constructor is called with arguments' do
      lambda {
        DataTable.new( 'x' )
      }.should raise_error( ArgumentError, /wrong number of arguments \(\d for 0\)/ )
    end

    it 'set header to new Array' do
      subject.header.should be_array
    end

    it 'set rows to new Array' do
      subject.rows.should be_array
    end
  end

  context "Header Properties" do
    it "raise an exception when header is not valid" do
      lambda {
        subject.header = "a b c"
      }.should raise_error( DataTable::InvalidHeader )

      lambda {
        subject.header = []
      }.should raise_error( DataTable::InvalidHeader )

      lambda {
        subject.header = [ "a", "b", 3 ]
      }.should raise_error( DataTable::InvalidHeaderColumn )
    end

    it "create a valid header" do
      lambda {
        subject.header = %w( a b c )
      }.should_not raise_error

      subject.header.should == %w( a b c )
    end
  end

  context "Row Properties" do
    before :each do
      subject.header = %w( a b c )
    end

    it "raise exception when header is not yet defined" do
      lambda {
        subject.instance_variable_set( '@header', [] )
        subject.add_row( [1,2,3] )
      }.should raise_error( DataTable::UndefinedHeader )
    end

    it 'raise exception when row is not an Array' do
      lambda {
        subject.add_row( 'asdf' )
      }.should raise_error( DataTable::InvalidRow )
    end

    it "raise exception when row size does not match header size" do
      lambda {
        subject.add_row( [1,2] )
      }.should raise_error( DataTable::InvalidRowSize )
    end

    it 'raise exception when options is not a Hash' do
      lambda {
        subject.add_row( [1,2,3], 'asdf' )
      }.should raise_error( DataTable::InvalidAddOption )
    end

    it 'raise exception when options has more than 1 key' do
      lambda {
        subject.add_row( [1,2,3], :before => 0, :after => 1 )
      }.should raise_error( DataTable::InvalidAddOption )
    end

    it 'raise exception when options key is not :before or :after' do
      lambda {
        subject.add_row( [1,2,3], :asdf => 0 )
      }.should raise_error( DataTable::InvalidAddOption )
    end

    it "raise exception when option value is invalid" do
      lambda {
        subject.add_row( [1,2,3], :before => 'asdf' )
      }.should raise_error( DataTable::InvalidRowIndex )
    end

    it "raise an exception when accessing row and no rows have been added to table" do
      lambda {
        subject.row( 2 )
      }.should raise_error( DataTable::UndefinedTable )
    end

    it "raise an exception when accessing a row that has not been defined" do
      lambda {
        subject.add_row( [1,2,3] )
        subject.row( 2 )
      }.should raise_error( DataTable::UndefinedRow )
    end

    it "increase row count and add last row" do
      subject.add_row( [1,2,3] )
      subject.row_count.should == 1
      subject.last_row.should == [1,2,3]

      # This is equivalent to the default
      subject.add_row( [4,5,6], :after => 'last' )
      subject.row_count.should == 2
      subject.last_row.should == [4,5,6]
    end


    it "increase row count and add row after first" do
      subject.add_row( [1,2,3] )
      subject.add_row( [4,5,6] )
      subject.add_row( [7,8,9], :after => 'first' )
      subject.row_count.should == 3
      subject.row( 1 ).should == [7,8,9]
    end

    it "increase row count and create row before last" do
      subject.add_row( [1,2,3] )
      subject.add_row( [4,5,6] )
      subject.add_row( [7,8,9], :before => 'last' )
      subject.row_count.should == 3
      subject.row( 1 ).should == [7,8,9]
    end

    it "get first row dynamically" do
      subject.add_row( [1,2,3] )
      subject.get_first_row.should == [1,2,3]
    end

    it "get last row dynamically" do
      subject.add_row( [1,2,3] )
      subject.get_last_row.should == [1,2,3]
    end

    it "get row by index dynamically" do
      subject.add_row( [1,2,3] )
      subject.add_row( [4,5,6] )
      subject.add_row( [7,8,9] )
      subject.get_row_0.should == [1,2,3]
      subject.get_row_1.should == [4,5,6]
      subject.get_row_2.should == [7,8,9]
    end

    it "get row count dynmically" do
      subject.add_row( [1,2,3] )
      subject.get_row_count.should == 1
    end

    it "raise exception when removing row and no rows have been defined" do
      lambda {
        subject.delete_row( 2 )
      }.should raise_error( DataTable::UndefinedTable )
    end

    it "raise exception when removing row with an invalid index" do
      lambda {
        subject.add_row( [1,2,3] )
        subject.delete_row( 2 )
      }.should raise_error( DataTable::UndefinedRow )
    end

    it "remove row at specified index" do
      subject.add_row( [1,2,3] )
      subject.add_row( [4,5,6] )
      subject.add_row( [7,8,9] )
      subject.delete_row( 2 ).should == [7,8,9]
      subject.delete_row( 1 ).should == [4,5,6]
    end

    it "remove row at specified index dynamically" do
      subject.add_row( [1,2,3] )
      subject.add_row( [4,5,6] )
      subject.add_row( [7,8,9] )
      subject.del_row_2.should == [7,8,9]
      subject.delete_row_1.should == [4,5,6]
    end
  end

  context 'Row Operations' do
    before :each do
      subject.header = %w( a b c )
      subject.add_row( [1,2,3] )
      subject.add_row( [4,5,6] )
      subject.add_row( [7,8,9] )
    end

    it "raise exeption if type is invalid" do
      lambda {
        subject.sort( 'asdf', 2, 'desc' )
      }.should raise_error( DataTable::UndefinedFunctionType )
    end

    it "raise exception if pointer is invalid" do
      lambda {
        subject.sort( 'cols', 'asdf', 'desc' )
      }.should raise_error( DataTable::UndefinedPointer )
    end

    it "raise exception if sort order is invalid" do
      lambda {
        subject.sort( 'cols', 2, 'adsf' )
      }.should raise_error( DataTable::UndefinedSortOrder )
    end

    it "sort rows in descending order on column 2" do
      subject.sort( 'row', 2, 'desc' )
      subject.get_first_row.should == [7,8,9]
      subject.get_last_row.should == [1,2,3]
    end

    it "sort rows in ascending order on column 1" do
      subject.sort( 'row', 1 )
      subject.get_first_row.should == [1,2,3]
      subject.get_last_row.should == [7,8,9]
    end

    it "sort rows in ascending order using defaults" do
      subject.sort( 'row', 2, 'desc' )
      subject.sort
      subject.get_first_row.should == [1,2,3]
      subject.get_last_row.should == [7,8,9]
    end

    it "sum columns" do
      subject.sum( 'col' ).should == 12
      subject.sum( 'col', 1 ).should == 15
      subject.sum( 'col', 2 ).should == 18
    end

    it "average columns" do
      subject.avg( 'col' ).should == 4.0
      subject.avg( 'col', 1 ).should == 5.0
      subject.avg( 'col', 2 ).should == 6.0
      subject.add_row( [10,11,12] )
      subject.avg( 'col' ).should == 5.5
      subject.avg( 'col', 1 ).should == 6.5
      subject.avg( 'col', 2 ).should == 7.5
      subject.delete_row( 0 )
      subject.avg( 'col' ).should == 7.0
      subject.avg( 'col', 1 ).should == 8.0
      subject.avg( 'col', 2 ).should == 9.0
    end

    it "select max numerical value" do
      subject.max( 'col' ).should == 7
      subject.max( 'col', 1 ).should == 8
      subject.max( 'col', 2 ).should == 9
    end
  end
end

require 'rubygems'
require 'define_exception'
require 'validators'

include DefineException

class Sorter
  attr_accessor :data_table

  define_exception :undefined_sort_order, 'sort order must be :asc or :desc' 

  include Validators

  def initialize( data_table )
    validate_data_table( data_table )

    @data_table = data_table
  end

  def sort( pointer = 0, order = :asc )
    validate_pointer( pointer )
    raise UndefinedSortOrder unless [ :asc, :desc].include?( order )
    
    yield pointer, order
  end
end

class RowSorter < Sorter
  def sort( *args )
    super( args ) do
      @data_table.sort! { |row1,row2| order.eql?( :asc ) ? row1[pointer] <=> row2[pointer] : row2[pointer] <=> row1[pointer] }
    end
  end
end

class ColumnSorter < Sorter
  def sort( pointer, order )
    super( pointer, order ) do
      @data_table
    end
  end
end

class SorterFactory
  class << self
    def sorter( type = :row, data_table = Array.new )
      case type
        when :row
          RowSorter.new data_table
        when :column
          ColumnSorter.new data_table
        else raise Exception
      end 
    end
  end
end

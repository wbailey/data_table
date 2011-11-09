module Function
class Base
  attr_accessor :data_table, :pointer

  define_exception :undefined_data_table, 'The header must defined'
  define_exception :undefined_sort_order, 'sort order must be :asc or :desc' 
  define_exception :undefined_pointer, 'The pointer must be a valid integer in range'

  include Singleton

  def data_table=( data_table )
    validate_data_table( data_table )

    @data_table = data_table
  end

  def sort( pointer = 0, order = :asc )
    validate_pointer( pointer )
    validate_sort_order( order )
  end

  def sum( pointer = 0 )
    validate_pointer( pointer )
  end

  private

  def validate_data_table( data_table )
    raise UndefinedDataTable if data_table.header.empty? && data_table.empty?
  end

  def validate_sort_order( order )
    raise UndefinedSortOrder unless [ :asc, :desc ].include?( order.to_sym )
  end

  def validate_pointer( pointer )
    raise UndefinedPointer unless pointer.to_s.match( /\d+/ )
  end
end
end

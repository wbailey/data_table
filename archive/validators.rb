require 'rubygems'
require 'define_exception'
require 'data_table'

include DefineException

module Validators
  class Exceptions
    define_exception :undefined_data_table, 'No rows have been added to the table'
    define_exception :undefined_pointer, 'The pointer must be an integer value indicating the row or column to sort on'
  end

  def validate_data_table( data_table )
    raise Exceptions::UndefinedDataTable unless data_table.is_a?( DataTable )
  end

  def validate_pointer( pointer )
    raise Exceptions::UndefinedPointer unless pointer.match( /\d+/ )
  end
end

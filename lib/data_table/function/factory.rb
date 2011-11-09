require 'row_function.rb'
require 'column_function.rb'

class FunctionFactory
  define_exception :undefined_function_type, 'Type must either be :row or :column'

  class << self
    def new( type = :row, data_table = Array.new )
      case type.to_sym
        when :row
          row_function = RowFunction.instance
          row_function.data_table = data_table
          return row_function
        when :column
          column_function = ColumnFunction.instance
          column_function.data_table = data_table
          return column_function
        else
          raise UndefinedFunctionType
      end 
    end
  end
end

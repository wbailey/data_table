require 'function/factory'

class DataTable
  def sort( type = :row, pointer = 0, order = :asc )
    FunctionFactory.new( type, self ).sort( pointer, order )
  end

  def sum( type = :column, pointer = 0 )
    FunctionFactory.new( type, self ).sum( pointer )
  end

  def avg( type = :column, pointer = 0 )
    type, pointer = Validators.type_pointer( type, pointer )

    if type.eql?( :column )
      sum( type, pointer ).to_f / self.size.to_f
    else
      sum( :row, pointer ).to_f / self[pointer].size.to_f
    end
  end

  def max( type = :column, pointer = 0 )
    maxmin( '>', type, pointer)
  end

  def min( type = :column, pointer = 0 )
    maxmin( '<', type, pointer)
  end

  private

  def maxmin( op, type = :column, pointer = 0 ) 
    type, pointer = Validators.type_pointer( type, pointer )

    if type.eql?( :column )
      self.inject( 0 ) { |max,row| row[pointer].to_f.send( op, max ) ? row[pointer].to_f : max }
    else
      self[pointer].inject( 0 ) { |max,val| val.to_f.send( op, max ) ? val : max }
    end
  end

  class Validators
    class << self
      def type_pointer( type, pointer )
        case type.to_s
          when /^colu?m?n?s?$/i
            type = :columns
          when /^rows?$/i
            type = :rows
          else
            raise UndefinedFunctionType
        end

        raise UndefinedPointer unless /\d+/.match( pointer.to_s )
    
        return [ type, pointer ]
      end
    end
  end
end

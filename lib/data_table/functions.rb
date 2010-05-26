class DataTable
  def sort( type = 'rows', pointer = 0, order = 'asc' )
    type, pointer = Validators.type_pointer( type, pointer )
    raise UndefinedSortOrder unless /^(desc|asc)$/.match( order )

    if type.eql?( 'columns' )
      # nothing
    else
      self.sort! { |r1,r2| order.eql?( 'asc' ) ? r1[pointer] <=> r2[pointer] : r2[pointer] <=> r1[pointer] }
    end
  end

  def sum( type = 'colums', pointer = 0 )
    type, pointer = Validators.type_pointer( type, pointer )

    if type.eql?( 'columns' )
      self.inject( 0 ) { |sum,row| sum += row[pointer] }
    else
      self[pointer].inject( 0 ) { |sum,val| sum += val }
    end
  end

  def avg( type = 'columns', pointer = 0 )
    type, pointer = Validators.type_pointer( type, pointer )

    if type.eql?( 'columns' )
      sum( type, pointer ).to_f / self.size.to_f
    else
      sum( 'rows', pointer ).to_f / self[pointer].size.to_f
    end
  end

  def max( type = 'columns', pointer = 0 )
    maxmin( '>', type, pointer)
  end

  def min( type = 'columns', pointer = 0 )
    maxmin( '<', type, pointer)
  end

  private

  def maxmin( op, type = 'columns', pointer = 0 ) 
    type, pointer = Validators.type_pointer( type, pointer )

    if type.eql?( 'columns' )
      self.inject( 0 ) { |max,row| row[pointer].to_f.send( op, max ) ? row[pointer].to_f : max }
    else
      self[pointer].inject( 0 ) { |max,val| val.to_f.send( op, max ) ? val : max }
    end
  end

  class Validators
    class << self
      def type_pointer( type, pointer )
        case type
          when /^colu?m?n?s?$/i
            type = 'columns'
          when /^rows?$/i
            type = 'rows'
          else
            raise UndefinedFunctionType
        end

        raise UndefinedPointer unless /\d+/.match( pointer.to_s )
    
        return [ type, pointer ]
      end
    end
  end
end

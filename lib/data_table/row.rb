class DataTable
  def add_row( row, options = { :after => :last } )
    raise UndefinedHeader unless valid_header?
    raise InvalidRow unless row.is_a?( Array )
    raise InvalidRowSize unless row.size.eql?( @header.size )
    raise InvalidAddOption unless options.is_a?( Hash ) && options.keys.size.eql?( 1 )

    order, value = options.to_a.flatten

    case order
      when :before, :after
        raise InvalidRowIndex unless /^(first|last|\d+)$/.match( value.to_s )

        case value.to_s
          when 'first'
            index = order.eql?( :before ) ? 0 : 1
          when 'last'
            index = order.eql?( :after ) ? -1 : self.size - 1
          when /\d+/
            index = order.eql?( :before ) ? value : value + 1
        end
      else
        raise InvalidAddOption
    end

    # By default the array will substitute undefined values with nil when the index is out of bounds
    index = self.size if index > self.size

    self.insert( index, row )
  end

  def row( index = 0 )
    raise UndefinedTable if self.empty?

    if row = self[index.to_i]
      row
    else
      raise UndefinedRow
    end
  end

  def delete_row( index = 0 )
    row( index )

    self.delete_at( index.to_i )
  end
end  

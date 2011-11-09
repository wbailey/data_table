require 'function.rb'

class RowFunction < Function
  def sort( pointer, order )
    super( pointer, order )
    @data_table.sort! { |row1,row2| order.eql?( :asc ) ? row1[pointer] <=> row2[pointer] : row2[pointer] <=> row1[pointer] }
  end

  def sum( pointer )
    super( pointer )
    @data_table[pointer].inject( 0 ) { |sum,val| sum += val }
  end

  def avg( pointer )
    super pointer
    self.sum( pointer ).to_f / @data_table[pointer].size.to_f
  end

  private

  def validate_pointer( pointer )
    super( pointer )
    raise UndefinedPointer unless pointer <= @data_table.size
  end
end


class ColumnFunction < Function
  def sort( pointer, order )
    super( pointer, order )
    @data_table
  end

  def sum( pointer )
    super( pointer )
    @data_table.inject( 0 ) { |sum,row| sum += row[pointer] }
  end

  private

  def validate_pointer( pointer )
    super( pointer )
    raise UndefinedPointer unless pointer <= @data_table.header.size
  end
end


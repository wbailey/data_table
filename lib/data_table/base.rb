# Setup object construction and default behaviors
class DataTable
  attr_reader :header

  def initialize( header = Array.new )
    raise ArgumentError unless header.is_a?( Array )

    @header = header
  end

  def to_s
    @header.join( ' ' ) + self.inject( "\n" ) { |str,row| str << row.join( ' ' ) + "\n" }
  end
end

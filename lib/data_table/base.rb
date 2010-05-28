class DataTable
  attr_reader :header

  def initialize( header = Array.new )
    raise ArgumentError unless header.is_a?( Array )

    @header = header
  end

  def to_s
    if self.empty?
      @header.empty? ? '' : @header.join( ' ' )
    else
      @header.join( ' ' ) + "\n" + self.inject( '' ) { |s,row| s << row.join( ' ' ) + "\n" }
    end
  end
end

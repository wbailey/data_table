class DataTable 
  def header=( header )
    raise InvalidHeader unless header.is_a?( Array ) && header.size > 0

    header.each { |name| raise InvalidHeaderColumn unless name.is_a?( String ) }

    @header = header
  end

  private

  def valid_header?
    !@header.empty?
  end
end

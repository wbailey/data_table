class DataTable
  private

  def method_missing( method, *args )
    method_name = method.to_s

    case method_name
      when /^(get_)?(first|last)_row$/
        index = /first|last/.match( method_name )[0].eql?( 'first' ) ? 0 : -1
        row( index )
      when /^(get_)?row_\d+$/
        index = /\d+/.match( method_name )[0]
        row( index )
      when /^(get_)?row_count$/
        @rows.size
      when /^del(ete)?_row_\d+$/
        index = /\d+/.match( method_name )[0]
        delete_row( index )
    end
  end
end

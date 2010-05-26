class DataTable
  define_exception :invalid_header, 'Header must be an array of column names'
  define_exception :invalid_header_column, 'Please provide a name for the column of type String'
  define_exception :undefined_header, 'Column headings must be defined before a row can be added to the data table'

  define_exception :invalid_row, 'Row must be a valid instance of Array'
  define_exception :invalid_row_size, 'Row size must match header size'
  define_exception :invalid_row_index, "Valid values include 'first', 'last', or valid numerical index"
  define_exception :invalid_add_option, 'valid values include :before or :after'

  define_exception :undefined_table, 'No rows have been added to the table'
  define_exception :undefined_row, 'No row defined for specified index'

  define_exception :undefined_pointer, 'The pointer must be an integer value indicating the row or column to sort on'
  define_exception :undefined_function_type, 'The function type must be row or column'
  define_exception :undefined_sort_order, 'Sort order must be asc or desc'
end

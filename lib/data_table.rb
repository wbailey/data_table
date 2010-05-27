require 'rubygems'
require 'define_exception'

include DefineException

class DataTable < Array
  require 'data_table/base'
  require 'data_table/exceptions'
  require 'data_table/header'
  require 'data_table/row'
  require 'data_table/functions'
  require 'data_table/method_missing'
end

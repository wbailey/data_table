require 'rubygems'
require 'define_exception'

include DefineException

class DataTable
  attr_accessor :rows
  attr_reader :header

  def initialize
    @rows = Array.new
    @header = Array.new
  end

  require 'data_table/exceptions'
  require 'data_table/header'
  require 'data_table/row'
  require 'data_table/functions'
  require 'data_table/method_missing'
end

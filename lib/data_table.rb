require 'rubygems'
require 'define_exception'

include DefineException

class DataTable < Array
  attr_reader :header

  def initialize
    @rows = Array.new
    @header = Array.new
  end

  def to_s
    self.inject( '' ) { |s,row| s << row.join( ' ' ) + "\n" }
  end

  require 'data_table/exceptions'
  require 'data_table/header'
  require 'data_table/row'
  require 'data_table/functions'
  require 'data_table/method_missing'
end

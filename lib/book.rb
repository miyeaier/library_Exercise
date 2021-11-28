require "date"
require 'pry'

class Book
  STANDARD_VALIDITY_MONTH = 1
  attr_accessor :book_status, :rtn_date

  def initialize(attrs = {})
    @book_status = :active
    @rtn_date = set__return_date()
  end

  private

  def set__return_date
    Date.today.next_month(STANDARD_VALIDITY_MONTH).strftime("%Y-%m-%d")
  end
end

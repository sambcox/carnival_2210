require 'date'

class Carnival
  attr_reader :rides
  def initialize(end_date)
    @start_date = Date.today
    @end_date = Date.parse(end_date)
    @rides = []
  end

  def duration
    @end_date - @start_date
  end
end
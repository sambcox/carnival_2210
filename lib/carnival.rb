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

  def add_ride(ride)
    @rides.push(ride)
  end

  def most_popular
    @rides.max_by do |ride|
      ride.total_rides
    end
  end
end
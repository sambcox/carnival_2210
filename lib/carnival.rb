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
    @rides.max_by { |ride| ride.total_rides }
  end

  def most_profitable
    @rides.max_by { |ride| ride.total_revenue }
  end

  def total_carnival_revenue
    @rides.sum { |ride| ride.total_revenue }
  end

  def carnival_visitors
    @rides.flat_map do |ride|
      ride.rider_log.keys
    end.uniq
  end

  def visitor_favorite_ride(visitor)
    visitor_rides_taken = @rides.find_all { |ride| ride.rider_log[visitor] }
    visitor_rides_taken.max_by do |ride|
      ride.rider_log[visitor]
    end
  end

  def visitor_total_spent(visitor)
    @rides.sum do |ride|
      if ride.rider_log.keys.include?(visitor)
        ride.rider_log[visitor] * ride.admission_fee
      else
        0
      end
    end
  end

  def visitor_specific_summary(visitor)
    {favorite_ride: visitor_favorite_ride(visitor), total_spent: visitor_total_spent(visitor)}
  end

  def visitor_overall_summary
    carnival_visitors.reduce({}) do |acc, visitor|
      acc[visitor] = visitor_specific_summary(visitor)
      acc
    end
  end

  def ride_specific_summary(ride)
    {riders: ride.rider_log.keys, revenue: ride.total_revenue}
  end

  def ride_overall_summary
    @rides.inject({}) do |acc, ride|
      acc[ride] = ride_specific_summary(ride)
      acc
    end
  end

  def summary
    carnival_summary = {
      visitor_count: carnival_visitors.count,
      revenue_earned: total_carnival_revenue,
      visitors: visitor_overall_summary,
      ride_list: ride_overall_summary
    }
  end
end
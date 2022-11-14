class Ride
  attr_reader :name, :min_height, :admission_fee, :excitement, :rider_log, :total_revenue
  def initialize(data)
    @name = data[:name]
    @min_height = data[:min_height]
    @admission_fee = data[:admission_fee]
    @excitement = data[:excitement]
    @rider_log = {}
    @total_revenue = 0
  end

  def board_rider(rider)
    rider.board_ride
    @total_revenue += 1
  end
end

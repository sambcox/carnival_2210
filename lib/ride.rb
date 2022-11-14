class Ride
  attr_reader :name, :min_height, :admission_fee, :excitement, :rider_log
  def initialize(data)
    @name = data[:name]
    @min_height = data[:min_height]
    @admission_fee = data[:admission_fee]
    @excitement = data[:excitement]
    @rider_log = {}
  end

  def total_revenue
    0
  end
end

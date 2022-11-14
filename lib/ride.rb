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
    return if !rider.tall_enough(min_height) || !rider.preferences.include?(excitement)
    rider.board_ride(@admission_fee)
    @total_revenue += @admission_fee
    if @rider_log[rider]
      @rider_log[rider] += 1
    else
      @rider_log[rider] = 1
    end
  end
end

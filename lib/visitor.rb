class Visitor
  attr_reader :name, :height, :preferences
  def initialize(name, height, spending_money)
    @name = name
    @height = height
    @spending_money = spending_money
    @preferences = []
  end

  def spending_money
    @spending_money.delete('$').to_i
  end

  def add_preference(preference)
    @preferences.push(preference)
  end

  def tall_enough(height_req)
    @height >= height_req
  end

  def board_ride
    @spending_money = (spending_money - 1).to_s.prepend('$')
  end
end

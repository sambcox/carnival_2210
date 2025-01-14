require './lib/visitor'
require './lib/ride'
require './lib/carnival'

RSpec.describe Visitor do
  let(:carnival) { Carnival.new('27th May 2023')}
  let(:ride1) { Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle }) }
  let(:ride2) { Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle }) }
  let(:ride3) { Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling }) }
  let(:visitor1) { Visitor.new('Bruce', 54, '$10') }
  let(:visitor2) { Visitor.new('Tucker', 36, '$5') }
  let(:visitor3) { Visitor.new('Penny', 64, '$15') }
  before :each do
    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)
    visitor2.add_preference(:thrilling)
    visitor3.add_preference(:thrilling)
    visitor3.add_preference(:gentle)
    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor1)
    ride2.board_rider(visitor3)
    ride2.board_rider(visitor1)
    ride3.board_rider(visitor1)
    ride3.board_rider(visitor2)
    ride3.board_rider(visitor3)
  end

  it 'exists and has no rides by default' do
    expect(carnival).to be_a Carnival
    expect(carnival.rides).to eq([])
  end

  it 'can return the duration of the carnival' do
    expect(carnival.duration).to eq 194
  end

  it 'can add rides' do
    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)

    expect(carnival.rides).to eq([ride1, ride2, ride3])
  end

  it 'can return its most popular ride' do
    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)

    expect(carnival.most_popular).to eq(ride1)
  end

  it 'can return its most profitable ride' do
    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)

    expect(carnival.most_profitable).to eq(ride2)
  end

  it 'can return total revenue from all rides' do
    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)

    expect(carnival.total_carnival_revenue).to eq 15
  end

  it 'can return a hash with a full carnival summary' do
    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)
    ride3.board_rider(visitor3)

    expect(carnival.summary).to eq({
      :visitor_count => 3,
      :revenue_earned => 17,
      :visitors => {visitor1 => {:favorite_ride => ride1, :total_spent => 7}, visitor2 => {:favorite_ride => ride1, :total_spent => 1}, visitor3 => {:favorite_ride => ride3, :total_spent => 9}},
      :ride_list => {ride1 => {:riders => [visitor1, visitor2], :revenue => 3}, ride2 => {:riders => [visitor3, visitor1], :revenue => 10}, ride3 => {:riders => [visitor3], :revenue => 4}}
      })
  end
end
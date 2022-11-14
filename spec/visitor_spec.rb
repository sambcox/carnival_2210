require './lib/visitor'

RSpec.describe Visitor do
  let(:visitor) { Visitor.new('Bruce', 54, '$10') }

  it 'exists and has attributes' do
    expect(visitor).to be_a Visitor
    expect(visitor.name).to eq('Bruce')
    expect(visitor.height).to eq 54
    expect(visitor.preferences).to eq([])
  end

  it 'returns spending money as an integer' do
    expect(visitor.spending_money).to eq(10)
  end
end
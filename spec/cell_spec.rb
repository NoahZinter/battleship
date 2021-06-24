require './lib/ship'
require './lib/cell'

describe Cell do
  before(:each) do
    @cell = Cell.new('B3')
  end

  describe '#initialize' do
    it 'exists' do
      expect(@cell).is_a? Cell
    end
  end
end
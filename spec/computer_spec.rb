require './lib/board'
require './lib/cell'
require './lib/computer'
require './lib/game'
require './lib/player'
require './lib/ship'

describe Computer do
  before(:each) do
    board = Board.new(4)
    @computer = Computer.new(board)
    @ship_1 = @computer.ships.first
    @ship_2 = @computer.ships[1]
  end
  describe '#initialize' do
    it 'exists' do
      expect(@computer).is_a? Computer
    end

    it 'has a board' do
      expect(@computer.board).is_a? Board
    end

    it 'has ships' do
      expect(@computer.ships).to eq([@ship_1, @ship_2])
    end
  end

  describe '#coordinate_generator' do
    it 'generates valid coordinates' do
      placement_1 = @computer.coordinate_generator(@ship_1)
      placement_2 = @computer.coordinate_generator(@ship_2)

      expect(@computer.coordinate_generator(@ship_1).count).to eq 2
      expect(@ship_1.length).to eq 2
      expect(@computer.coordinate_generator(@ship_1)).is_a? Array
      expect(@computer.board.valid_placement?(@ship_1, placement_1)).to eq true
      expect(@computer.board.valid_placement?(@ship_2, placement_2)).to eq true
      expect(@computer.board.valid_placement?(@ship_1, placement_2)).to eq false
    end
  end
end
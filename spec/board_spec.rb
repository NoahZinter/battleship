require './lib/ship'
require './lib/cell'
require './lib/board'

describe Board do
  before(:each) do
    @board = Board.new(5)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@board).is_a? Board
    end

    it 'has a board length' do
      expect(@board.board_length).to eq 5
      expect(@board.board_length).is_a? Integer
    end

    it 'has cells' do
      expect(@board.cells).is_a? Hash
      expect(@board.cells.count).to eq 25
      expect(@board.cells.keys[0]).to eq 'A1'
      expect(@board.cells.values.last).is_a? Cell
    end
  end

  describe '#letter_generator' do
    it 'generates the first x letters where x is board length' do
      board_2 = Board.new(3)

      expect(@board.letter_generator).to eq(['A', 'B', 'C', 'D', 'E'])
      expect(board_2.letter_generator).to eq(['A', 'B', 'C'])
    end
  end

  describe '#number_generator' do
    it 'generates strings of numbers starting with 1 equal to board length' do
      board_2 = Board.new(6)

      expect(@board.number_generator).to eq(['1', '2', '3', '4', '5'])
      expect(board_2.number_generator).to eq(['1', '2', '3', '4', '5', '6'])
    end
  end

  describe '#coordinate_generator' do
    it 'generates coordinates of letters paired with numbers' do
      board_2 = Board.new(3)

      expected = ['A1', 'A2', 'A3', 'B1', 'B2', 'B3', 'C1', 'C2', 'C3']

      expect(@board.coordinate_generator.count).to eq(25)
      expect(board_2.coordinate_generator.count).to eq(9)
      expect(board_2.coordinate_generator).to eq expected
    end
  end

  describe '#cell_generator' do
    it 'creates a hash of cell objects with each generated coordinate' do
      board_2 = Board.new(3)

      expect(@board.cell_generator.keys.count).to eq 25
      expect(@board.cell_generator).is_a? Hash
      expect(board_2.cell_generator.keys[0]).to eq 'A1'
      expect(board_2.cell_generator.values[0]).is_a? Cell
    end
  end

  describe '#valid_coordinate?' do
    it 'checks whether a coordinate is within cell hash' do
      expect(@board.valid_coordinate?('A1')).to eq true
      expect(@board.valid_coordinate?('E6')).to eq false
    end
  end


end

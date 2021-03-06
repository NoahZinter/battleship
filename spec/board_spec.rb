require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'

describe Board do
  before(:each) do
    @board = Board.new(5)
    @ship = Ship.new('Cruiser', 3)
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

  describe '#equal_length?' do
    it 'checks whether a ship and a placement array are equal in length' do
      ship = Ship.new('Cruiser', 3)
      ship_2 = Ship.new('Buoy', 1)
      placement = ['A1', 'A2', 'A3']
      placement_2 = ['A1', 'A2', 'A3']

      expect(@board.equal_length?(ship, placement)).to eq true
      expect(@board.equal_length?(ship_2, placement_2)).to eq false
    end
  end

  describe '#place' do
    it 'can place a ship along an array of coordinates' do
      @board.place(@ship, ['A1', 'A2', 'A3'])

      expect(@board.cells['A1'].ship).to eq @ship
      expect(@board.cells['A2'].ship).to eq @ship
      expect(@board.cells['A3'].ship).to eq @ship
      expect(@board.cells['A4'].ship).to eq nil
      expect(@board.cells['B1'].ship).to eq nil
    end
  end

  describe '#coordinate_split' do
    it 'splits coordinates into nested array' do
      coordinates = ['A1', 'A2', 'A3']
      expected = [
        ['A', '1'],
        ['A', '2'],
        ['A', '3']
      ]

      expect(@board.coordinate_split(coordinates)).to eq expected
    end
  end

  describe '#letter_ord_array' do
    it 'returns array of ordinals associated with coordinate letters' do
      coordinates = ['A1', 'A2', 'A3']
      expected = [65,65,65]

      expect(@board.letter_ord_array(coordinates)).to eq expected
    end
  end

  describe '#number_array' do
    it 'returns array of numbers from coordinates' do
      coordinates = ['A1', 'A2', 'A3']
      expected = [1,2,3]

      expect(@board.number_array(coordinates)).to eq expected
    end
  end

  describe '#placed_cells' do
    it 'returns the cells associated with coordinate keys' do
      coordinates = ['A1', 'A2', 'A3']
      expected = [@board.cells['A1'], @board.cells['A2'], @board.cells['A3']]
      expect(@board.placed_cells(coordinates)).to eq expected
    end
  end

  describe '#one_element?' do
    it 'returns true if array is all one element' do
      array_1 = ['a', 'a', 'a']
      array_2 = ['a', 'A', 'a']
      array_3 = [5,5,5]
      array_4 = [5,5,6]

      expect(@board.one_element?(array_1)).to eq true
      expect(@board.one_element?(array_2)).to eq false
      expect(@board.one_element?(array_3)).to eq true
      expect(@board.one_element?(array_4)).to eq false
    end
  end

  describe '#increment?' do
    it 'returns true if array increments' do
      array_1 = [1,2,3]
      array_2 = [1,2,4]
      array_3 = [3,4,5,6,7]
      array_4 = [65, 65, 66]

      expect(@board.increment?(array_1)).to eq true
      expect(@board.increment?(array_2)).to eq false
      expect(@board.increment?(array_3)).to eq true
      expect(@board.increment?(array_4)).to eq false
    end
  end

  describe '#order_check?' do
    it 'returns true with increasing numbers' do
      coords = ['A1', 'A2', 'A3']
      letter_ords = @board.letter_ord_array(coords)
      numbers = @board.number_array(coords)

      expect(@board.order_check?(letter_ords, numbers)).to eq true
    end

    it 'returns true with increasing letters' do
      coords = ['A1', 'B1', 'C1']
      letter_ords = @board.letter_ord_array(coords)
      numbers = @board.number_array(coords)

      expect(@board.order_check?(letter_ords, numbers)).to eq true
    end

    it 'rejects diagonals' do
      coords = ['A1', 'B2', 'C3']
      letter_ords = @board.letter_ord_array(coords)
      numbers = @board.number_array(coords)

      expect(@board.order_check?(letter_ords, numbers)).to eq false
    end

    it 'rejects repeated letters' do
      coords = ['A1', 'B1', 'B2']
      letter_ords = @board.letter_ord_array(coords)
      numbers = @board.number_array(coords)

      expect(@board.order_check?(letter_ords, numbers)).to eq false
    end

    it 'rejects skipped numbers' do
      coords = ['A1', 'A2', 'A4']
      letter_ords = @board.letter_ord_array(coords)
      numbers = @board.number_array(coords)

      expect(@board.order_check?(letter_ords, numbers)).to eq false
    end
  end

  describe '#number_header' do
    it 'renders the numbers horizontally' do
      expect do
        @board.number_header
      end.to output("     1          2          3          4          5\n").to_stdout
    end
  end

  describe '#letter_hasher' do
    it 'creates a hash with board letters as keys and empty arrays as values' do
      expected = {
        'A' => [],
        'B' => [],
        'C' => [],
        'D' => [],
        'E' => []
      }

      expect(@board.letter_hasher).to eq expected
    end

    it 'creates variable size hashes' do
      board_2 = Board.new(3)

      expected = {
        'A' => [],
        'B' => [],
        'C' => []
      }

      expect(board_2.letter_hasher).to eq expected
    end
  end

  describe '#cell_hasher' do
    it 'populates letter hash with matching cells' do
      expected = {
        'A' => [@board.cells['A1'], @board.cells['A2'], @board.cells['A3'], @board.cells['A4'], @board.cells['A5']],
        'B' => [@board.cells['B1'], @board.cells['B2'], @board.cells['B3'], @board.cells['B4'], @board.cells['B5']],
        'C' => [@board.cells['C1'], @board.cells['C2'], @board.cells['C3'], @board.cells['C4'], @board.cells['C5']],
        'D' => [@board.cells['D1'], @board.cells['D2'], @board.cells['D3'], @board.cells['D4'], @board.cells['D5']],
        'E' => [@board.cells['E1'], @board.cells['E2'], @board.cells['E3'], @board.cells['E4'], @board.cells['E5']]
      }
      expect(@board.cell_hasher).is_a? Hash
      expect(@board.cell_hasher).to eq expected
    end
  end

  describe '#cell_render' do
    it 'returns a hash of letters as keys and rendered cells as values' do
      expected = {
        'A' => ['????','????','????','????','????'],
        'B' => ['????','????','????','????','????'],
        'C' => ['????','????','????','????','????'],
        'D' => ['????','????','????','????','????'],
        'E' => ['????','????','????','????','????'],
      }

      expect(@board.cell_render(true)).to eq(expected)
    end

    it 'renders ships when appropriate' do
      @board.place(@ship, ['A1', 'A2', 'A3'])
      expected = {
        'A' => ['????','????','????','????','????'],
        'B' => ['????','????','????','????','????'],
        'C' => ['????','????','????','????','????'],
        'D' => ['????','????','????','????','????'],
        'E' => ['????','????','????','????','????'],
      }

      expect(@board.cell_render(true)).to eq(expected)
    end

    it 'hides ships without argument' do
      @board.place(@ship, ['A1', 'A2', 'A3'])
      expected = {
        'A' => ['????','????','????','????','????'],
        'B' => ['????','????','????','????','????'],
        'C' => ['????','????','????','????','????'],
        'D' => ['????','????','????','????','????'],
        'E' => ['????','????','????','????','????'],
      }

      expect(@board.cell_render(nil)).to eq(expected)
    end
  end

  describe '#render' do
    it 'sends a board to stdout' do
      board_2 = Board.new(3)
      expect do
        board_2.render
      end.to output("     1          2          3\n\nA   ????         ????         ????\n\n\n\nB   ????         ????         ????\n\n\n\nC   ????         ????         ????\n\n\n").to_stdout
    end

    it 'shows ships with argument' do
      board_2 = Board.new(3)
      board_2.place(@ship, ['A1', 'A2', 'A3'])
      expect do
        board_2.render(true)
      end.to output("     1          2          3\n\nA   ????         ????         ????\n\n\n\nB   ????         ????         ????\n\n\n\nC   ????         ????         ????\n\n\n").to_stdout
    end
  end

  describe '#fire #shot_evaluate' do
    it 'fires on a cell' do
      expect(@board.cells['A1'].fired_upon?).to eq false

      expect do
        @board.fire('A1')
      end.to output("\n\"A1 missed!\"\n").to_stdout

      expect(@board.cells['A1'].fired_upon?).to eq true
    end

    it 'can register a hit' do
      @board.place(@ship, ['A1', 'A2', 'A3'])
      expect(@board.cells['A1'].fired_upon?).to eq false

      expect do
        @board.fire('A1')
      end.to output("\n\"A1 hit a ship!\"\n").to_stdout

      expect(@board.cells['A1'].fired_upon?).to eq true
    end

    it 'can sink a ship' do
      @board.place(@ship, ['A1', 'A2', 'A3'])
      expect(@board.cells['A1'].ship.sunk?).to eq false
      expect(@board.cells['A2'].ship.sunk?).to eq false
      expect(@board.cells['A3'].ship.sunk?).to eq false

      expect do
        @board.fire('A1')
      end.to output("\n\"A1 hit a ship!\"\n").to_stdout
      expect do
        @board.fire('A2')
      end.to output("\n\"A2 hit a ship!\"\n").to_stdout
      expect do
        @board.fire('A3')
      end.to output("\n\"A3 sunk the ship!\"\n").to_stdout

      expect(@board.cells['A1'].ship.sunk?).to eq true
      expect(@board.cells['A2'].ship.sunk?).to eq true
      expect(@board.cells['A3'].ship.sunk?).to eq true
    end
  end
end

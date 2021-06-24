class Board

  attr_reader :board_length,
              :cells
  def initialize(board_length)
    @board_length = board_length
    @cells = cell_generator
  end

  def letter_generator
    potential_letters = ('A'..'Z').to_a
    potential_letters[0..(@board_length - 1)]
  end

  def number_generator
    letters = letter_generator
    letters.map.with_index { |letter, index| (index + 1).to_s }
  end

  def coordinate_generator
    letters = letter_generator
    numbers = number_generator
    letters.map do |letter|
      letter = numbers.map do |coordinate|
        letter + coordinate
      end
    end.flatten
  end

  def cell_generator
    cells = {}
    coordinates = coordinate_generator
    coordinates.map do |coordinate|
      cells[coordinate] = Cell.new(coordinate)
    end
    cells
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end
end

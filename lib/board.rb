class Board

  attr_reader :board_length
  def initialize(board_length)
    @board_length = board_length
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
end

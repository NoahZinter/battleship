class Board

  attr_reader :board_length
  def initialize(board_length)
    @board_length = board_length
  end

  def letter_generator
    potential_letters = ('A'..'Z').to_a
    potential_letters[0..(@board_length - 1)]
  end
end

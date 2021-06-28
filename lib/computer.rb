require './lib/player'

class Computer < Player

  def coordinate_generator(ship)
    random = @board.cells.keys.combination(ship.length).to_a.shuffle
    random.find do |array|
      @board.valid_placement?(ship, array)
    end
  end

  def place_ships
    @ships.each do |ship|
      @board.place(ship, coordinate_generator(ship))
    end
  end
end
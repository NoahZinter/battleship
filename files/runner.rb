require './lib/board'
require './lib/cell'
require './lib/computer'
require './lib/game'
require './lib/player'
require './lib/ship'

board = Board.new(3)
# player = Player.new(board)
computer = Computer.new(board)

# cruiser = Ship.new('Cruiser', 3)
# player.place_ships
computer.place
# computer.board.render(true)
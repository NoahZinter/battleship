require './lib/board'
require './lib/cell'
require './lib/game'
require './lib/player'
require './lib/ship'

describe Player do
  before(:each) do
    board = Board.new(4)
    @player = Player.new(board)
  end
  describe '#initialize' do
    it 'exists' do
      expect(@player).is_a? Player
    end

    it 'has a board' do
      expect(@player.board).is_a? Board
    end

    it 'starts without ships' do
      expect(@player.ships).to eq([])
    end
  end

  describe '#computer_greeting' do
    it 'greets and renders board' do
      expected = "I have placed my ships!\nNow it's your turn, punk.\nThis is YOUR BOARD!\nIt's empty. Put some ships on it!\n-------------------------\n     1          2          3          4\n\nA   🌊         🌊         🌊         🌊\n\n\n\nB   🌊         🌊         🌊         🌊\n\n\n\nC   🌊         🌊         🌊         🌊\n\n\n\nD   🌊         🌊         🌊         🌊\n\n\n\n\n\n\n"

      expect do
        @player.computer_greeting
      end.to output(expected).to_stdout
    end
  end

  describe '#cruiser_coordinate_prompt' do
    it 'outputs prompt' do
      expect do
        @player.cruiser_coordinate_prompt
      end.to output("You have a cruiser. It cruises. Place it. It is 3 units long.\nEnter the squares for the Cruiser. They should be three in a row/column.\nNO DIAGONALS!\n").to_stdout
    end
  end

  describe '#coordinate_grabber' do
    it 'prompts coordinates and places a ship' do
    end
  end

end
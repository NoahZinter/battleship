require './lib/board'
require './lib/cell'
require './lib/computer'
require './lib/game'
require './lib/computer'
require './lib/ship'

describe Game do
  before(:each) do
    @game = Game.new

  end
  describe '#initialize' do
    it 'exists' do
      expect(@game).is_a? Game
    end

    it 'starts with game_over of false' do
      expect(@game.game_over).to eq false
    end

    it 'starts with max length of 3' do
      expect(@game.max_length).to eq 3
    end

    it 'has a player' do
      expect(@game.player).to eq nil

      @game.player_creator(4)

      expect(@game.player).is_a? Player
    end

    it 'has a computer' do
      expect(@game.computer).to eq nil

      @game.player_creator(4)

      expect(@game.computer).is_a? Computer
    end
  end

  describe '#welcome_message' do
    it 'sends welcome to stdout' do
      expect do
        @game.welcome_message
      end.to output("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\nWelcome to BATTLESHIP!!!!\nEnter (P) to play. Enter (Q) to quit.\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n").to_stdout
    end
  end

  describe '#welcome' do
    it 'prompts inputs' do
      
    end
  end

  describe '#welcome_evaluate' do
    it 'starts when input == P' do
      
    end

    it 'quits when input == Q' do
      
    end

    it 'restarts prompt for invalid input' do
      
    end
  end
end
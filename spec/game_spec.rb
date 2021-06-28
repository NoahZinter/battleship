require './lib/board'
require './lib/cell'
require './lib/computer'
require './lib/game'
require './lib/player'
require './lib/ship'

describe Game do
  before(:each) do
    @game = Game.new
    
  end
  describe '#initialize' do
    it 'exists' do
      
    end

    it 'starts with game_over of false' do
      
    end

    it 'starts with max length of 3' do
      
    end

    it 'has a player' do
      
    end

    it 'has a computer' do
      
    end
  end

  describe '#welcome_message' do
    it 'sends welcome to stdout' do
      
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
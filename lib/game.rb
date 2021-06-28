class game

  attr_reader :player,
              :computer,
              :max_length,
              :game_over
  def initialize
    @player = player
    @computer = computer
    @game_over = false
    @max_length = 3
  end

  def welcome_message
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts "Welcome to BATTLESHIP!!!!"
    puts "Enter (P) to play. Enter (Q) to quit."
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  end

  def welcome
    welcome_message
    input = gets.chomp.upcase!
    welcome_evaluate(input)
  end

  def welcome_evaluate(input)
    if input == "P"
      start
    elsif input == "Q"
      puts "Goodbye!"
    else
      puts "Invalid input"
      puts
      welcome
    end
  end

  def board_setter
    puts "How big should the board be? Enter a number between 1-26."
    board_length = gets.chomp
    @max_length = board_length.to_i
    player_creator(@max_length)
  end

  def player_creator(length)
    player_board = Board.new(length)
    computer_board = Board.new(length)
    @player = Player.new(@player_board)
    @computer = Computer.new(@computer_board)
  end

  def create_ship
    puts "Now create your own ship!!\n\n\nEnter your new  ship's name ->"
    name = gets.chomp.capitalize
    puts "How long should #{name} be? ->"
    length = gets.chomp.to_i
    length_evaluate(length)
  end

  def length_evaluate(length)
    if length > @max_length
      puts "That ship is too large!!\n\n"
      create_ship
    end
  end

  def ship_initializer(name, length)
    player_ship = Ship.new(name, length)
    computer_ship = Ship.new(name, length)
    player.add_ship(player_ship)
    computer.add_ship(computer_ship)
  end
end
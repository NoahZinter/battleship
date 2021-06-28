class Game

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

  def play
    board_setter
    create_ship
    show_computer_board
    show_player_board
    player.place_ships
    computer.place_ships
    gameplay
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
      play
    elsif input == "Q"
      puts "Goodbye!"
    else
      puts "Invalid input"
      puts
      welcome
    end
  end

  def board_setter
    puts "How big should the board be? Enter a number between 3-26."
    board_length = gets.chomp.to_i
    if board_length_correct?(board_length)
      @max_length = board_length
      player_creator(@max_length)
    else
      puts 'Invalid Length!'
      board_setter
    end
  end

  def board_length_correct?(length)
    if length.between?(3, 26)
      true
    else
      false
    end
  end

  def player_creator(length)
    player_board = Board.new(length)
    computer_board = Board.new(length)
    @player = Player.new(player_board)
    @computer = Computer.new(computer_board)
  end

  def create_ship
    puts "Now create your own ship!!\n\n\nEnter your new  ship's name ->"
    name = gets.chomp.capitalize
    puts "How long should #{name} be? ->"
    length = gets.chomp.to_i
    length_evaluate(length)
    ship_initializer(name, length)
  end

  def length_evaluate(length)
    if length <= 0
      puts 'Length must be positive'
      create_ship
    end
    if length > @max_length
      puts 'Length too long!'
      create_ship
    end
  end

  def ship_initializer(name, length)
    player_ship = Ship.new(name, length)
    computer_ship = Ship.new(name, length)
    player.add_ship(player_ship)
    computer.add_ship(computer_ship)
  end

  def show_computer_board
    puts "==========COMPUTER BOARD=========="
    puts computer.board.render
    puts "==================================\n\n\n"
  end

  def show_player_board
    puts "==========PLAYER BOARD=========="
    puts player.board.render(true)
    puts "================================\n\n\n"
  end

  def dead?(competitor)
    competitor.ships.all? { |ship| ship.health == 0 }
  end

  def game_over?
    if dead?(player)
      @game_over = true
      game_over_message
    elsif dead?(computer)
      @game_over = true
      game_over_message
    else
      @game_over = false
    end
    @game_over
  end

  def game_over_message
    if dead?(player)
      puts "Computer won."
    elsif dead?(computer)
      puts "YOU WON!!!!!!"
    end
  end

  def player_shot
    show_player_board
    show_computer_board
    puts "Time to 🔥 FIRE 🔥\n\nEnter your shot coordinate ->"
    coordinate = gets.chomp.upcase!
    coordinate_evaluator(coordinate)
    puts "\n"
  end

  def coordinate_evaluator(coordinate)
    target_board = computer.board
    if target_board.valid_coordinate?(coordinate) && target_board.cells[coordinate].fired_upon?
      puts "\n\n!!!Already Fired Here!!!\n\n\n----------------------"
      player_shot
    elsif target_board.valid_coordinate?(coordinate) && !target_board.cells[coordinate].fired_upon?
      target_board.fire(coordinate)
    else
      puts "\n\nThat's not a coordinate. What are you doing?\n\n^^^^^^^^^^^^^^^^^^^^^^^^^^^"
      player_shot
    end
  end

  def computer_shot
    cell = available_player_cells.first
    puts "\n\n <<COMPUTER>> 'I shoot at #{cell.coordinate}'"
    player.board.fire(cell.coordinate)
    puts "\n"
  end

  def available_player_cells
    possible = player.board.cells.values
    unfired = possible.select { |cell| !cell.fired_upon? }
    unfired.shuffle!
  end

  def gameplay
    loop do
      player_shot
      if game_over?
        puts "game over"
        puts "\n"
        welcome
      break
      end
    computer_shot
      if game_over?
        puts "game over"
        puts "\n"
        welcome
      break
      end
    end
  end
end

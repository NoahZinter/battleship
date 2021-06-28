class Player
  attr_reader :board,
              :ships
  def initialize(board)
    @board = board
    @ships = [Ship.new('Submarine', 2), Ship.new('Cruiser', 3)]
  end

  def place_ships
    @ships.each { |ship| coordinate_grabber(ship) }
  end

  def add_ship(ship)
    @ships << ship
  end

  def computer_greeting
    puts "I have placed my ships!"
    puts "Now it's your turn, punk."
    puts "This is YOUR BOARD!"
    puts "It's empty. Put some ships on it!"
    puts "-------------------------"
    puts board.render(true)
  end

  def coordinate_grabber(ship)
    coordinates = []
    puts "This 🛳  is your #{ship.name}"
    puts "It is #{ship.length} units long"
    puts "Place it on your board!\n"
    x = 1
    (ship.length).times do
      puts "Enter coordinate number #{x} ->"
      x += 1
      coordinate = gets.chomp.upcase!
      coordinates << coordinate
    end
    validity_checker(ship, coordinates)
  end

  def validity_checker(ship, coordinates)
    if !board.valid_placement?(ship, coordinates)
        puts "Those coordinates are not valid!\n\n"
        coordinate_grabber(ship)
    else
      board.place(ship, coordinates)
      puts board.render(true)
      puts "Look! Your #{ship.name}\n\n"
    end
  end
end
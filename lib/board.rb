class Board

  attr_reader :board_length,
              :cells
  def initialize(board_length)
    @board_length = board_length
    @cells = cell_generator
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

  def cell_generator
    cells = {}
    coordinates = coordinate_generator
    coordinates.map do |coordinate|
      cells[coordinate] = Cell.new(coordinate)
    end
    cells
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def equal_length?(ship, coordinate_array)
    coordinate_array.length == ship.length
  end

  def valid_placement?(ship, coordinate_array)
    return false if coordinate_array.any? { |coordinate| !valid_coordinate?(coordinate) }
    return false if !equal_length?(ship, coordinate_array)
    return false if placed_cells(coordinate_array).any? { |cell| !cell.empty? }
    letter_ords = letter_ord_array(coordinate_array)
    numbers = number_array(coordinate_array)
    order_check?(letter_ords, numbers)
  end

  def place(ship, coordinate_array)
    return false if !valid_placement?(ship, coordinate_array)
    placed_cells(coordinate_array).each { |cell| cell.place_ship(ship) }
  end

  def coordinate_split(coordinate_array)
    coordinate_array.map { |coord| coord.split('') }
  end

  def letter_ord_array(coordinate_array)
    coordinate_split(coordinate_array).map { |array| array[0].ord }
  end

  def number_array(coordinate_array)
    coordinate_split(coordinate_array).map { |array| array[1].to_i }
  end

  def placed_cells(coordinate_array)
    coordinate_array.map { |coord| @cells[coord] }
  end

  def one_element?(array)
    array.uniq.count == 1
  end

  def increment?(array)
    array.each_cons(2).all? { |x,y| y == x + 1 }
  end

  def order_check?(letter_ords, numbers)
    if one_element?(letter_ords)
      increment?(numbers)
    elsif one_element?(numbers)
      increment?(letter_ords)
    elsif increment?(letter_ords)
       one_element?(numbers)
    elsif increment?(numbers)
      one_element?(letter_ords)
    else
      false
    end
  end

  def number_header
    puts '     ' + number_generator.join('          ')
  end

  def letter_hasher
    letter_generator.reduce({}) do |hash, letter|
      hash.update(letter => [])
    end
  end

  def cell_hasher
    cells = @cells.map {|coord, cell| cell }
    letter_hash = letter_hasher
    cells.map do |cell|
      letter_hash.map do |key, value|
        if cell.coordinate[0] == key
          letter_hash[key] << cell
        end
      end
    end
    letter_hash
  end

  def cell_render(show_ships)
    cell_hash = cell_hasher
    # binding.pry
    cell_hash.each do |letter, array|
      cell_hash[letter] = array.map do |cell|
        cell.render(show_ships)
      end
    end

  end

  def format_render

  end


end

class Cell

  attr_reader :coordinate,
              :ship
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = ship
    @fired_upon = false
  end

  def empty?
    @ship == nil
  end

  def fired_upon?
    @fired_upon
  end

  def place_ship(ship)
    return false if !empty?
    @ship = ship
  end

  def fire_on
    @fired_upon = true
  end
end
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
    if fired_upon?
      return 'Already Fired Here!'
    end
    @fired_upon = true
    if !empty?
      @ship.hit
    end
  end
end
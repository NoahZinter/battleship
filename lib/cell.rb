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

  def render(show_ships = nil)
    if show_ships == true && (!empty? && sunk?)
      '💀'
    elsif show_ships == true && (!empty? && hit?)
      '🔥'
    elsif show_ships == true && (!empty? && blank?)
      '🛳'
    elsif blank?
      '🌊'
    elsif miss?
      '💦'
    elsif sunk?
      '💀'
    elsif hit?
      '🔥'
    end
  end

  def blank?
    !fired_upon?
  end

  def miss?
    fired_upon? && empty?
  end

  def hit?
    fired_upon? && !empty?
  end

  def sunk?
    fired_upon? && ship.sunk?
  end
end

class Ship

  attr_reader :name,
              :length,
              :health
  def initialize(name, length)
    @name = name
    @length = length
    @health = length
  end

  def hit
    if @health >= 1
      @health -= 1
    elsif @health == 0
      return 'Ship Already Sunk!'
    end
  end

  def sunk?
    @health <= 0
  end
end

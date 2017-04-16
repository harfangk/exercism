class SpaceAge
  EARTH_ORBITAL_PERIOD = 31_557_600
  ORBITAL_PERIODS = {
    earth: 1 * EARTH_ORBITAL_PERIOD,
    mercury: 0.2408467 * EARTH_ORBITAL_PERIOD,
    venus: 0.61519726 * EARTH_ORBITAL_PERIOD,
    mars: 1.8808158 * EARTH_ORBITAL_PERIOD,
    jupiter: 11.862615 * EARTH_ORBITAL_PERIOD,
    saturn: 29.447498 * EARTH_ORBITAL_PERIOD,
    uranus: 84.016846 * EARTH_ORBITAL_PERIOD,
    neptune: 164.79132 * EARTH_ORBITAL_PERIOD
  }

  attr_reader :seconds

  def initialize(seconds)
    @seconds = seconds
  end

  def on_earth
    @seconds.to_f / ORBITAL_PERIODS[:earth]
  end

  def on_mercury
    @seconds.to_f / ORBITAL_PERIODS[:mercury]
  end

  def on_venus
    @seconds.to_f / ORBITAL_PERIODS[:venus]
  end

  def on_mars
    @seconds.to_f / ORBITAL_PERIODS[:mars]
  end

  def on_jupiter
    @seconds.to_f / ORBITAL_PERIODS[:jupiter]
  end

  def on_saturn
    @seconds.to_f / ORBITAL_PERIODS[:saturn]
  end

  def on_uranus
    @seconds.to_f / ORBITAL_PERIODS[:uranus]
  end

  def on_neptune
    @seconds.to_f / ORBITAL_PERIODS[:neptune]
  end
end

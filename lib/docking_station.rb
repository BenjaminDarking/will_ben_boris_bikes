require_relative 'Bike'

class DockingStation

  attr_reader :available_bikes
  attr_reader :capacity

  DEFAULT_CAPACITY = 20

  def initialize(capacity = DEFAULT_CAPACITY)
    @available_bikes = []
    @capacity = capacity
  end

  def release_bike
    fail "No bikes available" if empty?
    @available_bikes.pop()
  end

  def full?
    if @available_bikes.count >= @capacity
      true
    end
  end

    def receive_bike(bike)
      fail 'Docking station full' if full?
        @available_bikes << bike
    end

    def empty?
      @available_bikes.empty?
    end
end

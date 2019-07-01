require_relative 'Bike'

class DockingStation

  attr_reader :available_bikes
  attr_reader :capacity
  attr_reader :unavaiable_bikes
  attr_reader :garage_fixed

  DEFAULT_CAPACITY = 20

  def initialize(capacity = DEFAULT_CAPACITY)
    @available_bikes = []
    @capacity = capacity
    @unavaiable_bikes = []
    @garage_broken = []
    @garage_fixed = []
  end

  def release_bike
    fail 'No bikes available' if empty?
    @available_bikes.pop
  end

  def full?
    if @available_bikes.count + @unavaiable_bikes.count >= @capacity
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

  def broken_bike(bike)
     @unavaiable_bikes << bike
  end

  def send_to_garage(bike)
    @garage_broken << bike
  end

  def fixed(bike)
    current_bike = @garage_broken.pop
    @garage_fixed << current_bike
  end

  def fixed_bike
    returning_bike = @garage_fixed.pop
    @available_bikes << returning_bike
  end
end

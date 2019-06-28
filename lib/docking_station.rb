require_relative 'Bike'

class DockingStation

  attr_reader :available_bikes

  def initialize
    @available_bikes = []
    @capacity = 20
  end

  def release_bike
    fail "No bikes available" if empty?
    @available_bikes.pop()
  end

  def full?
    if @available_bikes.length >= @capacity
      true
    end
  end

    def receive_bike(bike)
      if full?
        raise "Docking Station full"
      else
        @available_bikes << bike
      end
    end

    def empty?
      @available_bikes.empty?
    end
end

require './lib/docking_station.rb'


describe DockingStation do
  it 'responds to release_bike' do
    expect(subject).to respond_to :release_bike
  end

  describe '#release_bike' do
    it 'raises an error if docking station is empty' do
      docking_station_3 = DockingStation.new
      expect{docking_station_3.release_bike}.to raise_error "No bikes available"
    end

    subject(:station) do
      station = DockingStation.new
      station.receive_bike(Bike.new)
      station
    end

    # it 'creates a Bike class when method is called' do
    #   expect(station.release_bike).to be_an_instance_of(Bike)
    # end

    it 'releases working bikes' do
      expect(station.release_bike).to be_working
    end

    # it "raises an Error if no Bikes available" do
    #   new_station = DockingStation.new
    #   expect { new_station.release_bike }.to raise_error "No Bikes Available"
    # end
  end

  describe "#receive_bike" do
    it "responds to receive_bike" do
      expect(subject).to respond_to(:receive_bike).with(1).argument
    end
  end

  it "stores the user's bike" do
    boris_bike = Bike.new
    expect(subject.receive_bike(boris_bike)).to include(boris_bike)
  end

  describe "@available_bikes" do
    it "lists all of the available bikes at the station" do
      station = DockingStation.new
      boris_bike = Bike.new
      station.receive_bike(boris_bike)
      expect(station.available_bikes).to eq([boris_bike])
    end
  end

  it "raises an Error after 20 tries to dock bike" do
    new_station_2 = DockingStation.new
    20.times { new_station_2.receive_bike(Bike.new) }
    expect { new_station_2.receive_bike(Bike.new) }.to raise_error "Docking Station full"
  end

end

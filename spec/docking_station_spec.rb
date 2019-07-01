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
      station.receive_bike(bike)
      station
    end


    let(:bike) { double :bike}
    it 'releases working bikes' do
      allow(bike).to receive(:working?).and_return(true)
      subject.receive_bike(bike)
      release_bike = subject.release_bike
      expect(station.release_bike).to be_working
    end
  end




  describe "#receive_bike" do
    it "responds to receive_bike" do
      expect(subject).to respond_to(:receive_bike).with(1).argument
    end

    it "stores the user's bike" do
      boris_bike = Bike.new
      expect(subject.receive_bike(boris_bike)).to include(boris_bike)
    end
  end


  describe "@available_bikes" do
    it "lists all of the available bikes at the station" do
      station = DockingStation.new
      boris_bike = Bike.new
      station.receive_bike(boris_bike)
      expect(station.available_bikes).to eq([boris_bike])
    end
  end


  describe 'broken bike' do
    it "reports a bike as broken when returned" do
      bike = Bike.new
      expect(subject.broken_bike(bike)).to eq [bike]
    end
    it "recieves two broken bikes" do
      bike = Bike.new
      subject.broken_bike(bike)
      expect(subject.broken_bike(bike)).to eq [bike, bike]
    end
    it 'confirming broken bikes' do
      bike_tester = Bike.new
      subject.broken_bike(bike_tester)
      expect(subject.unavaiable_bikes).to include(bike_tester)
    end
    it 'send broken bikes to garage' do
      broken_tester = Bike.new
      subject.broken_bike(broken_tester)
      expect(subject.send_to_garage(broken_tester)).to include(broken_tester)
    end
    it 'allocates fixed bikes in garage' do
      bike = Bike.new
      subject.broken_bike(bike)
      subject.send_to_garage(bike)
      expect(subject.fixed(bike)).to include (bike)
    end
    it 'moves fixed bikes to docking station' do
      bike = Bike.new
      subject.send_to_garage(bike)
      subject.fixed(bike)
      expect(subject.fixed_bike).to include(bike)
    end

  end

  describe 'initialization' do
    let(:bike) { double :bike}
    it 'defaults capacity' do
      DockingStation::DEFAULT_CAPACITY.times{subject.receive_bike(bike)}
      expect { subject.receive_bike(bike) }.to raise_error 'Docking station full'
    end

    it 'defaults capacity' do
    DockingStation::DEFAULT_CAPACITY.times{subject.receive_bike(bike)}
      expect{ subject.receive_bike(bike) }.to raise_error 'Docking station full'
    end
  end
end

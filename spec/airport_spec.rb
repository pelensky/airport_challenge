require "airport"

describe Airport do
let(:airplane) {double :airplane}
let(:airplane1) {double :airplane}
let(:airplane2) {double :airplane}

  context "Setup" do
    it "expects an airport class to exist" do
      expect(subject.class).to eq(Airport)
    end

    it "expects airport to only allow 10 airplanes to land by default" do
      expect(subject.airport_capacity).to eq Airport::AIRCRAFT_HANGERS
    end

    it "expects airport to allow as many airplanes to land as the system maintainer sets" do
      airport = Airport.new(40)
      expect(airport.airport_capacity).to eq(40)
  end

  it "expects no airplanes to be at the airport by default" do
    expect(subject.airplanes_on_ground).to be_empty
  end

  it "can access the Weather class" do
    expect(subject.weather.class).to eq(Weather)
  end
end


  context "Landing" do

    it "expects airport to respond to a land_at_airport method and pass in a plane" do
      expect(subject).to respond_to(:land_at_airport).with(1).argument
    end

    it "expects a plane in the airplane_on_ground array if a plane has landed" do
      subject.land_at_airport(airplane)
      expect(subject.airplanes_on_ground).to include(airplane)
    end

    it "expects airport to respond to a airport_full? method" do
      expect(subject).to respond_to(:airport_full?)
    end

    it "expects airport_full to be true if there are as many (or more) airplanes on the ground as there are the airport capacity" do
      subject.airport_capacity.times {subject.land_at_airport(airplane)}
      expect(subject).to be_airport_full
    end

    it "expects an error message if there is no room at the airport" do
      subject.airport_capacity.times {subject.land_at_airport(airplane)}
      expect{(subject.land_at_airport(airplane)).to raise_error("Sorry, airport full. Try somewhere else.")}
    end

  end

  context "Take Off" do

    it "expects airport to respond to a take_off method" do
      expect(subject).to respond_to(:take_off)
    end

    it "expects an error message if there are no airples and one tries to take off" do
      expect{(subject.take_off).to raise_error("Sorry, a non existant airplane can not take off.")}
    end

    it "expects an airplane to leave the array when the take_off method is called" do
      subject.land_at_airport(airplane)
      subject.land_at_airport(airplane1)
      subject.land_at_airport(airplane2)
      expect(subject.take_off).to eq(airplane2)
    end

    it "expects the airplanes_on_ground array to reflect that an airplane has taken off when the take_off method is called" do
      subject.land_at_airport(airplane)
      subject.land_at_airport(airplane1)
      subject.land_at_airport(airplane2)
      subject.take_off
      expect(subject.airplanes_on_ground).to eq([airplane, airplane1])
    end
  end
end
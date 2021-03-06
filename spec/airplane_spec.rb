require "airplane"

describe Airplane do
  subject(:airplane) { described_class.new }

  it "tests for an Airplane class" do
    expect(airplane.class).to eq(Airplane)
  end

  it "expects a plane to be flying by default" do
    expect(airplane.flying).to eq(true)
  end

  it "expects not to be flying when it lands" do
    airplane.landed
    expect(airplane.flying).to be(false)
  end

  it "expects to be flying after it has taken off" do
    airplane.taken_off
    expect(airplane.flying).to be(true)
  end
end

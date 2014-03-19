require "spec_helper"
require "dog"

describe Dog do
  it "is named 'Pochi'" do
    dog = Dog.new
    expect(dog.name).to eq 'Pochi'
  end
  its(:name) { should eq 'Pochi' }

  it "has fangs" do
    dog = Dog.new
    expect(dog.fangs).to eq 2
  end
  its(:fangs) { should be 2 }

  it "is alived" do
    dog = Dog.new
    expect(dog).to be_alived
  end
end


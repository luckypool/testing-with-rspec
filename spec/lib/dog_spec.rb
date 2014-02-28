require "spec_helper"
require "dog"

describe Dog do
  it "is named 'Pochi'" do
    dog = Dog.new
    expect(dog.name).to eq 'Pochi'
  end

  xit "has fangs" do
  end

  xit "is alived" do
  end
end


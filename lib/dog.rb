class Dog
  attr_accessor :name, :fangs

  def initialize(name="Pochi")
    @name = name
    @fangs = 2
  end

  def alived?
    true
  end
end

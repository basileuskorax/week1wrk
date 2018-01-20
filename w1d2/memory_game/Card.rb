class Card
  attr_reader :value
  attr_accessor :showing

  def initialize(value)
    @value = value
    @showing = false
  end

  def reveal
    @showing = true
  end

  def hide
    self.showing = false
  end

  def to_s
    self.value.to_s
  end

  def ==(arg)
    self.value == arg.value
  end
end

class HumanPlayer
  attr_reader :name

  def initialize(name)
    @name = name
  end


  def prompt
    puts "Please guess a position."
    gets.chomp.split('').map(&:to_i)
  end

  def receive_revealed_card(pos, val)
  end
end

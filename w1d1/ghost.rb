require 'set'

class Game

  def initialize(players=[""], fragments = '', dict = File.readlines('dictionary.txt'))
    @players = players
    @fragments = fragments
    @dict = Set.new(dict)
  end

  def play_round

  end

  def current_player
    current_player = @players[0]
  end

  def previous_player
    previous_player = @players[1]
  end

  def next_player!
    current_player, previous_player  = previous_player, current_player
  end

  def take_turn(player)
    letter = gets.chomp.downcase
    counter = 0
      while counter < 3
        if valid_play?(letter)
          @fragments << letter
          break
        else
        puts "Invalid move! Try again..."
        letter = gets.chomp.downcase
        end
        counter += 1
      end
      puts ''
  end

  def valid_play?(string)
    alphabet = ('a'..'z').to_a
    valid = fragments + string
    selected_words = @dict.keep_if do |word|
      word[0...valid.length] == valid
    end
    alphabet.include?(string) && selected_words
  end

  def losses
    {1 => 'G',
     2 => 'H',
     3 =>  'O',
     4 =>  'S',
     5 => 'T'}
  end

  def record(player)
    player.record << loss 
  end
end

class Player
  def initialize(name, record)
    @name = name
    @record = ''
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.run
end

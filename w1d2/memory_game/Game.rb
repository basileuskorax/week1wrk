require_relative "Board"
require_relative 'human_player'
require_relative 'computer_player'
require 'byebug'

class Game
  attr_reader :players, :board

  def initialize(players)
    @players = players
    @board = Board.new
  end

  def play
    @board.populate
  # debugger
    until @board.won?
      card1, card2 = make_guess

      if card1.value != card2.value
        sleep(2)
        puts "Not a match."
        card1.hide
        card2.hide
      end
      next_player!
    end
  end

  def make_guess
    system('clear')
    board.render

    first_guess = prompt
    card1 = @board[first_guess]
    card1.reveal
    system('clear')
    board.render
    sleep(1)

    your_card = card1.value
    current_player.receive_revealed_card(first_guess, your_card)

    second_guess = prompt
    card2 = @board[second_guess]
    card2.reveal
    system('clear')
    board.render
    sleep(2)

    your_card = card2.value
    current_player.receive_revealed_card(second_guess, your_card)

    [card1, card2]
  end

  def prompt
    current_player.prompt
  end

  def current_player
    @players[0]
  end

  def next_player!
    @players.rotate!
  end

end

if $PROGRAM_NAME == __FILE__
  players = [HumanPlayer.new('Gremblo'), ComputerPlayer.new]
  game = Game.new(players)
  game.play
end

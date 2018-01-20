class ComputerPlayer
  attr_reader :known_cards, :guess1, :guess2, :first_guess

  def initialize
    @name = 'Computer'
    @known_cards = Hash.new { |h, k| h[k] = [] }
    @matched_cards = []
    @first_guess = true
  end

  def receive_revealed_card(pos, val)
    unless @known_cards[val].include?(pos)
      @known_cards[val] << pos
      @matched_cards << val
    end
  end

  # def receive_match(pos1, pos2)
  # end

  def prompt
    if @first_guess
      first_turn
    else
      second_turn
    end
  end

  def first_turn
    @guess1 = nil
    @guess2 = nil
    if knows_pair?
      @guess1, @guess2 = find_pair
    else
      @guess1 = guess_unselected
    end
    @first_guess = false
    @guess1
  end

  def second_turn
    debugger
    if @guess2
      @guess2 = @guess2
    elsif match_revealed_card?
      @guess2 = matched_card
    else
      @guess2 = guess_unselected
    end

    @first_guess = true
    @guess2
  end

  def knows_pair?
    @known_cards.any? do |_, v|
      v.length == 2
    end
  end

  def match_revealed_card?
    last_value = @matched_cards.last

    @known_cards[last_value].length == 2
  end

  def matched_card
    last_value = @matched_cards.last
    @known_cards[last_value][0]
  end

  def find_pair
    pairs = @known_cards.select do |_,v|
      v.length == 2
    end

    pairs.to_a[0][1]
  end

  def guess_unselected
    guess = nil
    until guess
      guess = [(0..1).to_a.sample, (0..9).to_a.sample]
      if already_guessed?(guess)
        guess = nil
      end
    end
    guess
  end

  def already_guessed?(guess)
    @known_cards.values.any? do |value|
      value.include?(guess)
    end
  end

end

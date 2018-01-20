require_relative "Card"
require "byebug"

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(2) { Array.new(10)}
  end

  def populate
    # debugger
    values = ("a".."j").to_a * 2
    values.shuffle!

    (0..grid.length-1).each do |row|
      (0..grid[0].length - 1).each do |col|
          value = values.shift
          self[[row, col]] = Card.new(value)
      end
    end

    # values.shuffle.each.with_index do |value, idx|
    #   self[[0,idx]] = Card.new(value)
    # end
    #
    # values.shuffle.each.with_index do |value, idx|
    #   self[[1,idx]] = Card.new(value)
    # end
  end

  def render
    values = (0..grid.length - 1).map do |row|
      (0..grid[1].length - 1).map do |col|
        card = self[[row, col]]
        if card.showing == true
         card
        else
         "X"
        end
      end
    end
    display(values)
  end

  def display(values)
    values.each do |row|
      puts row.join(' ')
    end
  end

  def won?
    @grid.all? do |row|
      row.all?{|card| card.showing == true}
    end
  end

  def reveal(pos)
    self[pos].showing = true
    self[pos].value
  end

  def [](pos)
     row, col = pos
     @grid[row][col]
  end

  def []=(pos, value)
     row, col = pos
     @grid[row][col] = value
  end
end

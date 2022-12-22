require "colorize"
require_relative "cursor"
require_relative "board"

class Display
  attr_reader :board, :cursor
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  
  def render
    grid = @board.rows.map.with_index do |rows, idx|
      rows.map.with_index do |piece, jdx|
        piece.to_s.colorize(idx, jdx)
      end
    end

    grid.each { |row| p row.join('') }
  end
end


# require 'colorize'

# puts "I am now red".red
# puts "I am now blue".blue
# puts "Testing".yellow
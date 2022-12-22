require_relative "piece.rb"
require "Singleton"

class NullPiece < Piece
  attr_reader :symbol
  include Singleton

  def initialize
    @symbol = " "
    @color = :none
  end

  def empty?
    true
  end

  def moves
    []
  end
end
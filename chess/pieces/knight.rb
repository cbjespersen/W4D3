require_relative 'piece'
require_relative 'steppable'

class Knight < Piece
  include Steppable

  def symbol
    '♞'
  end

  protected

  def move_diffs
    [[-2, -1], [-1, -2], [-2, 1], [-1, 2], [1, -2], [2, -1], [1, 2], [2, 1]]
  end
end
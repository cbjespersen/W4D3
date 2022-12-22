require_relative 'piece'
require_relative 'slideable'

class Bishop < Piece
  include Slideable

  def symbol
    '♝'
  end

  protected
  def move_dirs
    diagonal_dirs
  end
end



# Your Piece will need to (1) track its position and (2) hold a reference to the Board. 
# Classes that include Slideable in particular need the Board so they know to stop 
# sliding when blocked by another piece. Don't allow a piece to move into a square already occupied 
# by the same color piece, or to move a sliding piece past a piece that blocks it.
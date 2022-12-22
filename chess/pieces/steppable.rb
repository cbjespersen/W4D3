module Steppable
  KING_MOVES = [[1,0], [0,-1], [-1,-1], [-1,0], [-1,1], [0,1], [1,1], [1,0]]

  def moves
    # create aray to collect moves
    moves = []
    # iterate through each of the pieces possible move_diffs
    move_diffs.each do |dx, dy|
      x, y = pos
      #  for each move_diff, increment the pieces position to generate a new position
      new_pos = [x + dx, y + dy]

      next unless board.valid_pos?(new_pos)
      
      #  add the new position to the moves array if it is
      # on the board and empty
      if board.empty?(new_pos)
        moves << new_pos
      #  OR on the board and contains opposite color
      elsif board[pos].color != color
        moves << new_pos
      end
    end
    moves
  end

end

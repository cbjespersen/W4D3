class Piece
  attr_reader :board, :color
  attr_accessor :pos

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end
  
  def to_s
    " #{symbol}"
  end

  def empty?
    false
  end

  def valid_moves
    moves.select { |end_pos| !move_into_check?(end_pos) }
  end


  private
  def move_into_check?(end_pos)
    dupped_board = board.dup
    dupped_board.move_piece(color, pos, end_pos)
    dupped_board.in_check?(color)
    
  end
end
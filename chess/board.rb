require_relative "pieces"

class Board
  attr_reader :rows
  
  def initialize
    @null_piece = NullPiece.instance
    @rows = fill_board
  end

  def [](pos)
    raise "Not a valid position" unless valid_pos?(pos)
    x, y = pos
    rows[x][y] 
  end

  def []=(pos, piece)
    raise "Not a valid position" unless valid_pos?(pos)

    x, y = pos
    rows[x][y] = piece
  end

  def move_piece(color, start_pos, end_pos)
    raise "nothing here" if self.empty?(start_pos)
    raise "can't go there...already a piece there" unless self.valid_pos?(end_pos)

    piece = self[start_pos]
    raise "not your turn" if piece.color != color
    raise "you cant move like that" unless piece.moves.include?(end_pos)
    raise "cant put yourself in check" unless piece.valid_moves.include?(end_pos)

    piece = self[start_pos]
    self[end_pos] = piece
    self[start_pos] = null_piece
    piece.pos = end_pos
  end

  def empty?(pos)
    self[pos].empty?
  end

  def valid_pos?(pos)
    x, y = pos
    if x > 7 || y > 7
        return false
    else
        return true
    end
  end

  def add_piece(piece, pos)
    raise "already something there" unless empty?(pos)
    
    self[pos] = piece
  end

  def checkmate?(color)
    return false unless in_check?(color)
    same_color_pieces = pieces.select { |piece| piece.color == color }
    same_color_pieces.all? { |piece| piece.valid_moves.empty? }
  end

  def in_check?(color)
    king_pos = where_is_king(color).pos
    pieces.any? { |piece| piece.moves.include?(king_pos) && piece.color != color }
  end

  def pieces
    @rows.flatten.reject { |pos| pos.empty? }
  end


  private
  attr_reader :null_piece

  def where_is_king(color)
    pieces.select { |piece| piece.is_a?(King) && piece.color == color }
  end

  def fill_front(color)
    front_row = Array.new(8)
    color == :black ? i = 1 : i = 6
    front_row.length.times { |j| self[[i, j]] = Pawn.new(color, self, [i, j]) }
  end

  def fill_back(color)
    back_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    color == :black ? i = 0 : i = 7
    back_row.each_with_index { |class_piece, j| self[[i, j]] = class_piece.new(color, self, [i, j]) }
  end

  def fill_board
    @rows = Array.new(8) { Array.new(8, null_piece) }
    fill_front(:black)
    fill_back(:black)
    fill_front(:white)
    fill_back(:white)
    rows
  end
end

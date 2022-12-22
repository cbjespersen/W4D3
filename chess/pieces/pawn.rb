require_relative "piece"

class Pawn < Piece

  def symbol
    '♟'.colorize(color)
  end

  def moves
    forward_steps + side_attacks
  end

  private
  def at_start_row?
    if pos.first
      color == :white ? 6 : 1
    end
  end

  def forward_dir
    color == :black ? 1 : -1
  end

  def forward_steps
    x, y = pos
    not_first_step = [x + forward_dir, y]

    possible_steps = [not_first_step]
    first_step = [x + 2 * forward_dir, y]
    possible_steps << first_step if at_start_row? && board.empty?(first_step)

    possible_steps
  end

  def side_attacks
    x, y = pos

    side_attack = [[x + forward_dir, y - 1], [x + forward_dir, y + 1]]

    side_attack.select do |enemy_pos|
      unless board.valid_pos?(enemy_pos)
        next
      end

      if board.empty?(enemy_pos)
        next
      end

      enemy_piece = board[enemy_pos]
      enemy_piece && enemy_piece.color != color
    end
  end
end
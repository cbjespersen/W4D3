require_relative 'board'
require_relative 'human_player'

class Game

  attr_reader :board, :display, :player1, :player2 :current_player

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @player1 = HumanPlayer.new(:white, @display)
    @player2 = HumanPlayer.new(:black, @display)
    @current_player = @player1
  end

  def play
    
  end

  private

  def notify_players
  end

  def swap_turn!

  end
end
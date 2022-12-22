require "io/console"

KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up,
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

class Cursor

  attr_reader :cursor_pos, :board

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
  end

  def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end

  private

  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw! # in raw mode data is given as is to the program--the system
                 # doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
                             # numeric keycode. chr returns a string of the
                             # character represented by the keycode.
                             # (e.g. 65.chr => "A")

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads
                                                   # at most maxlen bytes from a
                                                   # data stream; it's nonblocking,
                                                   # meaning the method executes
                                                   # asynchronously; it raises an
                                                   # error if no data is available,
                                                   # hence the need for rescue

      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode :)

    return input
  end

  def handle_key(key)
    case key
    when :ctrl_c
      exit 0
    when :return || :space
      cursor_pos
    when :left || :right || :up || :down
      update_pos(MOVES[key])
    end
  end

  def update_pos(diff)
    # some position = [cursor_pos[0] + difference[0] , cursor_pos[1] + diff[1] ]
    new_pos = [cursor_pos[0] + diff[0], cursor_pos[1], diff[1]]

    # @cursor_pos = some position if board.valid_pos?(some position)
    cursor_pos = new_pos if board.valid_pos?(new_pos)
  end
end
# Fill in the #update_pos(diff) method. It should use the diff to reassign @cursor_pos to a new position. You may wish to write a Board#valid_pos? method to ensure you update @cursor_pos only when the new position is on the board.

# Render the square at the @cursor_pos display in a different color. Test that you can move your cursor around the board by creating and calling a method that loops through Display#render and Cursor#get_input (much as Player#make_move will function later!).


# Depending on the key, #handle_key(key) will a) return the @cursor_pos (in case of :return or :space), b) call #update_pos with the appropriate movement difference from MOVES and return nil (in case of :left, :right, :up, and :down), or c) exit from the terminal process (in case of :ctrl_c). To exit a terminal process, use the Process.exit method. Pass it the status code 0 as an argument
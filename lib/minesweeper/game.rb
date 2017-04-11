module MineSweeper
  class Game
    attr_reader :board, :completed

    def initialize(args = {})
      @board     = Board.new(args[:width], args[:height], args[:mines])
      @completed = false
    end

    def click(ycoord, xcoord)
      lose if board.click(ycoord, xcoord) == :lose
    end

    def complete
      @completed = true
    end

    def start
      loop do
        board.display
        Action.next_action.perform(self)
        break if completed
        break win if board.won?
      end
    end

    def toggle_mine(ycoord, xcoord)
      board.toggle_mine(ycoord, xcoord)
    end

    private

    def lose
      complete
      board.display
      puts "You lose!"
    end

    def win
      board.display
      puts "You won!"
    end
  end
end

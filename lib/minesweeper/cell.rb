module MineSweeper
  class Cell
    attr_reader :button, :mine_count, :mine, :neighbors, :clicked, :guessed
    %i[clicked guessed mine].each { |method| alias_method :"#{method}?", method }

    def initialize(args = {})
      @button     = args[:button]
      @mine_count = args[:mine_count]
      @mine       = args[:mine]
      @neighbors  = args[:neighbors]

      board = args[:board]
      @button.command(-> { click(board) })
      @button.bind('ButtonRelease-2', -> { toggle_mine(board) })
    end

    def click(board)
      return if clicked?
      @clicked = true

      if !mine? && mine_count.zero?
        neighbors.each { |neighbor| board.click(neighbor) }
        disable
      end

      update(board)
    end

    def disable
      button.state = 'disabled'
    end

    def toggle_mine(board)
      @guessed = !@guessed
      update(board)
    end

    private

    def display(board)
      case
      when guessed?                    then 'm'
      when clicked? && mine?           then 'x'
      when !mine? && !mine_count.zero? then mine_count
      end
    end

    def update(board)
      button.text = display(board).to_s
      board.update_status
    end
  end
end

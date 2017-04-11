module MineSweeper
  module Cell
    class BaseCell
      attr_reader :neighbors, :clicked, :guessed

      alias_method :clicked?, :clicked
      alias_method :guessed?, :guessed

      def initialize(neighbors)
        @neighbors = neighbors
        @clicked   = false
        @guessed   = false
      end

      def click(board)
        return if clicked?
        @clicked = true
        after_click(board)
      end

      def display(board)
        return 'm' if guessed
        clicked? ? clicked_display(board) : ' '
      end

      def mine?
        false
      end

      def toggle_mine
        @guessed = !@guessed
      end
    end

    class MineCell < BaseCell
      def after_click(_)
        :lose
      end

      def clicked_display(_)
        'X'
      end

      def mine?
        true
      end
    end

    class NeighborCell < BaseCell
      def after_click(_)
      end

      def clicked_display(board)
        @clicked_display ||=
          neighbors.count { |neighbor| board.cell_at(neighbor).mine? }.to_s
      end
    end

    class EmptyCell < BaseCell
      def after_click(board)
        neighbors.each { |neighbor| board.cell_at(neighbor).click(board) }
      end

      def clicked_display(_)
        '.'
      end
    end

    def self.build_from(predicates, predicate, neighbors)
      if predicate
        MineCell.new(neighbors)
      elsif neighbors.any? { |neighbor| predicates[neighbor] }
        NeighborCell.new(neighbors)
      else
        EmptyCell.new(neighbors)
      end
    end
  end
end

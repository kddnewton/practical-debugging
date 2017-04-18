module MineSweeper
  module AfterClick
    class Base
      attr_reader :cell

      def initialize(cell)
        @cell = cell
      end
    end

    class Default < Base
      def perform(_) end
    end

    class EmptyCell < Base
      def perform(board)
        cell.neighbors.each { |neighbor| board.click(neighbor) }
        cell.disable
      end
    end

    def self.for(cell)
      if !cell.mine? && cell.mine_count.zero?
        EmptyCell.new(cell)
      else
        Default.new(cell)
      end
    end
  end
end

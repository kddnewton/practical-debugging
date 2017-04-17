require 'tk'
require 'minesweeper/board'
require 'minesweeper/cell'

module MineSweeper
  def self.start(args = {})
    Board.new({ width: 20, height: 10, mines: 2 }.merge(args)).start
  end
end

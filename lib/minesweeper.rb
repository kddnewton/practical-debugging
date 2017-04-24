require 'tk'
require 'minesweeper/board'
require 'minesweeper/cell'

module MineSweeper
  DEFAULTS = { width: 20, height: 10, mines: 10 }

  def self.start(args = {})
    Board.new(DEFAULTS.merge(args)).start
  end
end

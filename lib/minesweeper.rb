require 'minesweeper/action'
require 'minesweeper/board'
require 'minesweeper/cell'
require 'minesweeper/game'

module MineSweeper
  def self.start(args = {})
    Game.new({ width: 20, height: 10, mines: 2 }.merge(args)).start
  end
end

Status = Struct.new(:text)
Button =
  Struct.new(:foobar) do
    def command(*) end
    def bind(*) end
  end

board = MineSweeper::Board.new(mines: 10)
board.instance_eval do
  @status = Status.new
  @cells  = [
    MineSweeper::Cell.new(mine: true, button: Button.new)
  ]
end

before = GC.stat[:total_allocated_objects]
10_000.times { board.update_status }
puts GC.stat[:total_allocated_objects] - before

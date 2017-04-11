module MineSweeper
  class Board
    attr_reader :width, :height, :cells

    def initialize(width, height, mines)
      @width  = width
      @height = height
      @cells  = build_from(mines)
    end

    def cell_at(index)
      cells[index]
    end

    def click(ycoord, xcoord)
      cell_at(index_for(ycoord, xcoord)).click(self)
    end

    def display
      print erase if @displayed

      puts '  ' + (0...width).step(2).map { |file| file % 10 }.to_a.join(' ')
      puts " +#{'-' * width}+"
      height.times do |ycoord|
        print "#{ycoord}|"
        width.times do |xcoord|
          print cell_at(index_for(ycoord, xcoord)).display(self)
        end
        puts "|#{ycoord}"
      end
      puts " +#{'-' * width}+"
      puts '   ' + (1...width).step(2).map { |file| file % 10 }.to_a.join(' ')

      @displayed = true
    end

    def toggle_mine(ycoord, xcoord)
      cell_at(index_for(ycoord, xcoord)).toggle_mine
    end

    def won?
      cells.all? { |cell| cell.clicked? || cell.mine? && cell.guessed? }
    end

    private

    def build_from(mines)
      predicates = (Array.new(mines, true) +
                    Array.new(width * height - mines, false)).shuffle

      predicates.map.with_index do |predicate, idx|
        neighbors = neighbors_for(idx / width, idx % width)
        Cell.build_from(predicates, predicate, neighbors)
      end
    end

    def erase
      @erase ||= (height + 5).times.map { "#{`tput cuu1`}#{`tput el`}" }.join
    end

    def neighbors_for(ycoord, xcoord)
      [
        index_for(ycoord - 1, xcoord - 1),
        index_for(ycoord - 1, xcoord),
        index_for(ycoord - 1, xcoord + 1),
        index_for(ycoord,     xcoord - 1),
        index_for(ycoord,     xcoord + 1),
        index_for(ycoord + 1, xcoord - 1),
        index_for(ycoord + 1, xcoord),
        index_for(ycoord + 1, xcoord + 1)
      ].compact
    end

    def index_for(ycoord, xcoord)
      return nil if ycoord < 0 || xcoord < 0 ||
                    ycoord >= height || xcoord >= width
      ycoord * width + xcoord
    end
  end
end

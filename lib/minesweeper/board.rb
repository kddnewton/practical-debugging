module MineSweeper
  class Board
    attr_reader :width, :height, :mines, :cells, :status_label

    def initialize(args = {})
      @width  = args[:width]
      @height = args[:height]
      @mines  = args[:mines]
      @cells  = build_from(args[:mines])
    end

    def cell_at(index)
      cells[index]
    end

    def click(ycoord, xcoord)
      cell_at(index_for(ycoord, xcoord)).click(self)
    end

    def start
      tk_root = TkRoot.new { title 'MineSweeper' }
      @status_label = build_status_label(tk_root)

      height.times do |ycoord|
        width.times do |xcoord|
          button = TkButton.new(tk_root) { grid(column: xcoord, row: ycoord + 1) }
          cells[index_for(ycoord, xcoord)].init(button, self)
        end
      end

      Tk.mainloop
    end

    def update_status
      status_label.text =
        if cells.any? { |cell| cell.mine? && cell.clicked? }
          cells.each(&:disable)
          'You lose!'
        elsif cells.all? { |cell| !cell.mine? || (cell.mine? && cell.guessed?) }
          cells.each(&:disable)
          'You win!'
        else
          count = cells.count(&:mine?) - cells.count(&:guessed?)
          "#{count} mines left"
        end
    end

    private

    def build_status_label(tk_root)
      init_status = "#{mines} mines left"
      columnspan  = width

      TkLabel.new(tk_root) do
        text init_status
        grid(column: 0, row: 0, columnspan: columnspan)
      end
    end

    def build_from(mines)
      predicates = (Array.new(mines, true) +
                    Array.new(width * height - mines, false)).shuffle

      predicates.map.with_index do |predicate, idx|
        neighbors = neighbors_for(idx / width, idx % width)
        Cell.build_from(predicates, predicate, neighbors)
      end
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

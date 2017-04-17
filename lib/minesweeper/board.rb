module MineSweeper
  class Board
    attr_reader :width, :height, :mines, :cells, :status

    def initialize(args = {})
      @width  = args[:width]
      @height = args[:height]
      @mines  = args[:mines]
    end

    def click(index)
      cells[index].click(self)
    end

    def start
      tk_root = TkRoot.new { title 'MineSweeper' }
      @cells  = build_cells(tk_root)
      @status = build_status_label(tk_root)
      Tk.mainloop
    end

    def update_status
      status.text =
        if cells.any? { |cell| cell.mine? && cell.clicked? }
          'You lose!'
        elsif cells.all? { |cell| !cell.mine? || (cell.mine? && cell.guessed?) }
          'You win!'
        else
          count = cells.count(&:mine?) - cells.count(&:guessed?)
          "#{count} mines left"
        end
    end

    private

    def build_cells(tk_root)
      predicates = (Array.new(mines, true) +
                    Array.new(width * height - mines, false)).shuffle

      height.times.flat_map do |ycoord|
        width.times.map do |xcoord|
          index      = index_for(ycoord, xcoord)
          neighbors  = neighbors_for(ycoord, xcoord)

          Cell.new(
            board:      self,
            button:     TkButton.new(tk_root) { grid(column: xcoord, row: ycoord + 1) },
            mine:       predicates[index],
            mine_count: neighbors.count { |neighbor| predicates[neighbor] },
            neighbors:  neighbors
          )
        end
      end
    end

    def build_status_label(tk_root)
      init_status = "#{mines} mines left"
      columnspan  = width

      TkLabel.new(tk_root) do
        text init_status
        grid(column: 0, row: 0, columnspan: columnspan)
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

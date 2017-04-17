module MineSweeper
  class Board
    attr_reader :width, :height, :mines, :cells, :status_label

    def initialize(args = {})
      @width  = args[:width]
      @height = args[:height]
      @mines  = args[:mines]
      @cells  = Array.new(width * height)
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

      predicates = (Array.new(mines, true) +
                    Array.new(width * height - mines, false)).shuffle

      height.times do |ycoord|
        width.times do |xcoord|
          index  = index_for(ycoord, xcoord)
          cell   = Cell.build_from(predicates, predicates[index], neighbors_for(ycoord, xcoord))
          button = TkButton.new(tk_root) { grid(column: xcoord, row: ycoord + 1) }

          cell.init(button, self)
          cells[index] = cell
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

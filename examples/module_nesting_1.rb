module MineSweeper
  module Cell
    class Base
    end
  end

  class Cell::Mine < Base
  end

  class Cell::Neighbor < Base
  end

  class Cell::Empty < Base
  end
end

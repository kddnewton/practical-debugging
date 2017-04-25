module MineSweeper
  module Cell
    class Base
    end

    puts Module.nesting; exit

    class Mine < Base
    end

    class Neighbor < Base
    end

    class Empty < Base
    end
  end
end

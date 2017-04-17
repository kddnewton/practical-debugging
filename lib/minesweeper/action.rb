module MineSweeper
  module Action
    class ClickAction
      attr_reader :ycoord, :xcoord

      def initialize(ycoord, xcoord)
        @ycoord = ycoord
        @xcoord = xcoord
      end

      def perform(game)
        game.click(ycoord, xcoord)
      end
    end

    class ToggleMineAction
      attr_reader :ycoord, :xcoord

      def initialize(ycoord, xcoord)
        @ycoord = ycoord
        @xcoord = xcoord
      end

      def perform(game)
        game.toggle_mine(ycoord, xcoord)
      end
    end

    class QuitAction
      def perform(game)
        game.complete
      end
    end

    def self.next_action
      print '?> '

      case gets.strip.downcase
      when 'q', 'quit', 'exit' then QuitAction.new
      when /\A(\d+) (\d+)\z/   then ClickAction.new($2.to_i, $1.to_i)
      when /\Am (\d+) (\d+)\z/ then ToggleMineAction.new($2.to_i, $1.to_i)
      else
        puts 'Could not parse your input, try again.'
        next_action
      end
    end
  end
end

%w[action board cell game].each do |filename|
  require "./#{filename}"
end

MineSweeper::Game.new(20, 10, 2).start

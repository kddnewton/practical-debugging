def puts_constants(constant)
  puts constant.name

  constant.constants.each do |identifier|
    child_constant = constant.const_get(identifier)

    if child_constant != constant && child_constant.is_a?(Class)
      puts_constants(child_constant)
    end
  end
end

puts_constants(MineSweeper)

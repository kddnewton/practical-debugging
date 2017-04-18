puts "\nAncestors:"
puts MineSweeper::AfterClick::EmptyCell.ancestors.inspect

puts "\nDescendants (OS):"
clazz = MineSweeper::AfterClick::Base
puts (ObjectSpace.each_object(clazz.singleton_class).to_a - [clazz]).inspect

puts "\nDescendants (AS):"
require 'active_support'
require 'active_support/core_ext'
puts MineSweeper::AfterClick::Base.descendants.inspect

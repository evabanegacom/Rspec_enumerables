# frozen_string_literal: true

require './lib/module.rb'

array = [1, 2, 3, 4, 5]

p array.my_inject { |x, y| x * y }

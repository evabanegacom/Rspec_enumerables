module Enumerable
  def my_each
    return enum_for unless block_given?

    elements = is_a?(Range) ? to_a : self
    index = 0
    elements.size.times do
      yield(elements[index])
      index += 1
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    elements = is_a?(Range) ? to_a : self
    index = 0
    size.times do
      yield(elements[index], index)
      index += 1
    end
    self
  end

  def my_select(&array)
    return enum_for unless block_given?

    selected_items = []
    my_each do |x|
      selected_items.push(x) unless array.call(x) == false
    end
    selected_items
  end

  # rubocop: disable Style/CaseEquality, Style/IfInsideElse
  def my_all?(args = nil)
    res = true
    my_each do |x|
      if block_given?
        res = false unless yield(x)
      elsif !args
        res = false unless x
      else
        res = false unless args === x
      end
    end
    res
  end

  def my_any?(args = nil)
    res = false
    my_each do |x|
      if block_given?
        res = true if yield(x)
      elsif !args
        res = true if x
      else
        res = true if args === x
      end
    end
    res
  end

  def my_none?(args = nil)
    res = true
    my_each do |x|
      if block_given?
        res = false if yield(x)
      elsif !args
        res = false if x
      else
        res = false if args === x
      end
    end
    res
  end

  # rubocop: enable Style/CaseEquality, Style/IfInsideElse

  def my_count(arguement = nil)
    counter = 0
    if arguement
      my_each { |x| counter += 1 if x == arguement }
    elsif block_given?
      my_each { |x| counter += 1 if yield(x) }
    else
      counter = length
    end
    counter
  end

  def my_map(proc = nil)
    return to_enum unless block_given?

    selected = []
    if proc
      my_each { |x| selected.push(proc.call(x)) }
    else
      my_each { |x| selected.push(yield(x)) }
    end
    selected
  end

  def my_inject(element = nil, symbol = nil, &block) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    element = element.to_sym if element.is_a?(String) && !symbol && !block
    if element.is_a?(Symbol) && !symbol
      block = element.to_proc
      element = nil
    end
    symbol = symbol.to_sym if symbol.is_a?(String)
    block = symbol.to_proc if symbol.is_a?(Symbol)
    my_each { |x| element = element.nil? ? x : block.yield(element, x) }
    element
  end
end

def multiply_els(item)
  array = Array(item)
  array.my_inject { |x, y| x * y }
end

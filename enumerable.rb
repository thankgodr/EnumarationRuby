module Enumerable
  def my_each
    return to_enum unless block_given?

    each do |i|
      yield i
    end
  end

  def my_each_with_index
    return to_enum unless block_given?

    (0..size - 1).my_each do |i|
      yield(self[i], i)
    end
  end

  def my_select
    return to_enum unless block_given?

    arr = []
    (0...size).my_each { |i| arr << self[i] if yield(self[i]) }
    arr
  end

  def my_all?(variable = nil)
    status = true
    count = 0
    my_each { |x| !nil_check(x) ? count += 1 : count = count }
    return count == size if !block_given? && variable.nil?

    if block_given?
      count = 0
      my_each { |x| count += 1 if yield x }
      status = count == size
    else
      status = size == veb_check(self, variable)
    end
    status
  end

  def my_any?(variable = nil)
    status = false
    count = 0
    my_each { |x| count += 1 unless nil_check(x) }
    return count.positive? if !block_given? && variable.nil?

    if block_given?
      count = 0
      my_each { |x| count += 1 if yield x }
      status = count != 0
    else
      status = veb_check(self, variable).positive?
    end
    status
  end

  def my_none?(arg = nil, &block)
    !my_any?(arg, &block)
  end

  def my_count(variable = nil)
    count = 0
    (0..size - 1).my_each do |i|
      if !block_given? && variable.nil?
        count = size
      elsif block_given?
        count += 1 if yield(self[i])
      else
        count += 1 unless self[i] != variable
      end
    end
    count
  end

  def my_map(&proc)
    arr = []
    return to_enum unless block_given?

    (0..size - 1).my_each do |i|
      arr << yield(self[i]) if !proc && yield(self[i])
      arr << yield(self[i]) if proc&.call(self[i]) || !proc&.call(self[i])
    end
    arr
  end

  def my_inject(variable = 0, variable2 = nil)
    return perform(variable, variable2) if variable2.is_a?(Symbol) || variable.is_a?(Symbol)

    if variable.zero?
      total = 0
      my_each_with_index do |i, index|
        if index.zero?
          total = i
          next
        end
        total = yield(total, i)
      end
    else
      total = variable
      my_each { |i| total = yield(total, i) }
    end
    total
  end

  def multiply_els(variable)
    variable.my_inject { |prod, num| prod * num }
  end
end

module Enumerable
  def nil_check(arg)
    arg.nil? || arg == false ? true : false
  end

  def veb_check(arr, variable)
    count = 0
    if variable.is_a?(Regexp)
      arr.my_each { |x| x.match?(variable) ? count += 1 : count = count }
    elsif variable.is_a?(Class)
      arr.my_each { |x| x.is_a?(variable) ? count += 1 : count = count }
    else
      arr.my_each { |x| count += 1 if x == variable }
    end
    count
  end

  def calculate(total, number, operator)
    total.send operator, number
  end

  def perform(variable, variable2)
    total = variable.is_a?(Symbol) ? 0 : variable
    if nil_check(variable2)
      my_each { |x| total = calculate(total, x, variable) }
    else
      my_each { |x| total = calculate(total, x, variable2) }
    end
    total
  end
end

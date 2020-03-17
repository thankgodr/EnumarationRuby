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
    (0...size - 1).my_each do |i|
      arr << self[i] if yield(self[i])
    end
    arr
  end

  def my_all?(variable = nil)
    status = true
    my_each do |x|
      status = nil_check(x)
    end
    return status unless block_given? || !variable.nil?

    if block_given?
      my_each { |x| return false unless yield x }
    else
      status = size == veb_check(self, variable)
    end
    status
  end

  def my_any?(variable = nil)
    status = false
    my_each { |x| status = true if nil_check(x) }
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

  def my_inject(variable = 0)
    if variable.is_a? Symbol
      total = 0
      my_each { |i| total = "#{total} #{variable} #{i}" }
      return total
    end
    total = variable || self[0]
    (1..size).each { |i| total = yield(total, i) }
    total
  end

  def multiply_els(variable)
    variable.my_inject { |prod, num| prod * num }
  end

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
end

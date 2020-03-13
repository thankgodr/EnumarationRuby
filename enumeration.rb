module Enumerable
  def my_each
    # Should return the array except block is given
    return to_enum unless block_given?

    each do |i|
      yield i
    end
  end

  def my_each_with_index
    # Should return the array except block is given
    return to_enum unless block_given?

    (0..size - 1).my_each do |i|
      yield(self[i], i)
    end
  end

  def my_select
    return to_enum unless block_given?

    # an empty array to store our selected element
    arr = []
    (0...size - 1).my_each do |i|
      arr << self[i] if yield(self[i])
    end
    arr
  end

  def my_all?
    return true unless block_given?

    count = 0
    size.times do |i|
      count += 1 unless yield self[i]
    end
    count.zero?
  end

  def my_any?
    return true unless block_given?

    count = 0
    size.times do |i|
      count += 1 unless yield self[i]
    end
    count != 0
  end

  def my_none?
    return false unless block_given?

    count = 0
    size.times do |i|
      count += 1 unless yield(self[i])
      puts count
    end
    count <= 0
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
    return self unless block_given?

    (0..size - 1).my_each do |i|
      arr << self[i] if !proc && yield(self[i])
      arr << self[i] if proc&.call(self[i])
    end
    arr
  end

  def my_inject(variable = 0)
    (0..size - 1).my_each do |i|
      variable = yield(variable, self[i])
    end
    variable
  end

  def multiply_els(variable)
    variable.my_inject { |prod, num| prod * num }
  end
end

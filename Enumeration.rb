module Enumerable
  def my_each
    # Should return the array except block is given
    return self unless block_given?
    for i in self
      yield i
    end
  end

  def my_each_with_index
    # Should return the array except block is given
    return self unless block_given?
    (0..size - 1).my_each do |i|
      yield(self[i], i)
    end
  end

  def my_select
    return self unless block_given?
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
    (self.size).times do |i|
      count += 1 unless yield self[i]
    end
    count == 0
  end

  def my_any?
    count = 0
    (0..size - 1).my_each do |i|
      count += 1 unless block_given? && (self[i] != false || !self[i].nil?)
      count += 1 if block_given? && self[i] != false && !self[i].nil? && yield(self[i])
    end
    count != 0
  end

  def my_none?
    count = 0
    (0..size - 1).my_each do |i|
      count += 1 unless block_given? && (self[i] == false || self[i].nil?)
      count += 1 if block_given? && (self[i] == false || self[i].nil? || !yield(self[i]))
    end
    count != size
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

  def helper(enum, *expect)
    expect.my_each do |arg|
      if enum == arg
        return true
      end
    end    
    return false
  end
end

[1,1,1,1,4,1].my_each{ |x| 
   puts x * 2
 }
module Enumerable
  def my_each
    return to_enum unless block_given?
    for i in 0..self.size-1
      yield(self[i])
    end
  end

  def my_each_with_index
    return to_enum unless block_given?
    for i in 0..self.size-1
      yield(self[i], i)
    end
  end
end

[1,2,4,5,6].my_each do |x|
  puts x**2
end
[1,2,4,5,6].my_each_with_index do |x, index|
  puts index
end
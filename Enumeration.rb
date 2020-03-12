module Enumerable
  def my_each
    #Should return the array except block is given
    return to_enum unless block_given?
    for i in 0..self.size-1
      yield(self[i])
    end
  end

  def my_each_with_index
    #Should return the array except block is given
    return to_enum unless block_given?
    for i in 0..self.size-1
      yield(self[i], i)
    end
  end

  def my_select
    return to_enum unless block_given?
    #an empty array to store our selected element
    arr = []
    for i in 0...self.size-1
      arr << self[i] if yield(self[i])
    end
    arr
  end

  def my_all?
    count = 0
    for i in 0..self.size-1
      unless block_given? && (self[i] == false || self[i] == nil)
        count += 1
      end
      if block_given? && (self[i] == false || self[i] == nil || yield(self[i]) == false || yield(self[i]) == nil)
        count += 1
      end
    end
    return (count == 0) ? true : false
  end

  def my_any?
    count = 0
    for i in 0..self.size-1
      unless block_given? && (self[i] != false || self[i] != false)
        count += 1
      end
      if block_given? && self[i] != false && self[i] != nil && yield(self[i])
        count += 1
      end
    end
    return (count == 0) ? false : true
  end

  def my_none?
    count = 0
    for i in 0..self.size-1
      unless block_given? && (self[i] === false || self[i] === nil)
        count += 1
      end
      if block_given? && (self[i] == false || self[i] == nil || !yield(self[i]))
        count += 1
      end
    end
    return (count == self.size) ? false : true
  end

  def my_count(arg=nil)
    count = 0
    for i in 0..self.size-1
      if !block_given? && arg==nil
        count = self.size
      elsif block_given?
        count += 1 if yield(self[i])
      else
        count += 1 if self[i] == arg
      end
    end
    count
  end

end 

class MaxIntSet
  def initialize(max)
    @max = max
    @set = Array.new(max)
  end

  def insert(num)
    if num > @max || num < 0
      raise "Out of bounds"
    end
    i = 0
    while i < @set.length
      if @set[i] == num
        return false
      end
      i += 1
    end
    @set.push(num)
    return true
  end

  def remove(num)
    i = 0
    while i < @set.length
      if @set[i] == num
        @set[i] = nil
        return true
      end
      i += 1
    end
  end

  def include?(num)
    i = 0
    while i < @set.length
      if @set[i] == num
        return true
      end
      i += 1
    end
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    if !self.include?(num)
      buc_num = num % @store.length
      @store[buc_num].push(num)
      return true
    end
    false
  end

  def remove(num)
    buc_num = num % @store.length
    @store[buc_num].delete(num)
  end

  def include?(num)
    buc_num = num % @store.length
    i = 0
    while i < @store[buc_num].length
      return true if @store[buc_num][i] == num
      i += 1
    end
    return false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if @count == @store.length
      resize!
    end
    if !self.include?(num)
      buc_num = num % @store.length
      @store[buc_num].push(num)
      @count += 1
      return true
    end
    false
  end

  def remove(num)
    buc_num = num % @store.length
    @store[buc_num].delete(num)
    @count -= 1
  end

  def include?(num)
    buc_num = num % @store.length
    i = 0
    while i < @store[buc_num].length
      return true if @store[buc_num][i] == num
      i += 1
    end
    return false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    newstore = Array.new(@store.length * 2) {Array.new}
    i = 0
    while i < @store.length
      j = 0
      while j < @store[i].length
        num = @store[i][j] % newstore.length
        newstore[num].push(@store[i][j])
        j += 1
      end
      i+=1
    end
    @store = newstore;
  end
end

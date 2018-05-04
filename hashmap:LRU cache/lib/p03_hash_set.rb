require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return false if include?(key)
    @store[key.hash % @store.length].push(key)
    @count += 1
    resize! if num_buckets < @count

    true
  end

  def include?(key)
    self[key.hash % num_buckets].include?(key)
  end

  def remove(key)
    return false unless include?(key)
    self[key.hash % num_buckets].delete(key)
    @count -= 1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
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

require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    num = key.hash % @store.length
    @store[num].include?(key)
  end

  def set(key, val)
    unless include?(key)
      num = key.hash % @store.length
      @store[num].append(key, val)
      @count += 1
      if @count == @store.length
        resize!
      end
    else
      num = key.hash % @store.length
      @store[num].update(key, val)
    end
  end

  def get(key)
    num = key.hash % @store.length
    @store[num].get(key)
  end

  def delete(key)
    if include?(key)
      num = key.hash % @store.length
      @store[num].remove(key)
      @count -= 1
    end
    false
  end

  def each
    @store.each do |bucket|
      bucket.each { |link| yield [link.key, link.val] }
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    newstore = Array.new(@store.length * 2) { LinkedList.new }
    @store.each do |bucket|
      bucket.each do |k,v|
        num = k.hash % newstore.length
        newstore[num].append(k,v)
      end
    end
    @store = newstore
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end

class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
  end
end

class LinkedList
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    empty? ? nil : @head.next
  end

  def last
    if empty?
      return false
    else
      return @tail.prev
    end
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    cur = @head.next
    return nil if cur == @tail
    while true
      return cur.val if cur.key == key
      cur = cur.next
      break if cur == @tail
    end
    nil
  end

  def include?(key)
    cur = @head.next
    return false if cur == @tail
    while true
      if cur.key == key
        return true
      end
      cur = cur.next
      if cur == @tail
        return false
      end
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)

    @tail.prev.next = new_node
    new_node.prev = @tail.prev
    new_node.next = @tail
    @tail.prev = new_node
  end

  def update(key, val)
    cur = @head.next
    return false if cur == @tail
    while true
      if cur.key == key
        cur.val = val
        return true
      end
      cur = cur.next
      break if cur == @tail
    end
    nil
  end

  def remove(key)
    cur = @head.next
    return false if cur == @tail
    while true
      if cur.key == key
        nex = cur.next
        prev = cur.prev
        nex.prev = prev
        prev.next = nex
      end
      cur = cur.next
      break if cur == @tail
    end
    nil
  end

  def each
    current_node = @head.next
    until current_node == @tail
      yield current_node
      current_node = current_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end

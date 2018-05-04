class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[@store.length-1] = @store[@store.length-1], @store[0]
    last_element = @store.pop
    @store = BinaryMinHeap.heapify_down(@store, 0)
    last_element
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    len = @store.length
    @store = BinaryMinHeap.heapify_up(@store, len-1, len)
  end

  public
  def self.child_indices(len, parent_index)
    first = parent_index * 2 + 1
    second = parent_index * 2 + 2
    result = []
    if second < len
      return [first, second]
    end
    if first < len
      return [first]
    else
      return []
    end
  end

  def self.parent_index(child_index)
    if child_index == 0
      raise "root has no parent"
    end
    if child_index % 2 == 0
      child_index / 2 - 1
    else
      child_index / 2
    end
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
      if prc.nil?
      prc = Proc.new do |el1, el2|
        (el1 <=> el2)
      end
    end

    parent_idx.upto(len - 1) do |idx|
      children_indices = child_indices(len, idx)

      parent = array[idx]
      child1 = nil
      child2 = nil

      if children_indices.empty?
        next
      elsif children_indices.length == 1
        child1 = array[children_indices[0]]
      elsif children_indices.length == 2
        child1 = array[children_indices[0]]
        child2 = array[children_indices[1]]
      end

      if (!child1.nil? && prc.call(parent, child1) == 1) && (child2.nil? || prc.call(child1, child2) != 1)
        array[idx], array[children_indices[0]] = array[children_indices[0]], array[idx]
      elsif !child2.nil? && prc.call(parent, child2) == 1
        array[idx], array[children_indices[1]] = array[children_indices[1]], array[idx]
      end
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    if prc.nil?
     prc = Proc.new do |el1, el2|
       (el1 <=> el2)
     end
   end
    while true
      begin parent = BinaryMinHeap.parent_index(child_idx)
        if prc.call(array[parent], array[child_idx]) == 1
          array[parent], array[child_idx] = array[child_idx] , array[parent]
          child_idx = parent
        else
          return array
        end
      rescue
        return array
      end
    end
  end
end

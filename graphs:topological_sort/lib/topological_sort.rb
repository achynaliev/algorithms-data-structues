require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  sorted = []
  queue = []
  degrees = {}

  vertices.each do |vertex|
    if vertex.in_edges.empty?
      queue.unshift(vertex)
    end
    degrees[vertex] = vertex.in_edges.count
  end
  until queue.empty?
    current = queue.pop
    current.out_edges.each do |edge|
      destination = edge.to_vertex

      degrees[destination] -= 1
      queue.unshift(destination) if degrees[destination] == 0 #basically only shove in destination if it has no more paths left
    end

    vertices.delete(current)
    sorted << current
  end

  sorted.length == 2 ? [] : sorted
end

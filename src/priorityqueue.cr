# TODO: Write documentation for `Priorityqueue`
module PriorityQueue
  VERSION = "0.1.0"

  # Minimum-first Array-based PriorityQueue, implemented as a heap.
  class MinHeap(T)
    # Construct an empty PQ.
    def initialize
      @elements = Array(T).new
    end

    # Construct a heap with an initial set of data, in linear time.
    def initialize(data : Enumerable(T))
      @elements = (data.is_a?(Array) ? data.dup : data.to_a)
      if @elements.size > 1
        ((@elements.size // 2) - 1).downto(0) { |i| bubble_down i }
      end
    end

    # Push +element+ onto the priority queue.
    def push(element : T)
      @elements << element
      # bubble up the element that we just added
      bubble_up
      self
    end

    # Inspect the element at the head of the queue.
    def peek
      # the first element will always be the min, because of the heap constraint
      empty? ? nil : @elements[0]
    end

    # Remove and return the next element from the queue, determined by priority.
    def pop
      return nil if empty?
      my_min = @elements[0]
      last = @elements.pop
      unless empty?
        @elements[0] = last
        bubble_down
      end
      my_min
    end

    # Empty the priority queue, discarding any data it contained.
    def clear
      @elements = [] of T
      self
    end

    # Return a boolean indicating whether the queue is empty or not.
    def empty?
      @elements.size < 1
    end

    # Return the number of elements currently stored in the PQ.
    def size
      @elements.size
    end

    # Replace the root element without popping (usually after a peek).
    def replace_first(element : T)
      if element
        @elements[0] = element
        bubble_down
      end
      self
    end

    @[AlwaysInline]
    private def cmp(elt1 : T, elt2 : T)
      elt1 <=> elt2
    end

    private def bubble_up : Nil
      index = @elements.size - 1
      new_value = @elements[index]
      loop do
        parent_index = (index - 1) // 2
        break if (index == 0) || cmp(@elements[parent_index], new_value) <= 0
        @elements[index] = @elements[parent_index]
        index = parent_index
      end
      @elements[index] = new_value
    end

    private def bubble_down(index = 0) : Nil
      return if @elements.size < 2
      target = @elements[index]
      loop do
        child_index = 2 * index + 1
        break if child_index >= @elements.size
        if child_index < @elements.size - 1
          right_index = child_index + 1
          child_index = right_index if cmp(@elements[right_index], @elements[child_index]) < 0
        end
        break if cmp(target, @elements[child_index]) <= 0
        @elements[index] = @elements[child_index]
        index = child_index
      end
      @elements[index] = target
    end
  end

  # Maximum-first Array-based PriorityQueue, implemented as a heap.
  class MaxHeap(T) < MinHeap(T)
    @[AlwaysInline]
    private def cmp(elt1 : T, elt2 : T)
      super(elt2, elt1)
    end
  end
end

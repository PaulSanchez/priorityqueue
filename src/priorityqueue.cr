# Provides implementations for `MinHeap` or `MaxHeap` containers. Elements to be
# stored in the containers must implement `<` and `>` to define their ordering property.
#
#
module PriorityQueue
  VERSION = "0.1.1"

  # Implements a minimum-first `PriorityQueue` using an array-based heap.
  class MinHeap(T)
    # Constructs an empty `PriorityQueue`.
    def initialize
      @elements = Array(T).new
    end

    # Constructs a `PriorityQueue` from an initial set of *data*, in linear time.
    # The *data* can be provided as any `Enumerable` collection, such as an `Array`.
    def initialize(data : Enumerable(T))
      @elements = (data.is_a?(Array) ? data.dup : data.to_a)
      if @elements.size > 1
        ((@elements.size // 2) - 1).downto(0) { |i| bubble_down i }
      end
    end

    # Pushes a single *element* onto the priority queue.
    #
    # Returns `self` so that operations can be chained.
    def push(element : T)
      @elements << element
      bubble_up
      self
    end

    # Inspects the element at the head of the queue without removing it.
    #
    # Returns the value of the first item in the queue, or `nil` if the
    # queue is empty.
    def peek
      empty? ? nil : @elements[0]
    end

    # Removes and returns the element at the head of the queue.
    #
    # Returns the value of the first item in the queue, or `nil` if the
    # queue is empty.
    def pop
      return nil if empty?
      my_first = @elements[0]
      last = @elements.pop
      unless empty?
        @elements[0] = last
        bubble_down
      end
      my_first
    end

    # Empties the priority queue, discarding any data it contained.
    #
    # Returns `self` so that operations can be chained.
    def clear
      @elements = [] of T
      self
    end

    # Returns a boolean indicating whether the queue is empty or not.
    def empty?
      @elements.size < 1
    end

    # Returns the number of elements currently stored in the queue.
    def size
      @elements.size
    end

    # Replaces the current first *element* with the provided *element*,
    # then reorders the elements as needed to restore the heap property.
    #
    # This would usually be done after a `peek` to improve efficiency.
    # If you frequently do a `push` immediately after performing a `pop`
    # this method eliminates the bubble-up operation performed by `pop`,
    # cutting the number of traversals of the heap in half.
    #
    # Returns `self` so that operations can be chained.
    def replace_first(element : T)
      if element
        @elements[0] = element
        bubble_down
      end
      self
    end

    @[AlwaysInline]
    private def cmp(elt1 : T, elt2 : T)
      elt1 < elt2 ? -1 : (elt1 > elt2 ? 1 : 0)
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

  # Implements a maximum-first `PriorityQueue` using an array-based heap.
  # This implementation subclasses `MinHeap` but reverses element comparisons.
  class MaxHeap(T) < MinHeap(T)
    @[AlwaysInline]
    private def cmp(elt1 : T, elt2 : T)
      super(elt2, elt1)
    end
  end
end

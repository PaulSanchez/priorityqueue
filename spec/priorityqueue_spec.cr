require "./spec_helper"

describe PriorityQueue do
  describe "MinHeap Operations" do
    it "should let you insert and remove one item at a time" do
      heap = PriorityQueue::MinHeap(Int32).new
      heap.size.should eq(0)
      heap.empty?.should eq(true)

      heap.push(1)
      heap.push(2)
      heap.push(3)
      heap.size.should eq(3)

      heap.pop
      heap.size.should eq(2)

      heap.clear
      heap.size.should eq(0)
    end

    it "should let you construct with multiple items" do
      heap = PriorityQueue::MinHeap(Int32).new([10, 8, 4, 6])
      heap.size.should eq(4)
      heap.peek.should eq(4)
      heap.empty?.should eq(false)

      heap.replace_first(7)
      heap.size.should eq(4)

      output = Array(Int32 | Nil).new
      (heap.size + 1).times { output << heap.pop }

      output.should eq([6, 7, 8, 10, nil])
    end

    it "should yield data in increasing order" do
      num_items = 100
      random_array = Array.new(num_items) { rand(num_items) }
      heap = PriorityQueue::MinHeap(Int32).new
      random_array.each { |x| heap.push(x) }

      heap.size.should eq(num_items)

      ordered = Array.new(heap.size) { heap.pop.not_nil! }
      ordered.should eq(random_array.sort)
    end
  end

  describe "MaxHeap Operations" do
    it "should let you insert and remove one item at a time" do
      heap = PriorityQueue::MaxHeap(Int32).new
      heap.size.should eq(0)
      heap.empty?.should eq(true)

      heap.push(1)
      heap.push(2)
      heap.push(3)
      heap.size.should eq(3)

      heap.pop
      heap.size.should eq(2)

      heap.clear
      heap.size.should eq(0)
    end

    it "should let you construct with multiple items" do
      heap = PriorityQueue::MaxHeap(Int32).new([4, 6, 10, 8])
      heap.size.should eq(4)
      heap.peek.should eq(10)
      heap.empty?.should eq(false)

      heap.replace_first(7)
      heap.size.should eq(4)
      heap.peek.should eq(8)

      output = Array(Int32 | Nil).new
      (heap.size + 1).times { output << heap.pop }

      output.should eq([8, 7, 6, 4, nil])
    end

    it "should yield data in decreasing order" do
      num_items = 100
      random_array = Array.new(num_items) { rand(num_items) }
      heap = PriorityQueue::MaxHeap(Int32).new
      random_array.each { |x| heap.push(x) }

      heap.size.should eq(num_items)

      ordered = Array.new(heap.size) { heap.pop.not_nil! }
      ordered.should eq(random_array.sort.reverse!)
    end
  end
end

# clear

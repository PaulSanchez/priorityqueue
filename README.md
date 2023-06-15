# priorityqueue

A Crystal module which provides implementations for `MinHeap` and `MaxHeap`
variants of a priority queue.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     priorityqueue:
       github: PaulSanchez/priorityqueue
   ```

2. Run `shards install`

## Usage

### Example1

Simple scenario where the data ordering property is based on the element's values:
```crystal
require "priorityqueue"

random_pq = PriorityQueue::MaxHeap(Int32).new   # create a MaxHeap PriorityQueue for integers
10.times { random_pq.push rand(100) }           # populate it with random numbers
until random_pq.empty?                          # yield the values in descending order 
  puts random_pq.pop
end
```

### Example2

If priorities are distinct from their associated data, you can use `Tuple`s
as in the following example (based on the Priority Queue programming task page
at [rosettacode.org](https://rosettacode.org/wiki/Priority_queue)):
```crystal
require "priorityqueue"

# Array of Tuples containing priorities and associated tasks in random order
tasks = [
  {3, "Clear drains"},
  {4, "Feed cat"},
  {5, "Make tea"},
  {1, "Solve RC tasks"},
  {2, "Tax return"},
]
task_pq = PriorityQueue::MinHeap(Tuple(Int32, String)).new(tasks)
until task_pq.empty?           # yield the tasks in priority order
  puts task_pq.pop
end
```
Produces:
```text
{1, "Solve RC tasks"}
{2, "Tax return"}
{3, "Clear drains"}
{4, "Feed cat"}
{5, "Make tea"}
```

## Contributors

- [Paul J Sanchez](https://github.com/PaulSanchez) - creator and maintainer

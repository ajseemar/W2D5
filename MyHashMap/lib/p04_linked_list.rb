class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

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
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get_node(key)
    self.each do |node|
      return node if node.key == key
    end
  end

  def get(key)
    node = get_node(key)
    node.val unless node.nil?
  end

  def include?(key)
    !get_node(key).nil?
  end

  def append(key, val)
    node = Node.new(key, val)
    prev_node = @tail.prev
    @tail.prev = node
    node.next = @tail
    node.prev = prev_node
    prev_node.next = node
  end

  def update(key, val)
    node = get_node(key)
    node.val = val unless node.nil?
  end

  def remove(key)
    node = get_node(key)
    prev_node = node.prev
    prev_node.next = node.next
    node.next.prev = prev_node
  end

  def each
    current_node = first
    until current_node == @tail
      yield current_node
      current_node = current_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end

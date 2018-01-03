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
    self.prev.next = self.next
    self.next.prev = self.prev
    self.next = nil
    self.prev = nil

    self.val
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
    j = 0
    self.each do |node|
      return node if i == j
      j += 1
    end
    nil
  end

  def first
    return nil if self.empty?
    @head.next
  end

  def last
    return nil if self.empty?
    @tail.prev
  end

  def empty?
    return true if @head.next == @tail
    false
  end

  def get(key)
    self.each { |node| return node.val if node.key == key }
    nil
  end

  def include?(key)
    include = false
    self.each { |node| include = true if node.key == key }
    include
  end

  def append(key, val)
    newest = Node.new(key, val)

    newest.prev = @tail.prev
    newest.next = @tail
    @tail.prev.next = newest
    @tail.prev = newest
  end

  def update(key, val)
    self.each { |node| return node.val = val if node.key == key }
  end

  def remove(key)

    self.each { |node| return node.remove if node.key == key }

  end

  def each
    current = @head.next
    while current != @tail
      yield current
      current = current.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  # end
end

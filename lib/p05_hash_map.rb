require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    delete(key) if self.include?(key)
    resize! if @count >= num_buckets
    bucket(key).append(key, val)
    @count += 1
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    removed = bucket(key).remove(key)
    @count -= 1 if removed
  end

  def each
    @store.each do |bucket|
      bucket.each { |node| yield [node.key, node.val] }
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
    old = @store
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    @count = 0

    old.each do |bucket|
      bucket.each { |node| self.set(node.key, node.val)}
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end

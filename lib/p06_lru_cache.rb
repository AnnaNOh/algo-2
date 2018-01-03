require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map[key]
      node = @map[key]
      update_node!(node)
      # return node.val
    else
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    value = @prc.call(key)
    node = @store.append(key, value)
    @map[key] = node
    eject! if count > @max
    value
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    node.prev.next = node.next
    node.next.prev = node.prev
    # move node to the end
    node.prev = @store.last
    node.next = @store.last.next
    @store.last.next = node
  end

  def eject!
    removed = @store.first
    removed.prev.next = removed.next
    removed.next.prev = removed.prev
    @map.delete(removed.key)
  end
end

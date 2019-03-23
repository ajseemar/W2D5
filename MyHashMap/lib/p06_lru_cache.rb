require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
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
    if !@store.include?(key)
      if @store.count == @max
        head = @store.first.prev
        next_node = @store.first.next
        head.next = next_node
        next_node.prev = head
        # current_node = @store.first
        # @store.delete(current_node)
        # @store.remove(current_node) if current_node != current_node.prev || current_node != @store.last.next
      end
      @store.append(key, @prc.call(key))
    end
    @store.get(key)
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
  end

  def eject!
  end
end

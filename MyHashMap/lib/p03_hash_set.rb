class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if count == num_buckets
    bucket = self[key] 
    if !include?(key)
      bucket << key
      @count += 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    bucket = self[key]
    if include?(key)
      bucket.delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_size = num_buckets*2
    new_store = Array.new(new_size) { Array.new }
    
    @store.each do |bucket|
      bucket.each do |el|
        new_store[el.hash%new_size] << el
      end
    end

    @store = new_store
  end
end
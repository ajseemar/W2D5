require 'byebug'

class MaxIntSet
  attr_reader :max
  def initialize(max)
    @max = max
    @store = Array.new(max) { false }
  end

  def insert(num)
    raise 'Out of bounds' if @store.all? { |el| el == true }
    raise 'Out of bounds' if is_valid?(num)
    @store[num] = true unless include?(num)
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num > max || num < 0
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket = get_bucket(num)
    @store[bucket] << num unless include?(num)
  end

  def remove(num)
    bucket = get_bucket(num)
    @store[bucket].delete(num)
  end

  def include?(num)
    bucket = get_bucket(num)
    @store[bucket].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def get_bucket(num)
    num % num_buckets
  end

end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if count == num_buckets
    bucket = self[num] 
    if !include?(num)
      bucket << num
      @count += 1
    end
  end

  def remove(num)
    bucket = self[num]
    if include?(num)
      bucket.delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_size = num_buckets*2
    new_store = Array.new(new_size) { Array.new }
    
    @store.each do |bucket|
      bucket.each do |el|
        new_store[el%new_size] << el
      end
    end

    @store = new_store
  end
end

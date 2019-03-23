class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    hashed = 0
    self.each_with_index { |el, i| hashed += (el*i).hash }
    hashed
  end
end

class String
  def hash
    hashed = 0
    self.each_char.with_index { |el, i| hashed += ((el.ord)*i).hash }
    hashed
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    key_arr = self.keys
    hashed = 0
    self.sort.each_with_index do |(k, v), idx|
      hashed += (k.to_s.ord * idx).hash + (v.ord * idx).hash
    end
    hashed
  end
end

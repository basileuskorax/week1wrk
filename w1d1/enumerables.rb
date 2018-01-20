class Array
  def my_each(&prc)
      idx = 0

      until idx == self.length
        prc.call(self[idx])
        idx += 1
      end
  end

  def my_select(&prc)
    empty = Array.new
    self.my_each {|el| empty << el if prc.call(el) }
    empty
  end

  def my_any?(&prc)
    any = self.my_select {|el| prc.call(el)}
    !any.empty?
  end

  def my_all?(&prc)
    all = self.my_select {|el| prc.call(el)}
    all.length == self.length
  end

  def my_flatten
    flattened = Array.new
    self.my_each do |el|
      if !el.is_a?(Array)
        flattened << el
      else
        flattened += el.my_flatten
      end
    end

    flattened

  end

  def my_zip(*args)
    args = *args

    result = []
    self.my_each do |el|
      result << [el]

    end

    args.my_each do |ary|
      idx = 0
      while idx < self.length
        result[idx] << ary[idx]
        idx += 1
      end
    end

    result
  end

  def my_rotate(rotate = 1)
  #   result = self
  #   counter = 0
  #   while counter < rotate
  #     moving = result.shift
  #     result << moving
  #     # p result
  #     counter += 1
  #   end
  #
  #   result
  #   # self.my_each do |el|
    result = Array.new(self.length)

    idx = 0
    while idx < self.length
      result[(idx - rotate) % self.length] = self[idx]
      idx += 1
    end
    result
  end

  def my_join(separator = '')
    joined = ''

    self.my_each {|char| joined << char + separator}

    joined[-1] == separator ? joined.chop : joined

  end

  def my_reverse
    result = Array.new
    counter = self.length - 1
    while counter >= 0
      result << self[counter]
      counter -= 1
    end
    result
  end
end

# arr = [1, 2, 3]

# arr.my_each{|n| puts n}
#p arr.my_select{|el| el.odd?}
# p arr.my_all?{|el| el > 1 }

# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# [1, 2, 3].my_zip(a, b)
# p a.my_zip([1,2], [8])

# a = [ "a", "b", "c", "d" ]
#  p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

# a = [ "a", "b", "c", "d" ]
# p a.my_join         # => "abcd"
# p a.my_join("$")    # => "a$b$c$d"

p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]

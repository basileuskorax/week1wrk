require 'byebug'

def range(start_num, end_num)
  return [] if end_num < start_num
  return [start_num] if start_num == end_num - 1
  range_arr = [start_num]
  range_arr + range(start_num+1, end_num)
end

def range_itr(start_num, end_num)
  (start_num...end_num).map { |el| el  }
end

def expone(b, n)
  return 1 if n == 0
  b * expone(b, n - 1)
end

def expone2(b, n)
  return 1 if n == 0
  return b if n == 1
  if n.even?
    expone2(b, n / 2) * expone2(b, n / 2)
  else
    b * (expone2(b, (n -1 ) / 2) * expone2(b, (n -1 ) / 2))
  end
end


def deep_dup(arr)
  return arr.dup if !arr.any? { |e| e.is_a?(Array)}
  duped_arr = []
  arr.each do |el|
    if el.is_a?(Array)
      duped_arr << deep_dup(el)
    else
      duped_arr << el
    end
  end
  duped_arr
end


def fib(n)
  return [0] if n == 0
  return [0,1] if n == 1

  prev_seq = fib(n - 1)
  ult = prev_seq[-1]
  penult = prev_seq[-2]

  prev_seq << penult + ult
end

def fib_it(n)
  return [0] if n == 0
  arr = [0, 1]

  until arr.length - 1 == n
    arr << arr[-1] + arr[-2]
  end

  return arr
end

def subsets(arr)
  return [[]] if arr.empty?
  subsets(arr[0...-1]) + subsets(arr[0...-1]).each{|el| el << arr[-1]}
end


def permutations(arr)
  return [arr] if arr.length <= 1
end

def bsearch(arr, tgt)

  return nil if arr.length <= 1 && arr[0] != tgt


  middle_idx = arr.length/2
  top_half = arr[middle_idx..-1]
  bottom_half = arr[0...middle_idx]

  if arr[middle_idx] == tgt
    return middle_idx
  elsif tgt < arr[middle_idx]
    bsearch(bottom_half, tgt)
  else
    bsearch(top_half, tgt) + middle_idx  unless bsearch(top_half, tgt).nil?
  end
end

require 'byebug'

def range(start, ending)
  return [] if start == ending
  [start] + range(start + 1, ending)
end


def exp1(base, exponent)
  return 1 if exponent == 0
  base * exponent(base, exponent - 1)
end

def exp2(base, n)
  return 1 if n == 0
  return base if n == 1
  if n.even?
    exp2(base, n/2) ** 2
  else
    base * (exp2(base, (n - 1) / 2) ** 2)
  end
end

def deep_dup(array)
  deep_copy = []
  array.each do |el|
    if el.is_a?(Array)
      deep_copy << deep_dup(el.dup)
    else
      deep_copy << el
    end
  end
  deep_copy
end

def fibs(n)
  return [0, 1] if n <= 2

  previous_sequence = fibs(n - 1)
  previous_sequence << previous_sequence[-2] + previous_sequence[-1]
end

def fibs_iteration(n)
  start_arr = [0, 1]
  return start_arr if n == 2
  return [0] if n == 1
  return [] if n <= 0

  (n-2).times do
    start_arr << start_arr[-2] + start_arr[-1]
  end
  start_arr
end

def subsets(array)
  return [[]] if array.length == 0
  prev_array = subsets(array[0...-1])
  new_array = []
  prev_array.each do |el|
    new_array << (el.dup << array.last)
  end
  prev_array + new_array
end

def permutations(array)
  return [array, array.reverse] if array.length == 2

  previous_array = permutations(array[1..-1])
  permutated_arrays = []
  
  previous_array.each do |arr|
    array.length.times do |idx|
      permutated_arrays << arr.dup.insert(idx, array.first)
    end
  end
  
  permutated_arrays.sort
end

def binary_search(arr, target)
  middle_index = arr.length / 2
  return middle_index if arr[middle_index] == target # found
  return nil if arr.length == 1 && arr[middle_index] != target # not found, nowhere else to look

  if arr[middle_index] > target # search left
    p arr[0..middle_index-1]
    binary_search(arr[0..middle_index-1], target)
  else # search right
    p arr[middle_index+1..-1]
    binary_search(arr[middle_index+1..-1], target) + middle_index + 1
  end
end


class Array

  def quick_sort(&prc)
    return self if self.length < 1 

    prc ||= Proc.new { |x,y| x <=> y }

    pivot = [self[0]]
    left = self[1..-1].select { |el| prc.call(el, self.first) == -1 }
    right = self[1..-1].select { |el| prc.call(el, self.first) == 1 }

    left.quick_sort + pivot + right.quick_sort
  end 

  def merge_sort(&prc)
    return self if self.length < 2 

    prc ||= Proc.new { |x, y| x <=> y }

    middle = self.length / 2 

    left = self[0...middle]
    right = self[middle..-1]

    left = left.merge_sort(&prc)
    right = right.merge_sort(&prc)

    Array.merge(left, right, &prc)
  end

  private
  def self.merge(left, right, &prc)
    merged = [] 
 
    until left.empty? || right.empty?
      if prc.call(left[0], right[0]) == -1 
        merged << left[0]
        left.shift 
      else
        merged << right[0]
        right.shift
      end 
    end 
    merged + left + right 
  end
end

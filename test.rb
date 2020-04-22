require_relative 'enumerables'

def test_enumerables
  list1 = [11, 12, 13, 14, 15]

  list2 = [1, 2, 4, 2, 3, 4, 2]

  puts 'Test my_each'
  print("\n")
  list1.my_each { |x| print x + 2, ' ' }

  print("\nMy_each with index\n")

  list1.my_each_with_index { |x, index| print x + index, ' ' }
  print("\n")

  puts 'Test my_select'

  p list1.select(&:even?)
  p list1.my_select(&:even?)

  puts 'Test my_all'
  p list1.my_all { |x| x > 8 }

  p %w[ant bear cat].my_all { |word| word.length >= 4 }

  puts 'Test my_any'
  p %w[ant bear cat].my_any { |word| word.length >= 4 }
  puts 'Test my_none'
  p %w[ant bear cat].my_none { |word| word.length >= 3 }

  puts 'Test my_count'
  p list2.my_count

  p list2.my_count(2)

  p list1.my_count(&:even?)

  puts 'Test my_map'
  list1 = list1.my_map { |x| x + x }
  print list1

  p (1..4).my_map { |i| i * i } #=> [1, 4, 9, 16]
  p (1..4).my_map { 'cat' }

  puts 'Test my_inject'
  p (1..3).my_inject { |sum, n| sum + n }
  p (1..3).inject { |sum, n| sum + n }

  list3 = [1, 2, 3, 4, 5]
  p (5..10).my_inject(:+)

  p (5..10).my_inject(1, :*)
  p (5..10).my_inject(1) { |product, n| product * n }

  longest = %w[cat sheep bear].inject do |memo, word|
    memo.length > word.length ? memo : word
  end

  p longest

  test_proc = proc do |_item|
    'proc'
  end
  puts 'test my_map with proc and block'
  output = (1..2).my_map(test_proc) do |_x|
    'block'
  end
  print output
  puts
  puts 'test my_map with block'

  output = (1..2).my_map do |_item|
    'block'
  end
  print output
  puts
end

test_enumerables

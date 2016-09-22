#!/usr/bin/env ruby
# Task 1
puts "TASK 1"
def my_def (arf)
  start_time = Time.now
  arf.call (1)
  Time.now - start_time
end  
my_proc = Proc.new do |i|
  loop do
    i += 1
    break if i == 100_000
  end  
end
p "time of execution is #{(my_def my_proc).round(2)} seconds" 

# Task 2
puts "TASK 2"
array = [1, 2, 3, 4]
def mega_sum(array, arg2 = 0)
  test_array = array
  test_array.map! {|i| yield(i)} if block_given?
  test_array.inject(arg2) {|i, arg2| arg2 + i}
end
puts mega_sum(array) {|i| i ** 2}

# Task 3
puts "Task 3"
def detection
  (1..1000).detect { |i| i.to_s.size == 3 && i % 7 == 3}  
end 
p "first number is #{detection}"

# Task 4
puts "Task 4"
def my_method (*args, name1: , name2: )
  if block_given?
    puts args.map! {|i| yield(i) }
  else
    puts "ERROR"
  end
end

puts my_method(11,"string_at_#{Time.now}_twise",name1:1,name2:20) {|i| i*2}

# Task 5
puts "Task 5"
  
class Array
  def method_5
    use_array = self.select {|i| i.even?}
    if block_given?
      use_array.select! {|e| yield (e)}
    else
      nil
    end   
  end
end
puts [1, 2, 3, 4, 5, 6, 7].method_5 { |i| i > 2}.inspect # => [4, 6]
puts [1, 2, 3, 4, 5, 6, 7].method_5 { |i| i > 10}.inspect # => nil
puts [2, 4, 6, 8, 10, 12, 7].method_5 {|i| i.between?(6, 12)}.inspect # => [6, 8, 10, 12]


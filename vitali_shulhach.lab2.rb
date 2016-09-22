#! /usr/bin/env ruby
#FIRST FIBONACCI TASK
how_times = ARGV[0].to_i
#how_times = 10
def fibonacci(n)
  first_num = 0
  sec_num = 1
  n.times do
    temp = first_num
    first_num = sec_num
    sec_num = temp + sec_num
  end
  return first_num
end
how_times.times do |n|
   result = fibonacci(n)
   puts result 
end

#SECOND TASK
the_string = "dniMyMdegnahCybuR"
the_string.downcase!.reverse!.capitalize!
puts the_string 

#THIRD TASK
num = 1234567
puts num.to_s.reverse

#Number of a/A:
#another_string = ARGV[1].to_s
another_string = "AssaaaaaaadDDmaagjraaAA12"
puts another_string.scan(/(a|A)/).size

#sum of digits
number = 111001788 
sum = 0
number.to_s.split('').each {|n| sum += n.to_i()}
puts sum

#palindrome string
palind = " abba"
if palind == palind.reverse
  puts %Q(#{palind} is an palindrome)
else 
  puts %Q(#{palind} is not a palindrome)
end


#Вывести на экран числа от 10 до 3 не влючая 5, причём числа, кратные 3м, вывести в квадрате
#puts list
10.downto(3).each do |i|
  if (i % 3).zero?
    puts i**2
  elsif i !=5 
    puts i
  else
    nil
  end 
end
#Дан хэш
shop = {
milk: 10,
bread: 8,
cornflakes: 12,
ice_cream: 15,
pie: 20
}
puts "Answer is " + shop.value?(15).to_s 

#дан массив
ar = [1, 6,1,8,2,-1,3,5]
ar[ar.index(ar.max)] += 100
p ar

#Дан массив:
ar = [7, 3, [4, 5, 1], 1, 9, [2, 8, 1]]
ar = ar.flatten!.sort!.reverse!.uniq!
p ar

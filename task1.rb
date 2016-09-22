#!/usr/bin/env ruby
#PART ONE
#Qestion: if array["key"] is the same as array.fetch("key")
=begin
Commands of ruby installation:
 [vagrant@python ~]$ sudo yum install rubygemsudo yum install ruby ruby-devel ruby-irb rubygems sqlite-devel -y
 [vagrant@python ~]$ sudo gem install pry sqlite3
 [vagrant@python ~]$ ruby -v
 ruby 1.8.7 (2013-06-27 patchlevel 374) [x86_64-linux]
 [vagrant@python ~]$ gem list
 *** LOCAL GEMS ***
 coderay (1.1.1)
 method_source (0.8.2)
 pry (0.10.4)
 slop (3.6.0)
 sqlite3 (1.3.11)
 gem uninstall sqlite3 pry (and press yes)
 [vagrant@python ~]$ sudo yum remove ruby ruby-devel ruby-irb rubygems sqlite-devel -y
  grant@python ~]$ ruby -v
 -bash: /usr/bin/ruby: No such file or directory
 [vagrant@python ~]$ gem list
 -bash: /usr/bin/gem: No such file or directory
 

 sudo gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
 curl -L get.rvm.io | bash -s stable
 source ~/.rvm/scripts/rvm
 [vagrant@python ~]$ rvm requirements
   Checking requirements for centos.
   Installing requirements for centos.
   Installing required packages: patch, libyaml-devel, autoconf, gcc-c++, patch, libffi-devel, automake, libtool, bison, sqlite-devel............
   Requirements installation successful.
 
 rvm install 2.3.0
 [vagrant@python ~]$ rvm gemset create mnt
 [vagrant@python ~]$ rvm use mnt 2.3.0 --default
 gem install pry sqlite3
=end

puts "TASK ONE"
#buckets = [["red",50],["green",100],["blue",30],["yellow",60]]
#buckets_balls=Hash[*buckets.flatten]
buckets_balls = {"red" => 50,"green" => 100,"blue" => 30,"yellow" => 60}
puts buckets_balls.key(buckets_balls.values.max)

if
  buckets_balls.fetch("green") > buckets_balls.fetch("yellow") ||
  buckets_balls.fetch("green") > 
  buckets_balls.fetch("red")+buckets_balls.fetch("blue")
  puts "yes, there are more balls in the green bucket \nthan in the yellow or in the red and blue backets together"
  else
  puts "no"
end

puts "TASK TWO"
cost = 20150
fee = 0.3
money_have = 5600000
ice_cream = 10000
#step one
sum_money=(270*cost)+(270*cost)*fee
puts "we need money to buy 270$: "+sum_money.to_s
#step two
dollar_sum = (money_have/(cost+cost*fee)).to_i
puts "You can buy "+ dollar_sum.to_s 
if money_have-dollar_sum*(cost+cost*fee) > ice_cream
  puts "You can buy at least one ice-cream"
  else 
  puts "sorry, not today"
end

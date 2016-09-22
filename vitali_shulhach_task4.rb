#!/usr/bin/env ruby
class Command
  ALL_COMMANDS = []
    def self.say()
      p "#{Time.now}, #{$0}"
      p "print 'exit' to exit from #{$0}"
      loop do
        print "#{ ENV['USER']} > "
          input = gets.chomp.downcase
          command  = input.split[0]
          args = input.split[1..10]
          if command == "help"
            Help.new.run
          elsif command == "utime"
            Uptime.new.run
          elsif command == "date"
            Date.new.run
          elsif command == "echo"
            Echo.new.run(*args)
          elsif command == "ping"
            Ping.new.run(args)
          elsif command == "exit"
            p "clousing the script #{$0} "
          else
            p "I don't understand you! Use 'help' to see command list"
          end
      break if command == 'exit'
      end
    end
end

class Help < Command
  Command::ALL_COMMANDS.push(Help)
    def self.name
      "help"
    end
    
    def self.description
      " - output the information about commands"
    end

    def run
      Command::ALL_COMMANDS.each do |cmd|
      p "#{cmd.name} #{cmd.description}"
    end
  end
end

class Uptime < Command
  Command::ALL_COMMANDS.push(Uptime)
    def self.name
      "uptime"
    end
  
    def self.description
      " - show system uptime in hours/minutes/seconds"
    end

    def run
      time = IO.read('/proc/uptime').split[0].to_i
      hours = (IO.read('/proc/uptime').split[0].to_i) / 3600
      minutes = (time - hours * 3600) / 60
      seconds = time - hours * 3600 - minutes * 60
      puts "#{hours}h #{minutes}min #{seconds}sec" 
   end
end

class Date < Command
  Command::ALL_COMMANDS.push(Date)
    def self.name
      "date"
    end
  
    def self.description
      " - show current date (today and now is)"
    end

    def run
      puts Time.now
    end
end

class Echo < Command
  Command::ALL_COMMANDS.push(Echo)
    def self.name
      "echo"
    end
  
    def self.description
      " - print user input after 'echo' (till 10 arguments)"
    end

    def run(*args)
      puts "#{args.join(" ")}"
    end
end

class Ping < Command
  Command::ALL_COMMANDS.push(Ping)
    def self.name
      'ping'
    end

    def self.description
      ' - to ping one instance in one time'
    end

    def run( dest, ping_times: 2 )
      puts "#{ ENV['USER']} > in process..."
      `ping -q -c #{ ping_times } #{ dest.join }`
# require 'net/http'
# uri = URI("http://#{dest}")
# res = Net::HTTP.get_response(uri)
# puts res.message 
     if $?.exitstatus == 0
        puts "#{ dest.join } is availible"
     else
        puts "#{ dest.join } is not reachable"
     end
    end
end

Command.say()



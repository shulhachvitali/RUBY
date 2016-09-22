#!/usr/bin/env ruby

require 'yaml'
$config = YAML.load_file('vitali_shulhach_task5.yml')
$log = $config['error_log']
$access = $config['log']

# main class 
class Command
  ALL_COMMANDS = []
  
  def command_by_name(name, *args)
    detected_command = ALL_COMMANDS.detect { |i| i.name == name }
    com = detected_command.new
    say(*args)    
    com.run(args)
    File.open($access, 'a') { |f| f.puts "#{Time.now} #{detected_command} #{$stdout} #{ENV['USER']}" }
  rescue => exc
    File.open($log, 'a') { |f| f.puts "#{Time.now} #{exc.message} #{exc.class}" }
    puts "Unknown command. Use 'help'"
  end
  
  def say(*args)
    puts "#{Time.now}, #{$PROGRAM_NAME}, #{ENV['USER']} #{args.join(' ')}"
  end
end

# help class
class HelpCommand < Command
  Command::ALL_COMMANDS.push(HelpCommand)

  def self.name
    'help'
  end

  def self.description
    $config['help']
  rescue
    'Print info about commands'
  end

  def run(*_args)
    Command::ALL_COMMANDS.each do |cmd|
      puts "#{cmd.name}:  #{cmd.description}"
    end
  rescue => exc
    File.open($log, 'a') { |f| f.puts exc.message }
    puts 'Error was occured. Please, try again'
  end
end

# uptime class
class UptimeCommand < Command
  Command::ALL_COMMANDS.push(UptimeCommand)

  def self.name
    'uptime'
  end

  def self.description
    $config['uptime']
  rescue
    p 'system uptime'
  end

  def run(*_args)
    time = IO.read('/proc/uptime').split[0].to_i
    hours = IO.read('/proc/uptime').split[0].to_i / 3600
    minutes = (time - hours * 3600) / 60
    seconds = time - hours * 3600 - minutes * 60
    puts "#{hours}h #{minutes}min #{seconds}sec"
  rescue => exc
    File.open($log, 'a') { |f| f.puts "#{Time.now} #{exc.message} #{exc.class}" }
    puts 'An error while system uptime was got. Please, try again '
  end
end

# date class
class DateCommand < Command
  Command::ALL_COMMANDS.push(DateCommand)

  def self.name
    'date'
  end

  def self.description
    $config['date']
  rescue
    p 'show current system date'
  end

  def run(*_args)
    puts Time.now
  rescue => exc
    File.open($log, 'a') { |f| f.puts "#{Time.now} #{exc.message} #{exc.class}" }
    puts 'error. please, try again'
  end
end

# echo class
class EchoCommand < Command
  Command::ALL_COMMANDS.push(EchoCommand)

  def self.name
    'echo'
  end

  def self.description
    $config['echo']
  rescue
    p 'print input arguments'
  end

  def run(out)
    p out.join(' ')
  rescue => exc
    File.open($log, 'a') { |f| f.puts "#{Time.now} #{exc.message} #{exc.class}" }
    puts 'echo error'
  end
end

# ping class
class PingCommand < Command
  Command::ALL_COMMANDS.push(PingCommand)

  def self.name
    'ping'
  end

  def self.description
    $config['ping']
  rescue
    p 'ping for site'
  end

  def run(dest)
    puts "#{ENV['USER']} > in process..."
    require 'net/http'
    uri = URI("http://#{dest.join}")
    res = Net::HTTP.get_response(uri)
      if res.message
        puts "#{dest.join} is availible"
      else
        puts "#{dest.join} is not reachable"
      end
  rescue
      File.open($log, 'a') { |f| f.puts "ping error: #{Time.now} #{$!.message} #{$!.class}" }
      puts "#{dest.join} is not reachable"
  end 
end

# Class for exit
class ExitCommand < Command
  Command::ALL_COMMANDS.push(ExitCommand)

  def self.name
    'exit'
  end

  def self.description
    'exit command'
  end

  def run(*_args)
    puts "Good Bye!"
    exit
  end
end

# starting block
loop do
  begin
    print "#{ENV['USER']} > "
    input = gets.chomp.downcase
    command = input.split[0]
    args = input.split[1..10]
    com = Command.new
    com.command_by_name(command, args)
  rescue NoMethodError, Interrupt
    File.open($log, 'a') { |f| f.puts "#{Time.now} #{$!.message} #{$!.class}" }
    puts 'Good Bye!'
    exit 
  end 
end

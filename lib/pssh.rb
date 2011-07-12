require 'rubygems'
require 'fog'
require 'logger'


@pathing = "/Users/tsykoduk/Code/pssh"


require "#{@pathing}/lib/config.rb"
require "#{@pathing}/lib/go.rb"
require "#{@pathing}/lib/aws.rb"


#Parse the options, assigning them to the correct variables.
target = ARGV[0].to_s

#@logz = Logger.new("#{@log_path}#{me}_pish_log", "daily")
#@logz.sev_threshold = Logger::INFO

case target
when "list"
# TODO: sane output when no servers accessable
#  boxen = list_all_servers(groups)
#  if boxen.nil?
#    puts "No servers accessable"
#  else
#    boxen.each do |s|
#      puts s.tags["short_name"]
#    end
#  end   
  boxen = list_all_servers(@groups)
  boxen.each do |s|
    puts s.tags["short_name"]
  end
when "-?", "-h", "--help"
  puts "usage: \"pish <servername>\" to connect, \"pish list\" to generate a list"
else
  ssh_target = mcp(target,@groups)
  case ssh_target[0]
  when 0
    puts "I don't know that server...."
    puts "I tried this server name: #{target}"
    puts "Sorry it did not work out..."
    puts "you might try one of the following:"
    list_all_servers(@groups).each do |s|
      puts s
    end
    #  list_all_servers
    #  TODO: List all servers here
  when 1
    puts ssh_target[1]
  when 2
    puts "trying: ssh#{ssh_target[1]}"
    exec "ssh#{ssh_target[1]}"
  end
end

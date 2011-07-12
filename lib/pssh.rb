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
  boxen = list_all_servers(@groups)
  boxen.each do |s|
    puts s.tags["short_name"]
  end
when "-?", "-h", "--help"
  puts "usage: 
  \n  pssh <servername> to connect
  \n  pssh go <servername> to connect 
  \n  pssh list to generate a list
  \n  pssh push <path/to/file/name> <servername> to push a file to a server
  \n  pssh pull <path/to/file/name> to pull a file from your local machine
  \n  pssh run <script> <servername> to run script on server
  \n  pssh srun <script> <servername> to sudo run a script on a server, passwordless sudo must be set up"
else
  ssh_target = go_mcp(target,@groups)
  case ssh_target[0]
  when 0
    puts "I don't know that server...."
    puts "I tried this server name: #{target}"
    puts "Sorry it did not work out..."
    puts "you might try one of the following:"
    list_all_servers(@groups).each do |s|
      puts s
    end
  when 1
    puts ssh_target[1]
  when 2
    puts "trying: ssh#{ssh_target[1]}"
    exec "ssh#{ssh_target[1]}"
  end
end

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
when "-?", "-h", "--help"
  puts "pssh usage: 
  \n  pssh <servername> to connect
  \n  pssh go <servername> to connect 
  \n  pssh list to generate a list
  \n  pssh push <path/to/file/name> <servername> to push a file to a server
  \n  pssh pull <path/to/file/name> to pull a file from your local machine
  \n  pssh run <script> <servername> to run script on server
  \n  pssh srun <script> <servername> to sudo run a script on a server, passwordless sudo must be set up"
when "go"
  execute_ssh_string(ARGV[1].to_s)
when 
when "list"  
  boxen = list_all_servers(@groups)
  boxen.each do |s|
    puts s.tags["short_name"]
  end
when "push"
  execute_push(ARGV[1].to_s, ARGV[2].to_s)
when "pull"
  execute_pull(ARGV[1].to_s, ARGV[2].to_s)
when "run"
  execute_run(ARGV[1].to_s, ARGV[2].to_s)
when "srun"
  execute_srun(ARGV[1].to_s, ARGV[2].to_s)
else
  puts "I'm assuming that you want to connect to #{target}...Trying now"
  execute_ssh_string(ARGV[0].to_s)
end

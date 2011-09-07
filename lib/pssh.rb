require 'rubygems'
require 'fog'
require 'logger'


@pathing = "/path/to/install/directory"


require "#{@pathing}/lib/config.rb"
require "#{@pathing}/lib/aws.rb"
require "#{@pathing}/lib/go.rb"


#Parse the options, assigning them to the correct variables.
target = ARGV[0].to_s

#@logz = Logger.new("#{@log_path}#{me}_pish_log", "daily")
#@logz.sev_threshold = Logger::INFO

case target
when "-?", "-h", "--help"
  puts "pssh usage: 
    pssh <servername> to connect 
    pssh list to generate a list "
#    pssh go <servername> to connect
#    pssh push <path/to/file/name> <servername> to push a file to a server
#    pssh pull <path/to/file/name> to pull a file from your local machine
#    pssh run <script> <servername> to run script on server
#    pssh srun <script> <servername> to sudo run a script on a server, passwordless sudo must be set up"
#when "go"
#  puts "trying #{ARGV[1].to_s}"
#  ARGV.each do |c| 
#    puts " #{c}"
#  end
#  execute_ssh(ARGV[1].to_s, @current_user[1], @default_group)
when "list"
  boxen = list_all_servers(@current_user[1], @default_group)
  boxen.each do |s|
    puts s.tags["short_name"] + " " + s.tags["group"]
  end
#when "push"
#  execute_push(ARGV[1].to_s, ARGV[2].to_s)
#when "pull"
#  execute_pull(ARGV[1].to_s, ARGV[2].to_s)
#when "run"
#  execute_run(ARGV[1].to_s, ARGV[2].to_s)
#when "srun"
#  execute_srun(ARGV[1].to_s, ARGV[2].to_s)
else
  puts "Trying #{target}... "
  execute_ssh(ARGV[0].to_s, @current_user[1], @default_group)
end

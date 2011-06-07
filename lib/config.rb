## Basic Enviromental Configuration

  # These are provided by AWS for API level access
  @access_key = "My Access Key"
  @secret_key = "My Secret Access Key"
  # This is the "ssh-able" user account on your AWS instance
  @ec2_user = "Default user to login to your ec2 instance with - possibly ubuntu or ec2_user"
  
  # We need to get some info about the user
  @groups = `groups`.split(' ')
  @me = `whoami`
  
  # Set some enviroment settings
  @keyfiledir = "directory to key files"
  @default_group = "staff"
  
  # Remember to set @pathing in the pssh.rb file as well!
def build_connection(target)
  tgt = find_target(target)[0]
  if tgt.nil?
    return false
  else
    whoami = @me
    user = @ec2_user
  end
  #@logz.info {"#{whoami} connection to #{target}"}
  return [tgt.tags["group"],' ' + user + '@' + tgt.private_dns_name + ' -i ' @keyfiledir + tgt.key_name + '.pem']
end

def woops(target, groups)
  whoami = `whoami`
  #  @logz.warn('unauthorized acccess') {"#{whoami} attempted to access #{target}. They are a memeber of the following groups: "}
  #  groups.split(' ').each do |g|
  #    @logz.warn {"#{g}"}
  #  end
  return "you are not authorized to access #{target}. This has been logged, #{whoami}."
end

def go_mcp(target, groups)
  sshtarget = build_connection(target)
  unless sshtarget == false
    if groups.include?(sshtarget[0]) or groups.include?(@default_group)
      return [2,sshtarget[1]]
    else
      return [1,woops(target, groups)]
    end
  else
    return [0]
  end
end

def execute_ssh_string(target)
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
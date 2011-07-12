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

def mcp(target, groups)
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

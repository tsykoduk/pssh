def aws_connect
  compute = Fog::Compute.new(
    :provider		=> 'AWS',
    :aws_access_key_id	=> @access_key,
    :aws_secret_access_key 	=> @secret_key
  )
end

def list_all_servers(groups, default_group)
  compute = aws_connect
  servers_list = []
  compute.servers.each do |server|
    if server_visible(server, groups, default_group)
        servers_list << server   
    end
  end
  return servers_list
end

def server_visible(server, groups, default_group)
  tgt = [server.tags["group"], default_group]
    if tgt & groups == []
      return false
    else
      return true
    end
end

def find_target(target)
  compute = aws_connect
  fred = compute.servers.all('tag:short_name' => target)
  return fred.first
end
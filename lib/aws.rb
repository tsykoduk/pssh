def aws_connect
  compute = Fog::Compute.new(
    :provider		=> 'AWS',
    :aws_access_key_id	=> @access_key,
    :aws_secret_access_key 	=> @secret_key
  )
end


def list_all_servers(groups)
  compute = aws_connect
  i = ["List of all currently available servers"]
  compute.servers.each do |c|
    if groups.include?(c.tags["group"]) or groups.include?("staff")
      i += [c]
    end
  end
end

def find_target(target)
  compute = aws_connect
  compute.servers.all('tag:short_name' => target)
end
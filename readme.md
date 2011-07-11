 PSSH
---

Proxy Secure SHell - a SSH automation tool suitable for use as bastion ssh server, or general hand holder. At this time, only works on AWS. Since it's built on the killer @fog gem, it can be easily expanded.

**Wait, what?**

So, this basically allows us to abstract key management away from the user. The most common use case would be to have a publicly accessible server, with authentication done via the user's ssh keys. When the user sshed into the pssh server, they would be able to use the command line:
 
*pssh ServerName*

and have an SSH session setup and executed for them, with out knowing what keys the internal server needed, the ip address of the internal server or any other boring details.

Taking things a step further, you can restrict all of your internal server's SSH access to just the pssh server(s) ip address, basically creating a choke point for ssh access. Also, when you need to change keys (you do change your keys every 6 - 12 months, right?) it's as easy as just adding the new key files to the pssh server. The users need never know that anything happened.

**pssh In The Wild**

Here is an extreme use case of pssh - valid for hosting providers, or large teams.

*external access*

First off, have two pssh servers set up. Use your load balancer to balance access to them, and either use a shared filesystem or some configuration management tool like Puppet or Chef to create users and managing their access.

*internal servers ssh access*

All of your internal servers should be set up to only allow SSH to and from the pssh cluster. This means that even if someone gets and key off of the pssh server, then cannot easily ssh directly to an internal server, reducing risk.

These servers should be organized into groups. There should be user groups that correspond with these server groups on the pssh servers. Internal keys should have their privileges locked down based on these groups.

*workflow*

Each user that needed command line access to an internal server should be granted an account on the pssh server. I recommend that they provide a ssh key for access. When they are granted access, add them to the groups that grant access to the keys to the servers that they need. They then will be able to use the *pssh list* command to see the names of the servers that they can access, and *pssh ServerName* to build an ssh connection.

From their ssh client of choice, they would *ssh NameOfPsshServer*. I normally set up my local ssh config file with to define the pssh server (or cluster) as pssh, so it would be *ssh pssh*.

They are then connected to the pssh server. If they wanted to ssh to server AppABC, they would simply execute the comment *pssh AppABC* and presto.

**Setup**

There is a bit of setup needed, and a few ways of approaching it.

The most scaleable is a central key repository. We tend to create a /srv/keys directory, and grant folks access to which ever keys they need based on groups (ie, perhaps the sysadmin group needs access to servers 1 and 2, and the devs need access to servers a and b. chown the key for servers 1 and 2 root:sysadmin and the key for a and b root:devs - chmod 640 the entire lot. If the sysadmins also need access to a and b, just put them into the dev group as well.)

I default to a group called "staff" as the general "can go everywhere" type of person. If you want to use a different group - just make sure that you change that in the settings.

I personally put a symlink to pssh into /bin - and then drop it in a logical place. Users can then just fire off pssh from where ever they are at.

**config.rb**

You'll need to edit the /lib/config.rb to reflect your real environment. pssh will not work with out this.

**pssh.rb**

you will also need to edit the @pathing = line in pssh.rb.

**Tags**

you'll also need to set up some tags on your EC2 instances to support all of this.

short_name - the "friendly name" of the machine. ie web2
group - the group that has access to this box. ie sysadmin or devs

**Coming soon:**

On the plate for pssh is an scp command with multi file support (ie pssh send file1 file2 file3 to servername1:/path servername2:/path and pssh pull /path/to/file/on/local/host) as well as a script execution interface (ie pssh run file.sh on server1 server2)

**Built by Viking Coders**

Rawr. Things are not pretty. Brute force is acceptable. 


**pssh is Copyright [2011] [Greg Nokes]**

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this program except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

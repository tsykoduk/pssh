<h2 id="_pssh"> PSSH</h2>

<p><strong>Now with 25% more flavor, and 50% more group support!</strong></p>

<p>Proxy Secure SHell - a SSH automation tool suitable for use as bastion ssh server, or general hand holder. At this time, only works on AWS. Since it&#8217;s built on the killer @fog gem, it can be easily expanded.</p>

<p><strong>Wait, what?</strong></p>

<p>So, this basically allows us to abstract key management away from the user. The most common use case would be to have a publicly accessible server, with authentication done via the user&#8217;s ssh keys. When the user sshed into the pssh server, they would be able to use the command line:</p>

<p><em>pssh ServerName</em></p>

<p>and have an SSH session setup and executed for them, with out knowing what keys the internal server needed, the ip address of the internal server or any other boring details.</p>

<p>Taking things a step further, you can restrict all of your internal server&#8217;s SSH access to just the pssh server(s) ip address, basically creating a choke point for ssh access. Also, when you need to change keys (you do change your keys every 6 - 12 months, right?) it&#8217;s as easy as just adding the new key files to the pssh server. The users need never know that anything happened.</p>

<p><strong>pssh In The Wild</strong></p>

<p>Here is an extreme use case of pssh - valid for hosting providers, or large teams.</p>

<p><em>external access</em></p>

<p>First off, have two pssh servers set up. Use your load balancer to balance access to them, and either use a shared filesystem or some configuration management tool like Puppet or Chef to create users and managing their access.</p>

<p><em>internal servers ssh access</em></p>

<p>All of your internal servers should be set up to only allow SSH to and from the pssh cluster. This means that even if someone gets and key off of the pssh server, then cannot easily ssh directly to an internal server, reducing risk.</p>

<p>These servers should be organized into groups. There should be user groups that correspond with these server groups on the pssh servers. Internal keys should have their privileges locked down based on these groups.</p>

<p><em>workflow</em></p>

<p>Each user that needed command line access to an internal server should be granted an account on the pssh server. I recommend that they provide a ssh key for access. When they are granted access, add them to the groups that grant access to the keys to the servers that they need. They then will be able to use the <em>pssh list</em> command to see the names of the servers that they can access, and <em>pssh ServerName</em> to build an ssh connection.</p>

<p>From their ssh client of choice, they would <em>ssh NameOfPsshServer</em>. I normally set up my local ssh config file with to define the pssh server (or cluster) as pssh, so it would be <em>ssh pssh</em>.</p>

<p>They are then connected to the pssh server. If they wanted to ssh to server AppABC, they would simply execute the comment <em>pssh AppABC</em> and presto.</p>

<p><strong>Setup</strong></p>

<p>There is a bit of setup needed, and a few ways of approaching it.</p>

<p>The most scaleable is a central key repository. We tend to create a /srv/keys directory, and grant folks access to which ever keys they need based on groups (ie, perhaps the sysadmin group needs access to servers 1 and 2, and the devs need access to servers a and b. chown the key for servers 1 and 2 root:sysadmin and the key for a and b root:devs - chmod 640 the entire lot. If the sysadmins also need access to a and b, just put them into the dev group as well.)</p>

<p>I default to a group called &#8220;staff&#8221; as the general &#8220;can go everywhere&#8221; type of person. If you want to use a different group - just make sure that you change that in the settings.</p>

<p>I personally put a symlink to pssh into /bin - and then drop it in a logical place. Users can then just fire off pssh from where ever they are at.</p>

<p><strong>config.rb</strong></p>

<p>You&#8217;ll need to edit the /lib/config.rb to reflect your real environment. pssh will not work with out this.</p>

<p><strong>pssh.rb</strong></p>

<p>you will also need to edit the @pathing = line in pssh.rb.</p>

<p><strong>Tags</strong></p>

<p>you&#8217;ll also need to set up some tags on your EC2 instances to support all of this.</p>

<p>short_name - the &#8220;friendly name&#8221; of the machine. ie web2
group - the group that has access to this box. ie sysadmin or devs</p>

<p><strong>Coming soon:</strong></p>

<p>On the plate for pssh is an scp command with multi file support (ie pssh send file1 file2 file3 to servername1:/path servername2:/path and pssh pull /path/to/file/on/local/host) as well as a script execution interface (ie pssh run file.sh on server1 server2)</p>

<p><strong>Built by Viking Coders</strong></p>

<p>Rawr. Things are not pretty. Brute force is acceptable. </p>

<p><strong>pssh is Copyright [2011] [Greg Nokes]</strong></p>

<p>Licensed under the Apache License, Version 2.0 (the &#8220;License&#8221;);
  you may not use this program except in compliance with the License.
  You may obtain a copy of the License at</p>

<pre><code>  http://www.apache.org/licenses/LICENSE-2.0
</code></pre>

<p>Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an &#8220;AS IS&#8221; BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.</p>

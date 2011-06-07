 PSSH
---

Proxy Secure SHell - a SSH automation tool suitable for use as bastion ssh server, or general hand holder. At this time, only works on AWS. Since it's built on the killer @fog gem, it can be easily expanded.

There is a bit of setup needed, and a few ways of approaching it.

The most scaleable is a central key repository. We tend to create a /srv/keys directory, and grant folks access to which ever keys they need based on groups (ie, perhaps the sysadmin group needs access to servers 1 and 2, and the devs need access to servers a and b. chown the key for servers 1 and 2 root:sysadmin and the key for a and b root:devs - chmod 640 the entire lot. If the sysadmins also need access to a and b, just put them into the dev group as well.)

I default to a group called "staff" as the general "can go everywhere" type of person. If you want to use a diffrent group - just make sure that you change that in the settings.

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

On the plate for pssh is an scp command with multifile support (ie pssh send file1 file2 file3 to servername1:/path servername2:/path) as well as a scripting interface (ie pssh script file.sh on server1 server2)




pssh is Copyright [2011] [Greg Nokes]

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this program except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

vagrant-puppet-jira
===================

Vagrant example on installing jira using puppet

Example
-------
```sh
$ git clone https://github.com/mkrakowitzer/vagrant-puppet-jira.git
$ cd vagrant-puppet-jira
$ sudo gem install librarian-puppet --verbose
$ librarian-puppet install
$ wget -O files/atlassian-jira-6.3.4a.tar.gz \
  http://www.atlassian.com/software/stash/downloads/binary/atlassian-jira-6.3.4a.tar.gz
```
Download jdk-7u65-linux-x64.tar.gz from here and copy into files directory:

http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html
 
```sh
vagrant up jira1 (CentOS 6)
vagrant up jira2 (CentOS 5)
vagrant up jira3 (Ubuntu 12.04)
```

License
-------
The MIT License (MIT)

Author
------------
* Merritt Krakowitzer merritt@krakowitzer.com

# start with a subscribed RHEL6 box
yum install -y yum-utils yum-rhn-plugin -y

rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum-config-manager --enable rhel-6-server-optional-rpms
yum clean all

# install dependent packages
yum install -y augeas puppet git policycoreutils-python

export PUPPETMASTER='$PUPPETMASTER'

# Set PuppetServer
augtool -s set /files/etc/puppet/puppet.conf/agent/server $PUPPETMASTER

# Puppet Plugins
augtool -s set /files/etc/puppet/puppet.conf/main/pluginsync true

#!/usr/bin/ruby
# Copyright (c) 2011 Akshat Pradhan
# MIT License
# This is a device diagnostic script that gathers typical
# information about the host. Instead of manually executing
# commands, it'll be quicker to get everything into a
# subdirectory and leisurely peruse the output.
# Facter does something like this, but eh.

require 'socket'
require 'fileutils'
require 'find'


@fqpn = "./"

def get_common
  puts "Gathering basic host info...\r"

  #hostname
  puts "Got your hostname\n"
  hostname = Socket.gethostname
  hostname_txt = File.new(@fqpn + "hostname.txt", "w")
  hostname_txt.puts hostname


  #/etc/issue
  puts "Trying to get /etc/issue, but might not work\n"

  if (FileTest.exists? "/etc/issue")
    FileUtils.cp '/etc/issue', 'issue.txt'
    puts "...well I guess I got it\n"
  else
    puts "...No issue file. You must be running a Mac.\n"
  end


  #Get /dev/ dir list just in case
  puts "Getting list of dirs in /dev. Could be useful.\n"
  lsdev_txt = File.new(@fqpn + "lsdev.txt", "w")
  lsdev_txt.puts Dir['/dev*/*']


  #OS/Kernel version
  puts "getting OS/Kernel info\n"
  uname_txt = File.new(@fqpn + "uname.txt", "w")
  uname_txt << `uname -a`


  #Disk Space
  puts "getting disk space\n"
  df_txt = File.new(@fqpn + "df.txt", "w")
  df_txt << `df -k`


  #Who's on the box
  puts "Finding out who's on the box? Will you please stop letting your ssh sessions hang for days?\n"
  who_txt = File.new(@fqpn + "who.txt", "w")
  who_txt << `who`


  #ports
  puts "getting netstat info"
  netstat_txt = File.new(@fqpn + "netstat.txt", "w")
  netstat_txt << `netstat -an`


  #routes
  puts "getting routes"
  routes_txt = File.new(@fqpn + "routes.txt", "w")
  routes_txt << `netstat -rn`


  #ifconfig
  puts "getting ifconfig"
  ifconfig_txt = File.new(@fqpn + "ifconfig.txt", "w")
  ifconfig_txt << `/sbin/ifconfig -a`

  #ps
  puts "getting ps"
  ps_txt = File.new(@fqpn + "ps.txt", "w")
  ps_txt << `ps aux`

  #To do
  # gather /var/log/messages
  # get /proc/cpuinfo
  # get /proc/meminfo
  # get /etc/grub.conf
  # get /etc/modules.conf
  # get lsmod
  # get iptables
  # get lspci
  # get dmesg

end #end get_common


get_common
puts "Thank you for your /etc/shadow file"



Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:56479 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716Ab3LETUI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 5 Dec 2013 14:20:08 -0500
Received: from 3capp-gmx-bs30.server.lan ([172.19.170.82]) by
 mrigmx.server.lan (mrigmx001) with ESMTP (Nemesis) id
 0Lflzw-1VDh5J0zz0-00pNxe for <util-linux@vger.kernel.org>; Thu, 05 Dec 2013
 20:20:07 +0100
MIME-Version: 1.0
Message-ID: <trinity-43b508b8-bb14-4ad1-81b0-a22e3bd084b4-1386271207144@3capp-gmx-bs30>
From: "Sten Heinze" <shze@gmx.de>
To: util-linux@vger.kernel.org
Subject: Automatic SSD trim script
Content-Type: multipart/mixed;
 boundary=rehcsedm-bca1b239-dac3-4e9a-a953-5082c1f99a3f
Date: Thu, 5 Dec 2013 20:20:07 +0100 (CET)
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--rehcsedm-bca1b239-dac3-4e9a-a953-5082c1f99a3f
Content-Type: text/plain; charset=UTF-8

Having experienced the drop in speed when using a SSD with online discard, I wrote a small perl script to run fstrim using batched discard on partitions located on a SSD through cron. Do you think util-linux would be a good place for such a script, given that it is a helper to fstrim? What would be the best way to include one in util-linux?

Thanks,
Sten
--rehcsedm-bca1b239-dac3-4e9a-a953-5082c1f99a3f
Content-Type: text/plain
Content-Disposition: attachment; filename=autotrim.pl

#!/usr/bin/perl

# This script tries to detect all mounted file systems, which of them are on SSD drives, and run fstrim on them.
# For details see http://wiki.ubuntuusers.de/SSD/TRIM or https://wiki.debian.org/SSDOptimization
# Use cron to run regularly, logger to redirect the output to syslog (essentially the output of fstrim).
# Written by Sten Heinze, 2013.

use strict;
use warnings;
use Cwd qw(realpath);

my $hdparm = '/sbin/hdparm';
my $grep = '/bin/grep';
my $block_dev_path = '/sys/block/';
my $rotational_file = '/queue/rotational';
my $mount = '/bin/mount';
my $discard_option = 'discard';
my $fstrim = '/sbin/fstrim -v'; # verbose needed?

# remove leading and trailing whitespace
sub trim {
  my $str = shift;
  $str =~ s/^\s+|\s+$//g;
  return $str;
}

# read file content
sub read_file {
  my $filename = shift;
  open( my $file_handle, "<", $filename ) || die "$filename: $!";
  my $content = trim( join( '', <$file_handle> ) );
  close( $file_handle );
  return $content;
}

# print and execute the given command
sub e {
  my $cmd = shift;
  print( "$cmd\n" );
  system( "$cmd" );
}

# list all mounted drives; blkid doesn't provide mount points; fstab does ans is another possible source.
# maybe only include fixed/internal drives? /sys/block/sdX/removable doesn't help for deciding if a dev is fixed.
sub get_devs_from_mount {
  my %devs = (); # empty hash

  my $output = `$mount`; 
  my @lines = split( '\n', $output); # split the output into lines
  foreach my $line ( @lines ) {
    if( $line =~ m$(\S+) on (/\S*) type \S+ (.*)$) { # eg. /dev/sda8 on /home type ext4 (rw,relatime,data=ordered)
      my $path = $1;
      my $mount_point = $2;
      my $mount_options = $3;
      next if( index( $mount_options, $discard_option ) != -1 ); # not -1 means found discard, i.e. skip this line
      next if( ! -e $path ); # skip lines that are virtual fs
      $path = realpath( $path ); # get absolute path for those mount points that are uuid symlinks
      $devs{ $path } = $mount_point; # add to hash
    }
  }
  return %devs;
}

# check if device is ssd using hdparm
sub is_ssd_hdparm {
  my $dev = shift;
  $dev = substr( $dev, 5, 3 ); # short to 3 chars: /dev/xxxN to xxx

  return 0 if( ! -X $hdparm || ! -X $grep ); # return no ssd if no hdparm or no grep command available

  `$hdparm -I /dev/$dev 2>&1 | $grep 'TRIM supported' 2>/dev/null`; # perl calls bash, use bash redirect
  if( $? == -1 ) {
    #print "failed to execute: $!\n";
  }
  elsif( $? & 127 ) {
    #printf "child died with signal %d, %s coredump\n", ($? & 127),  ($? & 128) ? 'with' : 'without';
  }
  else {
    my $exit_code = $? >> 8;
    #printf "child exited with value %d\n", $exit_code;
    return 1 if( $exit_code == 0 ); # only if grep found something, TRIM is supported
  }
  return 0;
}

# check if device is ssd using /sys/block/sdX/queue/rotational: 0=SSD, 1=likely HDD, but could be USB memory etc.
# if any error occurs, assume dev is not rotational and return 0.
sub is_ssd_sysfs {
  my $dev = shift;
  $dev = substr( $dev, 5, 3 ); # short to 3 chars: /dev/xxxN to xxx
  my $dev_substr = substr( $dev, 0, 2 );

  return 0 if( $dev_substr ne "sd" ); # if device name is not sdX, assume it is not a ssd
  return 0 if( ! -R $block_dev_path.$dev.$rotational_file ); # return false if file is not readable
  return 0 if( read_file( $block_dev_path.$dev.$rotational_file ) eq "1" ); # if rotational, it's likely not a SSD
  return 1;
}

# check if $block_dev_dir/dev/queue/rotational is 0 -> not reliable, use only as fallback
sub filter_ssd {
  my %devs = @_;
  while( my ( $dev, $mount_point ) = each( %devs ) ) { # loop over hash and remove all non-ssd devs
    delete $devs{ $dev } if( ! is_ssd_hdparm( $dev ) && ! is_ssd_sysfs( $dev ) ); # remove dev if no ssd
  }
  return %devs;
}

# trim the mount points
sub trim_mount_points {
  my %devs = @_;
  while( my ( $dev, $mount_point ) = each( %devs ) ) { # loop over hash and call trim on mount points
    e( "$fstrim $mount_point" );
    #return; # for testing: use only the first
  }
}

# main
my %devs = get_devs_from_mount();
%devs = filter_ssd( %devs );
trim_mount_points( %devs );

--rehcsedm-bca1b239-dac3-4e9a-a953-5082c1f99a3f--

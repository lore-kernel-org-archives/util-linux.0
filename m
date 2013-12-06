Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:65482 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754062Ab3LFKtu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 6 Dec 2013 05:49:50 -0500
Date: Fri, 6 Dec 2013 11:49:44 +0100
From: Karel Zak <kzak@redhat.com>
To: Sten Heinze <shze@gmx.de>
Cc: util-linux@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>
Subject: Re: Automatic SSD trim script
Message-ID: <20131206104944.GE16891@x2.net.home>
References: <trinity-43b508b8-bb14-4ad1-81b0-a22e3bd084b4-1386271207144@3capp-gmx-bs30>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <trinity-43b508b8-bb14-4ad1-81b0-a22e3bd084b4-1386271207144@3capp-gmx-bs30>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi Sten,

On Thu, Dec 05, 2013 at 08:20:07PM +0100, Sten Heinze wrote:
> Having experienced the drop in speed when using a SSD with online
> discard, I wrote a small perl script to run fstrim using batched
> discard on partitions located on a SSD through cron. Do you think
> util-linux would be a good place for such a script, given that it is
> a helper to fstrim? What would be the best way to include one in
> util-linux?

I have doubts we want to add a perl script to the package as a regular
util, util-linux is very basic package and dependence on Perl is
unexpected here. Maybe it would be possible to write a simple shell
script for this task and add it to the Documentation/example.files/
directory.


IMHO the best solution would be to improve fstrim to trim all
filesystems where it makes sense.

All we need is to link fstrim with libmount and lib/sysfs.c, add a new
option --all and check non-zero /sys/block/<name>/queue/discard_granularity
(or so).

I guess that implement something like this will be ~30 lines in C :-)  

[CC: to Lukas who is fstrim author]

    Karel


Anyway, a few comments to your script:

> # list all mounted drives; blkid doesn't provide mount points; fstab does ans is another possible source.

 don't use mount(8) to list info about mountpoints, findmnt(8) is better, for example:

    findmnt -clo TARGET -O nodiscard

> # maybe only include fixed/internal drives? /sys/block/sdX/removable doesn't help for deciding if a dev is fixed.
> sub get_devs_from_mount {
>   my %devs = (); # empty hash
> 
>   my $output = `$mount`; 
>   my @lines = split( '\n', $output); # split the output into lines
>   foreach my $line ( @lines ) {
>     if( $line =~ m$(\S+) on (/\S*) type \S+ (.*)$) { # eg. /dev/sda8 on /home type ext4 (rw,relatime,data=ordered)
>       my $path = $1;
>       my $mount_point = $2;
>       my $mount_options = $3;
>       next if( index( $mount_options, $discard_option ) != -1 ); # not -1 means found discard, i.e. skip this line
>       next if( ! -e $path ); # skip lines that are virtual fs
>       $path = realpath( $path ); # get absolute path for those mount points that are uuid symlinks
>       $devs{ $path } = $mount_point; # add to hash
>     }
>   }
>   return %devs;
> }
> 
> # check if device is ssd using hdparm
> sub is_ssd_hdparm {
>   my $dev = shift;
>   $dev = substr( $dev, 5, 3 ); # short to 3 chars: /dev/xxxN to xxx
> 
>   return 0 if( ! -X $hdparm || ! -X $grep ); # return no ssd if no hdparm or no grep command available
> 
>   `$hdparm -I /dev/$dev 2>&1 | $grep 'TRIM supported' 2>/dev/null`; # perl calls bash, use bash redirect


 it would be possible to use lsblk to list devices with non-zero DISC-GRAN column,
 the util also provides mounpoints.

> # check if device is ssd using /sys/block/sdX/queue/rotational: 0=SSD, 1=likely HDD, but could be USB memory etc.

 again, use lsblk

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:52371 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751599AbeCVJrU (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 22 Mar 2018 05:47:20 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [ANNOUNCE] util-linux v2.32
Date: Thu, 22 Mar 2018 10:47:13 +0100
Cc: util-linux@vger.kernel.org
References: <20180321145323.l6ulgds4zfycfttp@ws.net.home>
In-Reply-To: <20180321145323.l6ulgds4zfycfttp@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201803221047.14002.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 21 March 2018, Karel Zak wrote:
> The util-linux release v2.32 is available at

Thanks!

> Util-linux 2.32 Release Notes
> ==============
> [...]

FYI regarding "Release Notes". I guess it's always a pain to write
that and to remember all relevant new features and options. ;)
Just to remind you, we have have a nice tool on board which may be
helpful.

$ CU_DUMP=1 make checkusage
$ mv /tmp/checkusage--help /tmp/checkusage--help-2.32

## ... and diff all changed --help output too see what may be
## worth to mention, for example:
$ diff -uw  /tmp/checkusage--help-2.31.2 /tmp/checkusage--help-2.32
--- /tmp/checkusage--2.31.2     2018-03-22 10:17:10.059537442 +0100
+++ /tmp/checkusage--2.32     2018-03-22 10:15:29.025304770 +0100
@@ -178,7 +178,9 @@
  -S, --span            span the date when displaying multiple months
  -s, --sunday          Sunday as first day of week
  -m, --monday          Monday as first day of week
- -j, --julian          output Julian dates
+ -j, --julian          use day-of-year for all calendars
+     --reform <val>    Gregorian reform date (1752|gregorian|iso|julian)
+     --iso             alias for --reform=iso
  -y, --year            show the whole year
  -Y, --twelve          show the next twelve months
  -w, --week[=<num>]    show US or ISO-8601 week numbers
@@ -255,11 +257,19 @@
  -e, --enable   enable memory
  -d, --disable  disable memory
  -b, --blocks   use memory blocks
+ -z, --zone <name>  select memory zone (see below)
  -v, --verbose  verbose output
-
  -h, --help     display this help
  -V, --version  display version

+Supported zones:
+ DMA
+ DMA32
+ Normal
+ Highmem
+ Movable
+ Device
+
 For more details see chmem(8).
 ##########################################################
 #### chrt
@@ -379,6 +389,7 @@
  -O, --table-order <columns>      specify order of output columns
  -N, --table-columns <names>      comma separated columns names
  -E, --table-noextreme <columns>  don't count long text from the columns to column width
+ -d, --table-noheadings           don't print header
  -e, --table-header-repeat        repeat header for each page
  -H, --table-hide <columns>       don't print the columns
  -R, --table-right <columns>      right align text in these columns
@@ -447,6 +458,7 @@
  -l, --level <list>          restrict output to defined levels
  -n, --console-level <level> set level of messages printed to console
  -P, --nopager               do not pipe output into a pager
+ -p, --force-prefix          force timestamp output on each line of multi-line messages
  -r, --raw                   print the raw message buffer
  -S, --syslog                force to use syslog(2) rather than /dev/kmsg
  -s, --buffer-size <size>    buffer size to query the kernel ring buffer
@@ -933,8 +945,8 @@
      --update-drift   update the RTC drift factor
      --noadjfile      do not use /etc/adjtime
      --adjfile <file> use an alternate file to /etc/adjtime
-     --test           dry run; implies --debug
- -D, --debug          display more details
+     --test           dry run; implies --verbose
+ -v, --verbose        display more details

  -h, --help           display this help
  -V, --version        display version
@@ -1589,6 +1601,7 @@
  -n, --noheadings     don't print headings
  -o, --output <list>  output columns
  -r, --raw            use raw output format
+ -S, --split <list>   split ranges by specified columns
  -s, --sysroot <dir>  use the specified directory as system root
      --summary[=when] print summary information (never,always or only)

@@ -1602,6 +1615,7 @@
   REMOVABLE  memory is removable
       BLOCK  memory block number or blocks range
        NODE  numa node of memory
+      ZONES  valid zones for the memory range

 For more details see lsmem(1).
 ##########################################################
@@ -1620,6 +1634,7 @@
  -p, --task <pid>       print process namespaces
  -r, --raw              use the raw output format
  -u, --notruncate       don't truncate text in columns
+ -W, --nowrap           don't use multi-line representation
  -t, --type <name>      namespace type (mnt, net, ipc, user, pid, uts, cgroup)

  -h, --help             display this help
@@ -1635,6 +1650,8 @@
      COMMAND  command line of the PID
          UID  UID of the PID
         USER  username of the PID
+     NETNSID  namespace ID as used by network subsystem
+        NSFS  nsfs mountpoint (usually used network subsystem)

 For more details see lsns(8).
 ##########################################################
@@ -2363,6 +2380,7 @@

 Options:
  -c, --ctty     set the controlling terminal to the current one
+ -f, --fork     always fork
  -w, --wait     wait program to exit, and use the same return
  -h, --help     display this help
  -V, --version  display version
@@ -2427,7 +2445,7 @@
 Display or manipulate a disk partition table.

 Commands:
- -A, --activate <dev> [<part> ...] list or set bootable MBR partitions
+ -A, --activate <dev> [<part> ...] list or set bootable (P)MBR partitions
  -d, --dump <dev>                  dump partition table (usable for later input)
  -J, --json <dev>                  dump partition table in JSON format
  -g, --show-geometry [<dev> ...]   list geometry of all or specified devices
@@ -2744,6 +2762,7 @@
  -U, --user[=<file>]       unshare user namespace
  -C, --cgroup[=<file>]     unshare cgroup namespace
  -f, --fork                fork before launching <program>
+     --kill-child[=<signame>]  when dying, kill the forked child (implies --fork); defaults to SIGKILL
      --mount-proc[=<dir>]  mount proc filesystem first (implies --mount)
  -r, --map-root-user       map current user to root (implies --user)
      --propagation slave|shared|private|unchanged
@@ -2981,7 +3000,7 @@
 Set up and control zram devices.

 Options:
- -a, --algorithm lzo|lz4   compression algorithm to use
+ -a, --algorithm lzo|lz4|lz4hc|deflate|842   compression algorithm to use
  -b, --bytes               print sizes in bytes rather than in human readable format
  -f, --find                find a free device
  -n, --noheadings          don't print headings

Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: sfdisk, latest fixes break ppc64
Date: Wed, 22 Apr 2015 12:42:18 +0200
Cc: util-linux@vger.kernel.org
References: <201504211234.27649.sweet_f_a@gmx.de> <20150422101333.GE27969@ws.net.home>
In-Reply-To: <20150422101333.GE27969@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201504221242.18521.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 22 April 2015, Karel Zak wrote:
> On Tue, Apr 21, 2015 at 12:34:26PM +0200, Ruediger Meier wrote:
> > the latest sfdisk fixes 2928068a..a53e37f9 seem to break ppc64
>
> The latest changes in sfdisk only shows stupid LE/BE bugs we have in
> GPT code. The problem should be fixed now.

Thanks!

> It seems I have to compile and tests on Big Endian (ppc and s390)
> more often, because we have no enough users who test it.

Hehe I've set up the next build farm already (no auto push yet):
https://build.opensuse.org/package/show/home:rudi_m:ul-all/ul-plain

These are very different (sometimes strange) hosts. Xen, kvm, real
machines ... with or without sudo, module support, etc. The build
hosts may even change between rebuilds. Sometimes they are under heavy
load. Most issues are fixed now so I guess 2.26.2 will be a good one :)

There are still some random failures sometimes like this:

             : resize                      ... FAILED (sfdisk/gpt-resize)
....
[  604s] --- /home/abuild/rpmbuild/BUILD/util-linux-2.26.git233.01aa/tests/expected/sfdisk/gpt-resize	2015-04-22 06:40:45.002363998 +0000
[  604s] +++ /home/abuild/rpmbuild/BUILD/util-linux-2.26.git233.01aa/tests/output/sfdisk/gpt-resize	2015-04-22 10:22:27.514581956 +0000
[  604s] @@ -1,3 +1,4 @@
[  604s] +Re-reading the partition table failed.: Device or resource busy
[  604s]  Checking that no-one is using this disk right now ... OK
[  604s]  
[  604s]  Disk <removed>: 50 MiB, 52428800 bytes, 102400 sectors
[  604s] @@ -20,4 +21,5 @@
[  604s]  
[  604s]  The partition table has been altered.
[  604s]  Calling ioctl() to re-read partition table.
[  604s] +The kernel still uses the old table. The new table will be used at the next reboot or after you run partprobe(8) or kpartx(8).
[  604s]  Syncing disks.


cu,
Rudi

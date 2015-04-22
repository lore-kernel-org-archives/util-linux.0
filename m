Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57952 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757059AbbDVN2a (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 22 Apr 2015 09:28:30 -0400
Date: Wed, 22 Apr 2015 15:28:27 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: sfdisk, latest fixes break ppc64
Message-ID: <20150422132827.GF27969@ws.net.home>
References: <201504211234.27649.sweet_f_a@gmx.de>
 <20150422101333.GE27969@ws.net.home>
 <201504221242.18521.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201504221242.18521.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 22, 2015 at 12:42:18PM +0200, Ruediger Meier wrote:
> On Wednesday 22 April 2015, Karel Zak wrote:
> > On Tue, Apr 21, 2015 at 12:34:26PM +0200, Ruediger Meier wrote:
> > > the latest sfdisk fixes 2928068a..a53e37f9 seem to break ppc64
> >
> > The latest changes in sfdisk only shows stupid LE/BE bugs we have in
> > GPT code. The problem should be fixed now.
> 
> Most issues are fixed now so I guess 2.26.2 will be a good one :)

 I hope so:-) Next time it would be nice to detect and fix such bugs
 in major release or in .1  ... we need a way how to motivate users to
 use -rc releases (t-shits, beers? ;-)

> There are still some random failures sometimes like this:
> 
>              : resize                      ... FAILED (sfdisk/gpt-resize)
> ....
> [  604s] --- /home/abuild/rpmbuild/BUILD/util-linux-2.26.git233.01aa/tests/expected/sfdisk/gpt-resize	2015-04-22 06:40:45.002363998 +0000
> [  604s] +++ /home/abuild/rpmbuild/BUILD/util-linux-2.26.git233.01aa/tests/output/sfdisk/gpt-resize	2015-04-22 10:22:27.514581956 +0000
> [  604s] @@ -1,3 +1,4 @@
> [  604s] +Re-reading the partition table failed.: Device or resource busy
> [  604s]  Checking that no-one is using this disk right now ... OK
> [  604s]  
> [  604s]  Disk <removed>: 50 MiB, 52428800 bytes, 102400 sectors
> [  604s] @@ -20,4 +21,5 @@
> [  604s]  
> [  604s]  The partition table has been altered.
> [  604s]  Calling ioctl() to re-read partition table.
> [  604s] +The kernel still uses the old table. The new table will be used at the next reboot or after you run partprobe(8) or kpartx(8).
> [  604s]  Syncing disks.

Yes, I know about it, but I'm able to reproduce this only on ppc, add
"sleep 10" to the test fixes the problem, so I guess that "udevadm
settle" is not so reliable on ppc.

Note that I'm working on new resize code, so this test will go away
and it will be replaced with separated "resize" test script.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

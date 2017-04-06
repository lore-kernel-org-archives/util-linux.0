Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753441AbdDFLcU (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 6 Apr 2017 07:32:20 -0400
Date: Thu, 6 Apr 2017 13:32:15 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libfdisk: fix gpt for 32bit systems
Message-ID: <20170406113215.byflzhjmzsaezibn@ws.net.home>
References: <1491386189-8163-1-git-send-email-sweet_f_a@gmx.de>
 <201704051958.00857.sweet_f_a@gmx.de>
 <20170406102838.l6hz22ky3rtgdrew@ws.net.home>
 <201704061243.39827.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201704061243.39827.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 06, 2017 at 12:43:39PM +0200, Ruediger Meier wrote:
> On Thursday 06 April 2017, Karel Zak wrote:
> > On Wed, Apr 05, 2017 at 07:58:00PM +0200, Ruediger Meier wrote:
> > > > +	ssz = read(cxt->dev_fd, ret, sz);
> > >
> > > The read(2) Linux manpage says: "If count is greater than SSIZE_MAX
> > > (signed!), the result is unspecified."
> > >
> > > So maybe we should limit gpt_sizeof_ents() regarding SSIZE_MAX
> > > rather than SIZE_MAX. I guess that even smwaller sizes would not be
> > > possible to load into memory.
> >
> > OK, I have added SSIZE_MAX check before the read.
> >
> > > I'm also not sure that such big-reads (without using read() in a
> > > loop) are portable at all.
> >
> > The area on disk is pretty small, and we read the entries array after
> > header checksum verification. So, the read(2) should no be affected
> > by corrupted disk and if someone has 44+ millions partitions then a
> > random read(2) issue is probably the smallest issue in his live...
> > (we can use read_all() from include/all-io.h, but I think it's
> > overkill).
> 
> Yes, no real problem I guess. I'm just curious what would happen if we 
> have at least a few thousand partitions. Or whether we shouldn't make 
> the limit much smaller somehow to avoid OOM killer in case somebody 
> reads a corrupted gpt table.

we have 'l' command in expert menu ('git pull' I found and fix a bug there)
to reallocate the partition array, for example to create entries array
for 10000 partitions, and use first and last partition:

 modprobe scsi_debug dev_size_mb=1000
 echo -e "g\nx\nl\n10000\nr\nn\n1\n\n+1MiB\nn\n10000\n\n+1MiB\np\nw\q" | ./fdisk /dev/sdc
 ...
 Device        Start   End Sectors Size Type
 /dev/sdc1      4096  6143    2048   1M Linux filesystem
 /dev/sdc10000  6144  8191    2048   1M Linux filesystem

but:

 * kernel really don't like it (kmalloc problem in kernel is_gpt_valid())
 * GNU Parted's last message is "Aborted (core dumped)"

if you allocate only space for 1000 partitions than all seems better,
except kernel create the first partition only (kernel limit is 254 or
so).

> BTW we could also generally add more tests for broken devices using 
> scsi_debug or libfiu. Maybe I will try this when I feel boring next 
> time. But I'm already stuck with these fuzzing tests.

It would be useful.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

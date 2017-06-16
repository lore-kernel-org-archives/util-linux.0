Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751979AbdFPJj2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 16 Jun 2017 05:39:28 -0400
Date: Fri, 16 Jun 2017 11:39:23 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: BUG: wipefs dry run
Message-ID: <20170616093923.fbikmnobs55hnhlz@ws.net.home>
References: <201705101154.50099.sweet_f_a@gmx.de>
 <201705101303.10856.sweet_f_a@gmx.de>
 <20170526112120.kinsu7oi7fldx2o4@ws.net.home>
 <201706151647.06899.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201706151647.06899.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 15, 2017 at 04:47:06PM +0200, Ruediger Meier wrote:
> On Friday 26 May 2017, Karel Zak wrote:
> > On Wed, May 10, 2017 at 01:03:10PM +0200, Ruediger Meier wrote:
> > > > It would be probably possible to extend libblkid to work in some
> > > > "ignore previous result" mode to to gather all permutation for
> > > > the FS/RAID/etc, but it won't be trivial task...
> > >
> > > This would be nice.
> >
> > Implemented (and it was relatively easy to implement :-)
> >
> > Try "blkid-hide" branch from github, will be in v2.31.
> 
> > # wipefs -a --no-act /dev/sdc
> 
> 
> Thanks, this looks good. There are still a few issues-

Thanks for testing!

> 
> $ truncate -s 100M /tmp/test.img
> $ echo "label: gpt" | ./sfdisk /tmp/test.img
> 
> ### this hangs indefinitely
> $ wipefs -t gpt /tmp/test.img

Fixed.

> ### the default list shows too many newlines 
> $ ./wipefs  /tmp/test.img
> offset               type
> ----------------------------------------------------------------
> 0x1fe                PMBR   [partition table]
> 
> 0x63ffe00            gpt   [partition table]
> 
> 0x200                gpt   [partition table]

All the output is ugly. I'll probably link it with libsmartcols,
because we support "wipefs /dev/sd*" to list more devices and then the
output is absolutely useless.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

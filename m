Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:65442 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752605AbdFOOrV (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 15 Jun 2017 10:47:21 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: BUG: wipefs dry run
Date: Thu, 15 Jun 2017 16:47:06 +0200
Cc: util-linux@vger.kernel.org
References: <201705101154.50099.sweet_f_a@gmx.de> <201705101303.10856.sweet_f_a@gmx.de> <20170526112120.kinsu7oi7fldx2o4@ws.net.home>
In-Reply-To: <20170526112120.kinsu7oi7fldx2o4@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201706151647.06899.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Friday 26 May 2017, Karel Zak wrote:
> On Wed, May 10, 2017 at 01:03:10PM +0200, Ruediger Meier wrote:
> > > It would be probably possible to extend libblkid to work in some
> > > "ignore previous result" mode to to gather all permutation for
> > > the FS/RAID/etc, but it won't be trivial task...
> >
> > This would be nice.
>
> Implemented (and it was relatively easy to implement :-)
>
> Try "blkid-hide" branch from github, will be in v2.31.

> # wipefs -a --no-act /dev/sdc


Thanks, this looks good. There are still a few issues-


$ truncate -s 100M /tmp/test.img
$ echo "label: gpt" | ./sfdisk /tmp/test.img

### this hangs indefinitely
$ wipefs -t gpt /tmp/test.img

### the default list shows too many newlines 
$ ./wipefs  /tmp/test.img
offset               type
----------------------------------------------------------------
0x1fe                PMBR   [partition table]

0x63ffe00            gpt   [partition table]

0x200                gpt   [partition table]


cu,
Rudi

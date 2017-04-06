Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:60170 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932442AbdDFKns (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 6 Apr 2017 06:43:48 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] libfdisk: fix gpt for 32bit systems
Date: Thu, 6 Apr 2017 12:43:39 +0200
Cc: util-linux@vger.kernel.org
References: <1491386189-8163-1-git-send-email-sweet_f_a@gmx.de> <201704051958.00857.sweet_f_a@gmx.de> <20170406102838.l6hz22ky3rtgdrew@ws.net.home>
In-Reply-To: <20170406102838.l6hz22ky3rtgdrew@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201704061243.39827.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 06 April 2017, Karel Zak wrote:
> On Wed, Apr 05, 2017 at 07:58:00PM +0200, Ruediger Meier wrote:
> > > +	ssz = read(cxt->dev_fd, ret, sz);
> >
> > The read(2) Linux manpage says: "If count is greater than SSIZE_MAX
> > (signed!), the result is unspecified."
> >
> > So maybe we should limit gpt_sizeof_ents() regarding SSIZE_MAX
> > rather than SIZE_MAX. I guess that even smwaller sizes would not be
> > possible to load into memory.
>
> OK, I have added SSIZE_MAX check before the read.
>
> > I'm also not sure that such big-reads (without using read() in a
> > loop) are portable at all.
>
> The area on disk is pretty small, and we read the entries array after
> header checksum verification. So, the read(2) should no be affected
> by corrupted disk and if someone has 44+ millions partitions then a
> random read(2) issue is probably the smallest issue in his live...
> (we can use read_all() from include/all-io.h, but I think it's
> overkill).

Yes, no real problem I guess. I'm just curious what would happen if we 
have at least a few thousand partitions. Or whether we shouldn't make 
the limit much smaller somehow to avoid OOM killer in case somebody 
reads a corrupted gpt table.

BTW we could also generally add more tests for broken devices using 
scsi_debug or libfiu. Maybe I will try this when I feel boring next 
time. But I'm already stuck with these fuzzing tests.

cu,
Rudi


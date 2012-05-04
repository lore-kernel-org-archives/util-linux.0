Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:17726 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759337Ab2EDS7r (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 4 May 2012 14:59:47 -0400
Date: Fri, 4 May 2012 20:59:41 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Francesco Cosoleto <cosoleto@gmail.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] fdisk: fix segfault on bsd label
Message-ID: <20120504185941.GE11606@x2.net.home>
References: <1336131332.17719.1.camel@offworld>
 <"CAMFXF531o-SWQb3-Hcw02jwVBeYnoN8HLcbPfTPTuPxOHj8QEg"@mail.gmail.com>
 <1336151310.13569.0.camel@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336151310.13569.0.camel@offworld>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, May 04, 2012 at 07:08:30PM +0200, Davidlohr Bueso wrote:
> On Fri, 2012-05-04 at 15:53 +0200, Francesco Cosoleto wrote:
> > 2012/5/4 Davidlohr Bueso <dave@gnu.org>:
> > > From: Davidlohr Bueso <dave@gnu.org>
> > >
> > > Commit 8db8295d824cd0c8cba9385e4635d6e311d69d3f added a regression that causes the program to crash when
> > > touching the partition structure (pte) for BSD/OSF labels. Since DOS has its own initialization function,
> > > allow BSD labels to use it as well.
> > >
> > > Steps to reproduce:
> > >
> > > $> fdisk bsd.img (obtained from blkid regression test files)
> > > Command (m for help): p
> > > ...
> > > I/O size (minimum/optimal): 512 bytes / 512 bytes
> > > Disk identifier: 0x00000000
> > >
> > > Segmentation fault
> > 
> > Thanks Davidlohr for pointing out that regression. Does it occurs with
> > the command to print the partition table when the drive has a BSD
> > label and hasn't a valid DOS label, and it has no partition? Fdisk
> > switches from BSD label to DOS label without initializing DOS
> > structures, right?
> 
> From my analysis, yes.

 Just note that some labels are nested -- for example BSD, minix
 unixware, ... are subtypes (nested partition tables) within DOS.

 This parent->child relationship will be also necessary to support
 in new fdisk API.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

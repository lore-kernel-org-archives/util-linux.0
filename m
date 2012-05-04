Return-Path: util-linux-owner@vger.kernel.org
Received: from damascus.uab.es ([158.109.168.135]:17704 "EHLO damascus.uab.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859Ab2EDRIY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 4 May 2012 13:08:24 -0400
Received: from damascus.uab.es ([127.0.0.1])
 by damascus.uab.es (Sun Java System Messaging Server 6.1 HotFix 0.10 (built
 Jan  6 2005)) with ESMTP id <0M3I00G19CXZRF30@damascus.uab.es> for
 util-linux@vger.kernel.org; Fri, 04 May 2012 19:08:23 +0200 (CEST)
Received: from aomail.uab.es ([158.109.65.1])
 by damascus.uab.es (Sun Java	System Messaging Server 6.1 HotFix 0.10 (builtJan
 6 2005)) with ESMTP id	<0M3I005POCXZMTY2@damascus.uab.es>
 forutil-linux@vger.kernel.org; Fri, 04 May 2012 19:08:23 +0200 (CEST)
Date: Fri, 04 May 2012 19:08:30 +0200
From: Davidlohr Bueso <dave@gnu.org>
Subject: Re: [PATCH] fdisk: fix segfault on bsd label
In-reply-to: <CAMFXF531o-SWQb3-Hcw02jwVBeYnoN8HLcbPfTPTuPxOHj8QEg@mail.gmail.com>
To: Francesco Cosoleto <cosoleto@gmail.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
Message-id: <1336151310.13569.0.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
References: <1336131332.17719.1.camel@offworld>
 <"CAMFXF531o-SWQb3-Hcw02jwVBeY noN8HLcbPfTPTuPxOHj8QEg"@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, 2012-05-04 at 15:53 +0200, Francesco Cosoleto wrote:
> 2012/5/4 Davidlohr Bueso <dave@gnu.org>:
> > From: Davidlohr Bueso <dave@gnu.org>
> >
> > Commit 8db8295d824cd0c8cba9385e4635d6e311d69d3f added a regression that causes the program to crash when
> > touching the partition structure (pte) for BSD/OSF labels. Since DOS has its own initialization function,
> > allow BSD labels to use it as well.
> >
> > Steps to reproduce:
> >
> > $> fdisk bsd.img (obtained from blkid regression test files)
> > Command (m for help): p
> > ...
> > I/O size (minimum/optimal): 512 bytes / 512 bytes
> > Disk identifier: 0x00000000
> >
> > Segmentation fault
> 
> Thanks Davidlohr for pointing out that regression. Does it occurs with
> the command to print the partition table when the drive has a BSD
> label and hasn't a valid DOS label, and it has no partition? Fdisk
> switches from BSD label to DOS label without initializing DOS
> structures, right?

>From my analysis, yes.

> 
> fdisk.c:
>     bsd_command_prompt();
>     /* If we return we may want to make an empty DOS label? */
>     disklabel = DOS_LABEL;
> 



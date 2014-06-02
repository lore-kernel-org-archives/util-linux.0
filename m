Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:61929 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752639AbaFBHtn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Jun 2014 03:49:43 -0400
Date: Mon, 2 Jun 2014 09:49:31 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>,
        Roberto Angelino <rangelino@novell.com>,
        Holger Hetterich <hhetter@suse.com>,
        Stanislav Brabec <sbrabec@suse.cz>
Subject: Re: [PATCH] sfdisk: suppress Linux-irrelevant warnings with -L
Message-ID: <20140602074931.GK9000@x2.net.home>
References: <1401121683-18503-1-git-send-email-petr.uzel@suse.cz>
 <201405311625.33102.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201405311625.33102.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, May 31, 2014 at 04:25:32PM +0200, Ruediger Meier wrote:
> On Monday 26 May 2014, Petr Uzel wrote:
> > Sfdisk prints out a warning about extended partition not
> > starting at a cylinder boundary. Since this is irrelevant
> > for linux, the -L option should suppress this warning.
> 
> I would really like to have -L enabled by default on linux. Project name
> is util-LINUX and if we even run it on linux, why being still bothered 
> per default?

sfdisk code sucks and it's necessary to rewrite it to use libfdisk
(sfdisk is the last remaining fdisk), I'd like to do this change in
v2.26.

> BTW we have some more warnings of this kind in libfdisk/src/dos.c
> where we don't have option -L:
> 
> /* Same physical / logical beginning? */
> if (cxt->geom.cylinders <= 1024
>     && (pbc != lbc || pbh != lbh || pbs != lbs)) {
>        fdisk_warnx(cxt, _("Partition %zu: different physical/logical "
>                "beginnings (non-Linux?): "
>                "phys=(%d, %d, %d), logical=(%d, %d, %d)"),
>                 partition + 1,
>                 pbc, pbh, pbs,
>                 lbc, lbh, lbs);
> }

this code is for DOS compatible mode which is disabled by default

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38559 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751824AbaETH2g (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 20 May 2014 03:28:36 -0400
Date: Tue, 20 May 2014 09:28:30 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: feature-freeze for v2.25
Message-ID: <20140520072830.GN26357@x2.net.home>
References: <20140519101605.GL26357@x2.net.home>
 <201405192151.40129.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201405192151.40129.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, May 19, 2014 at 09:51:39PM +0200, Ruediger Meier wrote:
> On Monday 19 May 2014, Karel Zak wrote:
> >  Hi,
> >
> >  note that I'd like to release v2.25 next month. I'm going to merge
> >  new features to completely new things (like libsmartcols or
> > lslogins) and to regression tests only. All another non-bugfix or
> > invasive refactoring patches will be postponed. (well, in progress
> > setterm stuff will be merged.)
> 
> I'd like to have two more minor features in v2.25:
> 
> 1. squashfs3 detection in superblocks.h
> 2. improved hypervisor detection in lscpu
> 
> Would it have a chance if I commit soon? Both patches are used and 
> tested already in SLE since v2.16 or v2.19 and in openSUSE devel since 
> v2.24.

 OK, send it.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

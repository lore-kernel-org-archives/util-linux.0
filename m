Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:23553 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161178Ab2KNMWL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 14 Nov 2012 07:22:11 -0500
Date: Wed, 14 Nov 2012 13:22:07 +0100
From: Karel Zak <kzak@redhat.com>
To: Alexey Gladkov <gladkov.alexey@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: vlock command
Message-ID: <20121114122207.GE1835@x2.net.home>
References: <20121114103509.GD1835@x2.net.home>
 <50A37AD8.6060601@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50A37AD8.6060601@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 14, 2012 at 03:04:56PM +0400, Alexey Gladkov wrote:
> 14.11.2012 14:35, Karel Zak wrote:
> > 
> >  vlock(1) - Virtual Console lock program
> > 
> > This nice and small program used by admins on machines with consoles
> > only. Unfortunately it has inactive upstream(s).
> > 
> > The original upstream for vlock-1.3 at
> > 
> >     ftp://tsx-11.mit.edu:/pub/linux/sources/usr.bin/
> > 
> > is inactive for years. There is also new upstream at
> > 
> >    http://freecode.com/projects/vlock
> >    http://repo.or.cz/w/vlock.git
> > 
> > but this also seems inactive and from my point of view vlock-2.x is
> > over-engineering rhapsody (glib, plug-ins, dependences resolver,
> > external scripts etc.)
> > 
> > What about to merge vlock-1.3 into utils-linux? It's 630 lines of code
> > (including unnecessary non-PAM code).
> > 
> > Comments & Objections?
> > 
> 
> We have another version of vlock, which is being supported by Dmitry
> V. Levin.
> 
> http://git.altlinux.org/people/ldv/packages/vlock.git

 it seems the same code as the original vlock-1.3

> Some time ago, I have merged this version in kbd project:
> 
> http://git.altlinux.org/people/legion/packages/kbd.git?p=kbd.git;a=tree;f=src/vlock;h=92419b98175d215a71f83bfb06b409daa97b13c4;hb=768b8c314e1d3c465d895b206da4aa4543914d1d
> 
> I have a collection of utilities for manipulation in console (openvt,
> chvt, deallocvt ...) I consider logical to have the utility for
> terminal blocking.
> 
> What do you think?

 Well, vlock is mostly about authentication, but I have no strong
 opinion about it -- we can keep it in kbd as well.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

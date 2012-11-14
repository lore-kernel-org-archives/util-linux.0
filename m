Return-Path: util-linux-owner@vger.kernel.org
Received: from monster.unsafe.ru ([195.18.34.9]:51904 "EHLO mail.unsafe.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752390Ab2KNLNK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 14 Nov 2012 06:13:10 -0500
Message-ID: <50A37AD8.6060601@gmail.com>
Date: Wed, 14 Nov 2012 15:04:56 +0400
From: Alexey Gladkov <gladkov.alexey@gmail.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: vlock command
References: <20121114103509.GD1835@x2.net.home>
In-Reply-To: <20121114103509.GD1835@x2.net.home>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

14.11.2012 14:35, Karel Zak wrote:
> 
>  vlock(1) - Virtual Console lock program
> 
> This nice and small program used by admins on machines with consoles
> only. Unfortunately it has inactive upstream(s).
> 
> The original upstream for vlock-1.3 at
> 
>     ftp://tsx-11.mit.edu:/pub/linux/sources/usr.bin/
> 
> is inactive for years. There is also new upstream at
> 
>    http://freecode.com/projects/vlock
>    http://repo.or.cz/w/vlock.git
> 
> but this also seems inactive and from my point of view vlock-2.x is
> over-engineering rhapsody (glib, plug-ins, dependences resolver,
> external scripts etc.)
> 
> What about to merge vlock-1.3 into utils-linux? It's 630 lines of code
> (including unnecessary non-PAM code).
> 
> Comments & Objections?
> 

We have another version of vlock, which is being supported by Dmitry
V. Levin.

http://git.altlinux.org/people/ldv/packages/vlock.git

Some time ago, I have merged this version in kbd project:

http://git.altlinux.org/people/legion/packages/kbd.git?p=kbd.git;a=tree;f=src/vlock;h=92419b98175d215a71f83bfb06b409daa97b13c4;hb=768b8c314e1d3c465d895b206da4aa4543914d1d

I have a collection of utilities for manipulation in console (openvt,
chvt, deallocvt ...) I consider logical to have the utility for
terminal blocking.

What do you think ?

-- 
Rgrds, legion


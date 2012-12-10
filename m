Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34482 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219Ab2LJJLT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 10 Dec 2012 04:11:19 -0500
Date: Mon, 10 Dec 2012 10:11:14 +0100
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: blkid: exit code as non-root user, and segfault
Message-ID: <20121210091114.GC21405@x2.net.home>
References: <50C4CFDD.1070405@bernhard-voelker.de>
 <20121210084250.GA21405@x2.net.home>
 <1203571747.166876.1355129914909.JavaMail.open-xchange@email.1und1.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1203571747.166876.1355129914909.JavaMail.open-xchange@email.1und1.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Dec 10, 2012 at 09:58:34AM +0100, Bernhard Voelker wrote:
> 
> On December 10, 2012 at 9:42 AM Karel Zak <kzak@redhat.com> wrote:
> > On Sun, Dec 09, 2012 at 06:52:29PM +0100, Bernhard Voelker wrote:
> > > blkid returns 0 without output when running as non-root user
> > > and when the cache /dev/.blkid.tab is not yet there:
> > >
> > >   ./blkid /dev/sdb3 ; echo $?
> > >   0
> >
> > ./blkid /dev/sdb3; echo $?2
> > 2
> 
> Typo? "$?2" should lead to "02".

 copy & past bug

> It really exits 0 here, when run as non-root user and when
> /dev/.blkid.tab doesn't exist yet.

Anyway, I have tested the problem as root. You're right it is
possible to reproduce as non-root. Sorry.

I'll fix it. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

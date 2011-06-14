Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:25611 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753676Ab1FNM0H (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 Jun 2011 08:26:07 -0400
Date: Tue, 14 Jun 2011 14:26:04 +0200
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: Josiah Worcester <josiahw@gmail.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH 6/6] hwclock: Don't use asm/io.h if sys/io.h can't be
	found
Message-ID: <20110614122604.GI14293@nb.net.home>
References: <1307573568-23643-1-git-send-email-josiahw@gmail.com> <1307573568-23643-7-git-send-email-josiahw@gmail.com> <201106082058.26670.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201106082058.26670.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jun 08, 2011 at 08:58:25PM -0400, Mike Frysinger wrote:
> On Wednesday, June 08, 2011 18:52:48 Josiah Worcester wrote:
> > -#include <asm/io.h>		/* for inb, outb */
> > +/* Disable cmos access; we can no longer use asm/io.h, since
> > + * the kernel does not export that header.
> > + */
> > +#undef __i386__
> > +void outb(int a, int b){}
> > +int inb(int c){ return 0; }
> 
> probably should be turned into a header check in configure

 I have added asm/io.h check to configure.ac to keep it backwardly
 compatible...

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

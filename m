Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60757 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162AbbLJMW6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 10 Dec 2015 07:22:58 -0500
Date: Thu, 10 Dec 2015 13:22:56 +0100
From: Karel Zak <kzak@redhat.com>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: David Wilson <dw@botanicus.net>, util-linux@vger.kernel.org
Subject: Re: [PATCH] Add mount -P to hide pseudo filesystems
Message-ID: <20151210122256.GE2353@ws.net.home>
References: <20151206042923.GA6570@k3>
 <20151207113409.GC2353@ws.net.home>
 <5665A178.5050601@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5665A178.5050601@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Dec 07, 2015 at 09:10:48AM -0600, Bruce Dubbs wrote:
> Karel Zak wrote:
> >On Sun, Dec 06, 2015 at 04:29:23AM +0000, David Wilson wrote:
> >>This is just shorthand for an increasingly necessary yet cumbersome and
> >>error-prone "grep -v" pipe. The alternative was to extend -t to accept
> >>"nopseudofs", but that is tougher on the fingers.
> >
> >  I don't plan to improve mount(8) list output in any way to duplicate
> >  findmnt(8). Please, let's use (and improve) findmnt(8). Thanks.
> >
> >  Anyway,
> >
> >      --real
> >      --net
> >      --pseudo
> >
> >  sounds good for findmnt. Look forward for a patch :-)
> 
> Is it possible to detect --bind in findmnt?

No, nowhere in the system is information about a way how the
filesystem has been mounted to the system. (Well, except obsolete
classic /etc/mtab.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

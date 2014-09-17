Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40277 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753617AbaIQJzh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 17 Sep 2014 05:55:37 -0400
Date: Wed, 17 Sep 2014 11:55:28 +0200
From: Karel Zak <kzak@redhat.com>
To: JWP <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: * RECALL * [PATCH 1/2] hwclock: hctosys drift compensation
Message-ID: <20140917095528.GJ7867@x2.net.home>
References: <5415EC97.4060305@gmx.com>
 <5416F1CC.2010007@gmx.com>
 <20140916093525.GG7867@x2.net.home>
 <54183647.2080101@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54183647.2080101@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 16, 2014 at 09:08:23AM -0400, JWP wrote:
> Hello Karel,
> 
> On 09/16/2014 05:35 AM, Karel Zak wrote:  
> >  See Documentation/TODO, the writable /etc/adjtime sucks, because in
> >  many cases we want to keep /etc read-only. I see two possible ways:
> 
> Yes, I saw that and have it on my todo list.  However, it is down my list a ways.
> I had not planned on attempting to integrate it into the hctosys/show patch.
> 
> >      -- the problem is that the file (specially last UTC/LOCAL line)
> >         may be expected by another tools
> 
> True, init scripts depend upon that information too. So it is an important
> consideration.
> 
> My initial thought when I read u-l's todo list was that adjtimex [ -c | -a ]
> depend upon /etc/adjtime *drift* data.  Do we care about breaking that?

I'm not sure, but I guess adjtimex reads /etc/adjtime to get info
about UTC/LOCAL only. Well, it seems we need to check adjtimex code.

Anyway, if adjtimex depends on drift data then we can change it too to
use /var.

Note that we have hwclock --compare to provide adjtimex -c functionality 
with in hwclock.

> I have often thought that hwclock should have a separate 'configuration' file,
> for example, to allow specific init behavior customization without requiring
> system admins to modify the init scripts.

The old RHEL/Fedora has /etc/sysconfig/hwclock where is possible
to specify hwclock command line, so no one is forced to modify init
scripts. All you need is to read the file from your init scripts.

BTW, slowly growing number of systemd based distributions where
hwclock --hctosys and --adjust is no more used and we usually assume
that NTP + kernel is enough to update CMOS. From this point of view
hwclock(8) is more about very basic low-level HW clock manipulation
than about systime and hwtime relationship :-)  

(but yes, we (upstream) still support the original hwclock(8) use-cases
 and non-systemd installations)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

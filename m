Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:58066 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753421AbaIPNI3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 16 Sep 2014 09:08:29 -0400
Message-ID: <54183647.2080101@gmx.com>
Date: Tue, 16 Sep 2014 09:08:23 -0400
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: * RECALL * [PATCH 1/2] hwclock: hctosys drift compensation
References: <5415EC97.4060305@gmx.com> <5416F1CC.2010007@gmx.com> <20140916093525.GG7867@x2.net.home>
In-Reply-To: <20140916093525.GG7867@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello Karel,

On 09/16/2014 05:35 AM, Karel Zak wrote:  
>  See Documentation/TODO, the writable /etc/adjtime sucks, because in
>  many cases we want to keep /etc read-only. I see two possible ways:

Yes, I saw that and have it on my todo list.  However, it is down my list a ways.
I had not planned on attempting to integrate it into the hctosys/show patch.

>      -- the problem is that the file (specially last UTC/LOCAL line)
>         may be expected by another tools

True, init scripts depend upon that information too. So it is an important
consideration.

My initial thought when I read u-l's todo list was that adjtimex [ -c | -a ]
depend upon /etc/adjtime *drift* data.  Do we care about breaking that?

BJH's hwclock uses /var/state/adjtime, that seems like a good choice as well. ?

I have often thought that hwclock should have a separate 'configuration' file,
for example, to allow specific init behavior customization without requiring
system admins to modify the init scripts.

Will

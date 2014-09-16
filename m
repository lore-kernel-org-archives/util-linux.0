Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oa0-f47.google.com ([209.85.219.47]:61064 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895AbaIPQcr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 16 Sep 2014 12:32:47 -0400
Received: by mail-oa0-f47.google.com with SMTP id g18so94757oah.6
        for <util-linux@vger.kernel.org>; Tue, 16 Sep 2014 09:32:46 -0700 (PDT)
Message-ID: <5418662B.5080409@gmail.com>
Date: Tue, 16 Sep 2014 11:32:43 -0500
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: JWP <elseifthen@gmx.com>
CC: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: * RECALL * [PATCH 1/2] hwclock: hctosys drift compensation
References: <5415EC97.4060305@gmx.com> <5416F1CC.2010007@gmx.com> <20140916093525.GG7867@x2.net.home> <54183647.2080101@gmx.com>
In-Reply-To: <54183647.2080101@gmx.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

JWP wrote:
> Hello Karel,
>
> On 09/16/2014 05:35 AM, Karel Zak wrote:
>>   See Documentation/TODO, the writable /etc/adjtime sucks, because in
>>   many cases we want to keep /etc read-only. I see two possible ways:
>
> Yes, I saw that and have it on my todo list.  However, it is down my list a ways.
> I had not planned on attempting to integrate it into the hctosys/show patch.
>
>>       -- the problem is that the file (specially last UTC/LOCAL line)
>>          may be expected by another tools
>
> True, init scripts depend upon that information too. So it is an important
> consideration.
>
> My initial thought when I read u-l's todo list was that adjtimex [ -c | -a ]
> depend upon /etc/adjtime *drift* data.  Do we care about breaking that?
>
> BJH's hwclock uses /var/state/adjtime, that seems like a good choice as well. ?

/var/state is not in the Filesystem Hierarchy Standard.

"Applications must generally not add directories to the top level of 
/var. Such directories should only be added if they have some 
system-wide implication, and in consultation with the FHS mailing list."

   -- Bruce

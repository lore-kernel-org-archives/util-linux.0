Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:55978 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752056AbdCDV5V (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 4 Mar 2017 16:57:21 -0500
Subject: Re: [V2 0/4] hwclock: remove date(1)
To: Assaf Gordon <assafgordon@gmail.com>, Karel Zak <kzak@redhat.com>
References: <ee9e12b4-a921-b47e-975d-53a5b8575361@gmx.com>
 <20170228133713.377klbjm44roizx6@ws.net.home>
 <0d36f495-d691-9e80-9c05-461d3563b468@gmx.com>
 <20170228161000.ijlouecku6a37quk@ws.net.home>
 <20170228170122.GA18228@gmail.com>
From: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Message-ID: <5bde338e-a434-8e11-372f-9ef65b742aec@gmx.com>
Date: Sat, 4 Mar 2017 16:57:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170228170122.GA18228@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On 02/28/2017 12:01 PM, Assaf Gordon wrote:
> 
> I might suggest doing away first with relative times, then perhaps
> with timezones.
> 
> There are some confusing combinations, especially with relative times
> (e.g.  "20170228 + 2 days" vs "20:45:45 + 2 days", the latter parsed
> as "8:45:45pm+02:00TZ + 1 day"),
> 
> and then with all sorts of things that are taken as timezones (like
> "2017A" which is parsed as '8:17pm in timezone -01:00'.

Hello Assaf,

Because hwclock(8) was using date(1) to parse --date strings, it has
always be subject to these issues. Some time ago I added a warning not
to use relative times in hwclock.8. I just added a warning about
timezones as well. 

I don't think blocking them from the parser is needed. They could be
useful to some other util-linux module.

> 
> I'm happy to help with testing if needed.

Thank you very much Assaf.



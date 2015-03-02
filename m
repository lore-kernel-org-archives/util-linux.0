Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56368 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752705AbbCBJNu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Mar 2015 04:13:50 -0500
Date: Mon, 2 Mar 2015 10:13:38 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 03/16] flock: improve timeout handling
Message-ID: <20150302091338.GH8046@ws.net.home>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
 <1424616106-580-4-git-send-email-kerolasa@iki.fi>
 <20150224102128.GF19430@ws.net.home>
 <alpine.LNX.2.03.1503011134070.822@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.03.1503011134070.822@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 01, 2015 at 11:46:11AM +0000, Sami Kerola wrote:
> Moving to monotonic sounds good to me. Notice that there is linking change 
> in configure.ac making monotonic.c to be linked with -lrt even when 
> clock_gettime() would not require it. The timer_create() requires -lrt at 
> last for now.
> 
> https://github.com/kerolasa/lelux-utiliteetit/commit/50425160a825986abb4e9c22ef8acee8e7b34834

OK.

> s/CLOCKGETTIME_LIBS/UL_REALTIME_LIBS/
> 
> Better?

 Yeah.

> Correct. After the change flock(1) cannot be forced to timeout by sending 
> an ALRM signal. Is that good, bad, or possible regression is debatable. I 
> think allowing external signals to cause timeout is unintented behavior. 

 I think it's better to split signals and timers.

> Function pointer is added.
> 
> https://github.com/kerolasa/lelux-utiliteetit/commit/50425160a825986abb4e9c22ef8acee8e7b34834

 You forgot to update commit message ("This code is moved ...").

 Anyway, looks good.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

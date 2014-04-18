Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54905 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857AbaDRLNE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 18 Apr 2014 07:13:04 -0400
Date: Fri, 18 Apr 2014 13:12:56 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: Nicolas <nicolas.delaby@ezeep.com>, util-linux@vger.kernel.org
Subject: Re: nsenter: passing command arguments
Message-ID: <20140418111256.GM5786@x2.net.home>
References: <534F91FD.4020803@ezeep.com>
 <535052E2.2010705@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <535052E2.2010705@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Apr 18, 2014 at 12:17:06AM +0200, Bernhard Voelker wrote:
> On 04/17/2014 10:34 AM, Nicolas wrote:
> > Hi,
> > I'm struggling with nsenter to call commands with options because they 
> > are caught by nsenter and complain this is an invalid option.
> > 
> > How can I pass any arbitrary argument ?
> > 
> > Thanks for reading,
> > Nicolas
> > 
> > ```
> > $ nsenter --target $PID --mount --uts --ipc --net --pid ls -a
> > nsenter: invalid option -- 'a'
> 
> Use '--' to tell nsenter to stop option parsing:
>   $ nsenter --target $PID --mount --uts --ipc --net --pid -- ls -a
> 
> Although I think this can be considered a bug; nsenter should
> do this automatically when seeing the first non-option.

 Yep, fixed (also in unshare).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

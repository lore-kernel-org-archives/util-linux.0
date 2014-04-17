Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.24]:50159 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbaDQWRJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 17 Apr 2014 18:17:09 -0400
Message-ID: <535052E2.2010705@bernhard-voelker.de>
Date: Fri, 18 Apr 2014 00:17:06 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Nicolas <nicolas.delaby@ezeep.com>, util-linux@vger.kernel.org
Subject: Re: nsenter: passing command arguments
References: <534F91FD.4020803@ezeep.com>
In-Reply-To: <534F91FD.4020803@ezeep.com>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 04/17/2014 10:34 AM, Nicolas wrote:
> Hi,
> I'm struggling with nsenter to call commands with options because they 
> are caught by nsenter and complain this is an invalid option.
> 
> How can I pass any arbitrary argument ?
> 
> Thanks for reading,
> Nicolas
> 
> ```
> $ nsenter --target $PID --mount --uts --ipc --net --pid ls -a
> nsenter: invalid option -- 'a'

Use '--' to tell nsenter to stop option parsing:
  $ nsenter --target $PID --mount --uts --ipc --net --pid -- ls -a

Although I think this can be considered a bug; nsenter should
do this automatically when seeing the first non-option.

Have a nice day,
Berny

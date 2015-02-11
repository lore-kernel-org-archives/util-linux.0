Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45963 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbbBKKFd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 11 Feb 2015 05:05:33 -0500
Date: Wed, 11 Feb 2015 11:05:28 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/3] script: no logging for non-interactive shells
Message-ID: <20150211100528.GA32133@ws.net.home>
References: <54DA787B.4090205@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54DA787B.4090205@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 10, 2015 at 10:30:35PM +0100, Stanislav Brabec wrote:
> Many people use script in their shell initialization files. It has some
> unwanted consequences, e. g. logging commands from cron (and starting them
> in a pseudo-terminal and interactive shell). It could also result in a
> seemingly hanging applications:
> 
> For example:
> 
> echo -e './script\nTERM=linux mutt' | \
>   at $(date -d "+1 minute 5 seconds" +%H:%M)
> 
> mutt will "hang" inside at, because it thinks that it is running in an
> interactive shell and waits for input.
> 
> That is why I wrote --interactive command line option. If it is set, script
> called from a non-interactive session will not log anything, just
> (optionally) execute -c argument and silently exit.

Would be better to learn people to fix their shell initialization
files to not call script(1) for non-interactive sessions?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

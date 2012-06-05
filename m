Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58779 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155Ab2FELq1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 5 Jun 2012 07:46:27 -0400
Date: Tue, 5 Jun 2012 13:46:16 +0200
From: Karel Zak <kzak@redhat.com>
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: util-linux@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: flock(1) exit code (enhancement request)
Message-ID: <20120605114616.GB14536@x2.net.home>
References: <20120529114518.GI1744@fi.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120529114518.GI1744@fi.muni.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 29, 2012 at 01:45:18PM +0200, Jan Kasprzak wrote:
>         This problem can be solved for example by mapping the exit code 1
> of the -c command to something else. I.e. to add something like
> 
>         -m <number>
>         --map-exit-code-1-to <number>
> 
> where the exit code of flock(1) would be <number>, iff the -c <command> exits
> with code 1.

Not sure if a generic remap for exit(1) is a good solution.

> 	The alternative would be to have user-settable exit code for
> the "conflicting lock exists" failure.

Yes, It would be nice to have user-settable exit codes, for:

    --rc-timeout <num>
    --rc-conflict <num>

> 	What do you think about it? If you agree with the above syntax,
> I can of course post a patch to flock(1).

Send patch.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

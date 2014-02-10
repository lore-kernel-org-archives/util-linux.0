Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32827 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940AbaBJSIg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 10 Feb 2014 13:08:36 -0500
Date: Mon, 10 Feb 2014 19:08:31 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Correct max priority in renice man page
Message-ID: <20140210180831.GQ8506@x2.net.home>
References: <1391883730-11767-1-git-send-email-psusi@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1391883730-11767-1-git-send-email-psusi@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Feb 08, 2014 at 01:22:10PM -0500, Phillip Susi wrote:
> The man page stated that the PRIO_MAX is 20.  While this
> is correct, the header definition is wrong and the max
> value is actually 19.

 I have removed all notes about PRIO_MAX from the man page. The kernel
 syscalls use hardcoded limits rather than anything from header files.

 SYSCALL_DEFINE3(setpriority, int, which, int, who, int, niceval)
    ...
	if (niceval < -20)
		niceval = -20;
	if (niceval > 19)
		niceval = 19;

 and almost the same is SYSCALL_DEFINE1(nice...

 :-)

>  sys-utils/renice.1 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

 Applied, thanks.


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

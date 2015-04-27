Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45115 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751915AbbD0IYU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 27 Apr 2015 04:24:20 -0400
Date: Mon, 27 Apr 2015 10:24:11 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org, Federico Simoncelli <fsimonce@redhat.com>
Subject: Re: blkdiscard progress breakes test
Message-ID: <20150427082411.GJ27969@ws.net.home>
References: <201504221943.06644.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201504221943.06644.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 22, 2015 at 07:43:06PM +0200, Ruediger Meier wrote:
> Commit c472a7e3 introduced progress messages. This randomly
> breaks the test-suite like this:
> 
> 
>    blkdiscard: offsets                        ... FAILED (blkdiscard/offsets)
> ....
> --- /home/abuild/rpmbuild/BUILD/util-linux-2.26.git233.01aa/tests/expected/blkdiscard/offsets   2014-10-28 06:53:35.483698330 +0000
> +++ /home/abuild/rpmbuild/BUILD/util-linux-2.26.git233.01aa/tests/output/blkdiscard/offsets     2015-04-22 15:41:45.748155291 +0000
> @@ -21,7 +21,8 @@
>  blkdiscard: offset 1 is not aligned to sector size 512
>  blkdiscard: offset 1 is not aligned to sector size 512
>  blkdiscard: offset 511 is not aligned to sector size 512
> -Discarded 1536 bytes from the offset 512
> +Discarded 1024 bytes from the offset 512
> +Discarded 512 bytes from the offset 1536
>  Discarded 1024 bytes from the offset 1024
>  testing misaligned steps full device
>  blkdiscard: length 1 is not aligned to sector size 512
> 
> 
> It's because we ignore timeval's tv_usec here:
>   if (last.tv_sec < now.tv_sec) {
>       print_stats(path, stats);
> 
> We could make it better if we also compare tv_usec

I have doubts you can fix it, the progress reporting is based fixed
time intervals (60sec), but the number of the discarded chunks within
the interval depends on system and HW performance. IMHO the regression
test will be always fragile.

> but IMO it would be fine
> to print the stats only one time at the end. Maybe
>  -v   prints stats one time only
>  -vv  report progress

-vv is unnecessary, the progress is reported only when you specify 
-v together with -s.

I also guess that "-vs" is already used in applications, it would be
better to not change the behaviors.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

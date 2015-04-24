Return-Path: util-linux-owner@vger.kernel.org
Received: from mx4-phx2.redhat.com ([209.132.183.25]:34026 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424AbbDXNVf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 24 Apr 2015 09:21:35 -0400
Date: Fri, 24 Apr 2015 09:21:33 -0400 (EDT)
From: Federico Simoncelli <fsimonce@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Message-ID: <817604936.6367490.1429881692238.JavaMail.zimbra@redhat.com>
In-Reply-To: <201504221943.06644.sweet_f_a@gmx.de>
References: <201504221943.06644.sweet_f_a@gmx.de>
Subject: Re: blkdiscard progress breakes test
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

----- Original Message -----
> From: "Ruediger Meier" <sweet_f_a@gmx.de>
> To: util-linux@vger.kernel.org
> Cc: "Federico Simoncelli" <fsimonce@redhat.com>
> Sent: Wednesday, April 22, 2015 7:43:06 PM
> Subject: blkdiscard progress breakes test
> 
> Hi,
> 
> Commit c472a7e3 introduced progress messages. This randomly
> breaks the test-suite like this:
> 
> 
>    blkdiscard: offsets                        ... FAILED (blkdiscard/offsets)
> ....
> ---
> /home/abuild/rpmbuild/BUILD/util-linux-2.26.git233.01aa/tests/expected/blkdiscard/offsets
> 2014-10-28 06:53:35.483698330 +0000
> +++
> /home/abuild/rpmbuild/BUILD/util-linux-2.26.git233.01aa/tests/output/blkdiscard/offsets
> 2015-04-22 15:41:45.748155291 +0000
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
> We could make it better if we also compare tv_usec but IMO it would be fine

+1 to fix it (rather easy).

> to print the stats only one time at the end. Maybe
>  -v   prints stats one time only
>  -vv  report progress

But then -vv needs to be tested anyway.

-- 
Federico

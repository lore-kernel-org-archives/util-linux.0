Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46824 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851AbaBQOMQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 17 Feb 2014 09:12:16 -0500
Date: Mon, 17 Feb 2014 15:12:13 +0100
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org
Subject: Re: blkid/lowprobe-pt-sgi test fails
Message-ID: <20140217141213.GI2254@x2.net.home>
References: <4519439.E1t8VFOsNj@vapier>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4519439.E1t8VFOsNj@vapier>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 17, 2014 at 03:36:10AM -0500, Mike Frysinger wrote:
> --- tests/expected/blkid/lowprobe-pt-sgi	2013-04-19 23:25:38.640717145 -0400
> +++ tests/output/blkid/lowprobe-pt-sgi	2014-02-17 03:33:24.430058781 -0500
> @@ -2,3 +2,5 @@
>  ---
>  #1:         63    1606437  0x83
>  #2:    1606500   30523500  0x83
> +#9:          0       4096  0x0
> +#11:          0   32130000  0x6

 This is correct output, fixed, git pull.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

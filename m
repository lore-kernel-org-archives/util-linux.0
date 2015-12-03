Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53825 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932327AbbLCL1a (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 3 Dec 2015 06:27:30 -0500
Date: Thu, 3 Dec 2015 12:27:28 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: libblkid: blkid_bufinfo() fails on 32bit
Message-ID: <20151203112728.GK4955@ws.net.home>
References: <201512030257.06753.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201512030257.06753.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Dec 03, 2015 at 02:57:06AM +0100, Ruediger Meier wrote:
> but it still looks broken, see this debug output
> 
> 
> libblkid: LOWPROBE: --> starting probing loop [SUBLKS idx=-1]
> libblkid: LOWPROBE: [0] linux_raid_member:
> libblkid: LOWPROBE:     call probefunc()
> libblkid:   BUFFER:     mapping end of the device
> libblkid:   BUFFER:     mmap  0xf7321000: off=4112515072, len=25771900928 (6291968 pages)
>                                                       ^^^^^^^

Yep, fixed.

-#define PROBE_ALIGN_OFF(p, o)  ((o) & ~((p)->mmap_granularity - 1))
+#define PROBE_ALIGN_OFF(p, o)  ((o) & ~((p)->mmap_granularity - 1ULL))

.. it's necessary to be more explicit with constants ;-)

Thanks!

    Karel


>    shouldn't we only mmap about 2M?
> 
> libblkid:   BUFFER:     reuse 0xf7321000: off=4112515072 len=25771900928 (for off=29884407808 len=256)
> libblkid:   BUFFER:     mapping begin of the device
> libblkid:   BUFFER:     mmap  0xf7121000: off=0, len=2097152 (512 pages)
> libblkid:   BUFFER:     reuse 0xf7121000: off=0 len=2097152 (for off=4096 len=256)
> 
> cu,
> Rudi
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

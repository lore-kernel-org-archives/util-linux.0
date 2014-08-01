Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20023 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753497AbaHAKhc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 1 Aug 2014 06:37:32 -0400
Date: Fri, 1 Aug 2014 12:37:25 +0200
From: Karel Zak <kzak@redhat.com>
To: Timofey Titovets <nefelim4ag@gmail.com>
Cc: util-linux@vger.kernel.org, Minchan Kim <minchan@kernel.org>
Subject: Re: [RFC] [Patch v2] Created zramctl
Message-ID: <20140801103725.GB8805@x2.net.home>
References: <53CAAAB6.6020607@gmail.com>
 <53D54D4D.5010905@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53D54D4D.5010905@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 27, 2014 at 10:04:45PM +0300, Timofey Titovets wrote:
> I spend some time and rewrite zramctl for util-linux.

 Thanks! Merged.

> sysfs.h powerful, but i can't understand how working sysfs.h and how i can
> implement it(?), and i think what my helper function is easier now, than
> sysfs.h realization

 I have modified your code to use sysfs stuff and to use libsmartcols
 in better way. So now it's more compatible with another ls-like utils
 we have in util-linux. For example you can specify output columns by
 --output, it makes it more friendly for scripts etc.

 # /zramctl 
 NAME       ALGORITHM DISKSIZE DATA COMPR TOTAL STREAMS MOUNTPOINT
 /dev/zram1               100M  44K  876B   44K         /mnt/test
 /dev/zram2               123M   4K   78B    4K         [SWAP]
 /dev/zram3                10M   0B    0B    0B         


 Note that I have kernel 3.14, so things like number of compression
 streams and compression algorithm are invisible for me (I going to
 update and test it with new kernel this afternoon).


 Anyway, zRam seems like nice project. I'll try to add support to
 swapon next week. My idea is something like (in fstab):

  /dev/zram0  swap  swap  x-zram.disksize=100M,x-zram.algorithm=lzo,auto


 it means use x-* options (we use this notation for another things) to
 specify zram setting. The controversial thing is that we have to call
 mkswap from swapon, but it's already supported for swap
 reinitialization (after system resume or on page size change etc.)

 ... or is it over-engineering?

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

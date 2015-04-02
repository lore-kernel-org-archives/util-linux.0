Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47746 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752223AbbDBIdy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 2 Apr 2015 04:33:54 -0400
Date: Thu, 2 Apr 2015 10:33:49 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: about test mount/rlimit
Message-ID: <20150402083349.GD2097@ws.net.home>
References: <201504011404.27321.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201504011404.27321.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 01, 2015 at 02:04:27PM +0200, Ruediger Meier wrote:
> ts_init_subtest "umount"
> [ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
> $TS_CMD_MOUNT $DEVICE $TS_MOUNTPOINT &> /dev/null
> OLD_SUM=$(mtab_checksum)
> (
>         ulimit -f 1
>         $TS_CMD_UMOUNT $TS_MOUNTPOINT &> /dev/null
> ) &> /dev/null
> NEW_SUM=$(mtab_checksum)
> $TS_CMD_UMOUNT $TS_MOUNTPOINT &> /dev/null
> [ $NEW_SUM = $OLD_SUM ] && echo "OK: mtab unmodified by umount" >> 
> $TS_OUTPUT
> ts_finalize_subtest
> ...........
> 
> I do not fully understand what is expected. Obviously the first "umount" 
> should NOT modify /etc/mtab. But should it umount or not, or doesn't 
> matter? Why we call a second umount then?

I guess the second umount is just copy & past (from mount test) and
it's there to be sure that the device has been really unmounted (and
this is unnecessary because ts_device_deinit() calls umount too).

> The problem is that in case that the first umount works we are leaving
> the test with a broken mtab file. This is not nice and also problematic 
> because later tests may find a mounted /dev/loop0 in /etc/mtab.

It would be probably better to replace the second umount with "umount
--fake" to only remove entry from mtab.

> Should we restore the original mtab? I guess it's a bit unsafe to copy 
> back a backed up one. Or is there a way to "repair/sync" 
> from /proc/mounts.?

Don't use /proc/mounts. It's bad idea as the files maybe very different.

use the --fake or you can try to redirect libmount to use non-standard
mtab by env. variable LIBMOUNT_MTAB=, but it will increase complexity
of the test.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

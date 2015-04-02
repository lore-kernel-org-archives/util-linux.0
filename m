Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47796 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260AbbDBK5z (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 2 Apr 2015 06:57:55 -0400
Date: Thu, 2 Apr 2015 12:57:52 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: about test mount/rlimit
Message-ID: <20150402105752.GF2097@ws.net.home>
References: <201504011404.27321.sweet_f_a@gmx.de>
 <20150402083349.GD2097@ws.net.home>
 <201504021205.21264.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201504021205.21264.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 02, 2015 at 12:05:20PM +0200, Ruediger Meier wrote:
> On Thursday 02 April 2015, Karel Zak wrote:
> > On Wed, Apr 01, 2015 at 02:04:27PM +0200, Ruediger Meier wrote:
> > > ts_init_subtest "umount"
> > > [ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
> > > $TS_CMD_MOUNT $DEVICE $TS_MOUNTPOINT &> /dev/null
> > > OLD_SUM=$(mtab_checksum)
> > > (
> > >         ulimit -f 1
> > >         $TS_CMD_UMOUNT $TS_MOUNTPOINT &> /dev/null
> > > ) &> /dev/null
> > > NEW_SUM=$(mtab_checksum)
> > > $TS_CMD_UMOUNT $TS_MOUNTPOINT &> /dev/null
> > > [ $NEW_SUM = $OLD_SUM ] && echo "OK: mtab unmodified by umount" >>
> > > $TS_OUTPUT
> > > ts_finalize_subtest
> > > ...........
> > >
> > > I do not fully understand what is expected. Obviously the first
> > > "umount" should NOT modify /etc/mtab. But should it umount or not,
> > > or doesn't matter? Why we call a second umount then?
> >
> > I guess the second umount is just copy & past (from mount test) and
> 
> Ah, now it makes sense. So the first umount should work and we could
> check "ismounted" too.

yes

> BTW could it be that in past "umount" always removed the mtab entry
> like "--fake" still does for umounted devices?

git show v2.13:mount/umount.c

       if (!nomtab &&
             (umnt_err == 0 || umnt_err == EINVAL || umnt_err == ENOENT)) {
                 update_mtab (node, NULL);
       }


so yes, but for me it's little bit fragile (for example EINVAL means
wrong mount options in same situations, unreachable mountpoint maybe
in situation when it's hidden by another mount and with namespaces it
does not make sense at all).

Thanks God that mtab is dead.

> Ah that's good. I'll send a patch with some other fixes later.
> The umount part would look like this: 
> 
>  	$TS_CMD_UMOUNT $TS_MOUNTPOINT &> /dev/null
>  ) &> /dev/null
>  NEW_SUM=$(mtab_checksum)
> -$TS_CMD_UMOUNT $TS_MOUNTPOINT &> /dev/null
>  [ $NEW_SUM = $OLD_SUM ] && echo "OK: mtab unmodified by umount" >> $TS_OUTPUT
> +ts_is_mounted $DEVICE && echo "FAIL: $DEVICE is still mounted" >> $TS_OUTPUT
> +# repair /etc/mtab
> +$TS_CMD_UMOUNT --fake $TS_MOUNTPOINT &> /dev/null
> +ts_is_mounted $DEVICE && ts_die "$DEVICE is still mounted"
>  ts_finalize_subtest

Seems good.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

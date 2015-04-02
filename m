Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: about test mount/rlimit
Date: Thu, 2 Apr 2015 12:05:20 +0200
Cc: util-linux@vger.kernel.org
References: <201504011404.27321.sweet_f_a@gmx.de> <20150402083349.GD2097@ws.net.home>
In-Reply-To: <20150402083349.GD2097@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201504021205.21264.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Thursday 02 April 2015, Karel Zak wrote:
> On Wed, Apr 01, 2015 at 02:04:27PM +0200, Ruediger Meier wrote:
> > ts_init_subtest "umount"
> > [ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
> > $TS_CMD_MOUNT $DEVICE $TS_MOUNTPOINT &> /dev/null
> > OLD_SUM=$(mtab_checksum)
> > (
> >         ulimit -f 1
> >         $TS_CMD_UMOUNT $TS_MOUNTPOINT &> /dev/null
> > ) &> /dev/null
> > NEW_SUM=$(mtab_checksum)
> > $TS_CMD_UMOUNT $TS_MOUNTPOINT &> /dev/null
> > [ $NEW_SUM = $OLD_SUM ] && echo "OK: mtab unmodified by umount" >>
> > $TS_OUTPUT
> > ts_finalize_subtest
> > ...........
> >
> > I do not fully understand what is expected. Obviously the first
> > "umount" should NOT modify /etc/mtab. But should it umount or not,
> > or doesn't matter? Why we call a second umount then?
>
> I guess the second umount is just copy & past (from mount test) and

Ah, now it makes sense. So the first umount should work and we could
check "ismounted" too.
BTW could it be that in past "umount" always removed the mtab entry
like "--fake" still does for umounted devices?

> it's there to be sure that the device has been really unmounted (and
> this is unnecessary because ts_device_deinit() calls umount too).


> > The problem is that in case that the first umount works we are
> > leaving the test with a broken mtab file. This is not nice and also
> > problematic because later tests may find a mounted /dev/loop0 in
> > /etc/mtab.
>
> It would be probably better to replace the second umount with "umount
> --fake" to only remove entry from mtab.

Ah that's good. I'll send a patch with some other fixes later.
The umount part would look like this: 

 	$TS_CMD_UMOUNT $TS_MOUNTPOINT &> /dev/null
 ) &> /dev/null
 NEW_SUM=$(mtab_checksum)
-$TS_CMD_UMOUNT $TS_MOUNTPOINT &> /dev/null
 [ $NEW_SUM = $OLD_SUM ] && echo "OK: mtab unmodified by umount" >> $TS_OUTPUT
+ts_is_mounted $DEVICE && echo "FAIL: $DEVICE is still mounted" >> $TS_OUTPUT
+# repair /etc/mtab
+$TS_CMD_UMOUNT --fake $TS_MOUNTPOINT &> /dev/null
+ts_is_mounted $DEVICE && ts_die "$DEVICE is still mounted"
 ts_finalize_subtest

> > Should we restore the original mtab? I guess it's a bit unsafe to
> > copy back a backed up one. Or is there a way to "repair/sync"
> > from /proc/mounts.?
>
> Don't use /proc/mounts. It's bad idea as the files maybe very
> different.
>
> use the --fake or you can try to redirect libmount to use
> non-standard mtab by env. variable LIBMOUNT_MTAB=, but it will
> increase complexity of the test.
>
>     Karel

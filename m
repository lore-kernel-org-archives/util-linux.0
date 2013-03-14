Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:63667 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756555Ab3CNKOX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Mar 2013 06:14:23 -0400
Date: Thu, 14 Mar 2013 11:14:17 +0100
From: Karel Zak <kzak@redhat.com>
To: Roger Leigh <rleigh@codelibre.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: A few small findmnt/mount issues
Message-ID: <20130314101417.GA7700@x2.net.home>
References: <20130314002147.GR23093@codelibre.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130314002147.GR23093@codelibre.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 14, 2013 at 12:21:47AM +0000, Roger Leigh wrote:
> - findmnt does not have column types for DUMP and PASS, so it's
>   not possible to get at all the fstab information when using the
>   --fstab option, unless there's a way of doing this I'm unaware
>   of.  For completeness, it would be very useful to be able to
>   retrieve all fstab(5) fields.  This would mean all access to
>   mtab and fstab can go via findmnt in our init scripts.

 Good idea. Implemented:

$ findmnt --fstab -o TARGET,FREQ,PASSNO
TARGET      FREQ PASSNO
/              1      1
/boot          1      2
/boot/efi      0      0
/home          1      2
/home/kzak     1      2
swap           0      0
/mnt/backup    0      0
/mnt/petra     0      0
/mnt/kzak      0      0

 
> - utab isn't updated on remount for _netdev:
>   If I have an fstab entry with _netdev in the fs_mntopts, this
>   will get stored in utab when I run "mount /foo".  However, if
>   I want to add the option after mount and use
>   "mount -o remount,_netdev /foo", this does not cause utab to
>   be updated.

 Hmm.. works for me (2.22.2 as well as mount(8) from git tree).


  # mount /dev/sdb /mnt/test 
  # cat /run/mount/utab

  # mount -o remount,_netdev /mnt/test

  # cat /run/mount/utab
  SRC=/dev/sdb TARGET=/mnt/test OPTS=_netdev


It would be nice to have reproducible example or/and debug output from
the library:

  LIBMOUNT_DEBUG=0xffff mount -o remount,_netdev ....

>   While this might appear contrived, we do actually make use of this
>   when filesystems mounted in an initramfs using busybox mount are

 BTW, is it really so attractive to use busybox in initramfs? IMHO the
 best way is to consolidate all possible utils and use the same code
 everywhere. (It does not mean that busybox is bad thing, but mix
 utils and environments is often problematic...)

>   interface.  Tested this with 2.20.1, but looking at the source

 Hmm... this is really old release. Update ;-)

>   looks like it's probably still present unless I misunderstood it.
>   May also affect other mount options?
> 
> Is there a preferred bugtracker you would like things like this
> reporting, or is here OK?

 Mailing list is OK.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

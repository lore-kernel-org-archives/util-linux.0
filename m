Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38642 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752226AbcBAKO1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 1 Feb 2016 05:14:27 -0500
Date: Mon, 1 Feb 2016 11:14:25 +0100
From: Karel Zak <kzak@redhat.com>
To: Zoltan <zoltan@z2zcorp.com>
Cc: util-linux@vger.kernel.org
Subject: Re: util-linux-2.27.1 - umount -a -O _netdev problem, _netdev ignored
Message-ID: <20160201101425.6wlxyttw4ddewly2@ws.net.home>
References: <56AD7FC5.3080902@z2zcorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56AD7FC5.3080902@z2zcorp.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jan 30, 2016 at 07:30:13PM -0800, Zoltan wrote:
> There is a problem in the code of util-linux-2.27.1, in the umount binary.
> 
> The command
> 
> umount -a -O _netdev
> 
> does _not_ umount anything, despite an /etc/fstab with the likes of
> 
> ...
> alpha:/var/mail       /var/mail      nfs _netdev,soft,tcp
> ...
> 
> The "mount -a -O _netdev" command works as expected.  However, the
> /run/mount/utab files is empty, and I was unable to get the "umount -a -O
> _netdev" to work as advertised.  Running it with "--verbose" flag merely
> confirmed that everything was being ": ignored".
> 
> I have a physical /etc/mtab (not symlink), and the "_netdev" option is missing
> from /etc/mtab file, but that's probably expected???

You need /etc/mtab *or* /run/mount/utab. It does not make sense to
have both files. Use 'rm -rf /run/mount' or use the symlink.

It's also important if you have /sbin/mount.nfs linked with libmount.
I guess it's system without systemd.

> If I manually add it (_netdev) to /etc/mtab, then the umount -a -O _netdev
> does work.  But /run/mount/utab is empty.  Trying to step through the code

It seems that the problem is not umount, but missing _netdev in mtab
or utab.

Suggestion:

* cleanup your disk (use the symlink or regular mtab)
* try "LIBMOUNT_DEBUG=all mount /var/mail" and verify that _netdev is
  stored on the disk (mtab or utab)
* if success try "LIBMOUNT_DEBUG=all umount -a -O _netdev"

Note that for NFS we use mount.nfs from nfs-utils package and it has to
be compiled with libmount, otherwise it does not store anything to utab
and use mtab (if possible).

On systems with systemd we use --enable-libmount-force-mountinfo where
classic mtab is ignored at all.

The env.variable LIBMOUNT_DEBUG=all is your good friend if you want to
debug anything.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

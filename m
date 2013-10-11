Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54469 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971Ab3JKIht (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 11 Oct 2013 04:37:49 -0400
Date: Fri, 11 Oct 2013 10:37:42 +0200
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: Matthias Schniedermeyer <ms@citd.de>, util-linux@vger.kernel.org
Subject: Re: Filesystem specific mount options mixed with auto fs type
Message-ID: <20131011083742.GA14457@x2.net.home>
References: <5256B7CF.7010103@ubuntu.com>
 <20131010170330.GA19031@citd.de>
 <5256E3EA.4000304@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5256E3EA.4000304@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 10, 2013 at 01:29:14PM -0400, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 10/10/2013 1:03 PM, Matthias Schniedermeyer wrote:
> > AFAIK "mount -s" is just for that case:
> > 
> > - man mount - -s Tolerate sloppy mount options rather than failing.
> > This will ignore mount options not supported by a filesystem type.
> > Not all filesystems support this option. This option exists for
> > support of the Linux autofs-based automounter. - man mount -
> 
> This doesn't seem to actually work.  Trying to mount an ext2 fs with
> the utf8 option still fails with an unknown option error.

"sloppy" is userspace command line option and I guess it was introduced
for NFS (nfs4, nfs, ...) and if I good remember nothing else uses this
option.

There is also "silent" (MS_SILENT) kernel mount flag, but it's usually 
used to avoid unwanted printk() when superblok not found.

Notes:

 * the "auto" fs type is usually used with generic mount options or
   with no options at all ("default" options)

 * well designed filesystems allows to save the filesystem specific 
   options to the FS superblock by some tune util (e.g. tune2fs)

 * for removable media users usually use udisks based solutions

 * mount by FS identifier

        LABEL=FOO       /mnt/floppy     vfat    utf8
        LABEL=BAR       /mnt/floppy     ext2    default

    and then "mount LABEL= ... "
  

 * for example NFS has nfsmount.conf where you can specify additional
   options, but I don't think it's a good idea to introduce this for
   all filesystems


Maybe we can improve mount(8) to test all entries from /etc/fstab
with the same mountpoint (if you want to mount-by-mountpoint)
until the filesystem will be mounted successfully. But I have doubts
that we really need to resolve this very old disadvantage.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

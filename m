Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:55288 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030661AbaDJNQd convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 10 Apr 2014 09:16:33 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] fstrim: add systemd units
Date: Thu, 10 Apr 2014 15:16:26 +0200
Cc: "Theodore Ts'o" <tytso@mit.edu>,
        Markus Trippelsdorf <markus@trippelsdorf.de>,
        util-linux@vger.kernel.org
References: <1396561311-12825-1-git-send-email-thomas@archlinux.org> <201404101117.05565.sweet_f_a@gmx.de> <20140410124914.GB26252@x2.net.home>
In-Reply-To: <20140410124914.GB26252@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201404101516.26942.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 10 April 2014, Karel Zak wrote:
> On Thu, Apr 10, 2014 at 11:17:04AM +0200, Ruediger Meier wrote:
> > Thanks, maybe we could add another minor change to "fstrim -a"
> > itself. If possible it would be IMO useful to skip bind mounts to
> > avoid trimming the same filesystem several times in a row like
> > this:
> >
> > $ grep "tmp" /etc/fstab
> > /dev/vg0/tmpdirs     /mnt/tmpdirs   ext4       acl,user_xattr     1
> > 2 /mnt/tmpdirs/tmp     /tmp           none       bind              
> > 0 0 /mnt/tmpdirs/var/tmp /var/tmp       none       bind            
> >   0 0
> >
> > $ ./fstrim -av
> > /tmp: 392 KiB (401408 bytes) trimmed
> > /var/tmp: 0 B (0 bytes) trimmed
> > /mnt/tmpdirs: 0 B (0 bytes) trimmed
> >
> > Skipping bind mounts should still trim all mounted filesytems.
>
> Good idea point, but what about systems where the original
> mountpoint is umounted?
>
>  /dev/sda1  /foo    ext4    default
>  /foo       /bar    none    bind
>
>   # mount /foo
>   # mount /bar
>   # umount /foo

Nice, I thought that wouldn't be even possible to do.

> the another story is that we use /proc/self/mountinfo where is
> nothing about "bind". It would be probably better to de-duplicate the
> list of the filesystems according to filesystem UUID or so.
>
> I'll think about it.

Maybe you could borrow the filter from lsblk. With my fstab above it 
seems to skip the bind mounts:

NAME            MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda               8:0    0 232.9G  0 disk
├─sda1            8:1    0   512M  0 part /boot
└─sda2            8:2    0 232.4G  0 part
  ├─vg0-root    253:0    0    24G  0 lvm  /
  ├─vg0-swap    253:1    0     4G  0 lvm  [SWAP]
  └─vg0-tmpdirs 253:2    0 204.4G  0 lvm  /mnt/tmpdirs

> Note all this is probably no problema for ext4 where according to
> Lukas is optimization to not call device trim command when there is
> nothing to trim.

Yes, but maybe nice if we could avoid this anyway. Who know what happens 
exactly when there is already a heavy load queue and we want to place 
in several trims.

cu,
Rudi


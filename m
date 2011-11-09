Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56455 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658Ab1KIBrp (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 8 Nov 2011 20:47:45 -0500
Received: by iage36 with SMTP id e36so1206190iag.19
        for <util-linux@vger.kernel.org>; Tue, 08 Nov 2011 17:47:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1320797364.3005.10.camel@offbook>
References: <CAPYQg32qP3Xb_gS45Md6ArqJGx22xZUdCg-W4z5f1ji2id7aSA@mail.gmail.com>
	<1320797364.3005.10.camel@offbook>
Date: Wed, 9 Nov 2011 10:47:45 +0900
Message-ID: <CAPYQg31aC1PDvZGtgtbvLZsLLYKo-SufL-qsDHAU5b+r3eErXQ@mail.gmail.com>
Subject: Re: behavior of "# mount /dev"
From: KIMURA Masaru <hiyuh.root@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> All in all I'm not sure I follow this problem and Google translate isn't
> helping much either.

OK. Now I'm trying to translate Naohiro Aota's explanation below.

-----

Same here on my Gentoo and Ubuntu 11.10.
"# mount /sys" does fail and warn "already mounted" but "# mount /dev" doesn't.

First of all, /dev is mounted on tmpfs which is a filesystem on memory.
And /sys is mounted on sysfs which is another filesystem on memory.

These are different filesystem.
tmpfs provides capabilities to create regular readable/writeable files
and directories.
sysfs provides an interface to read/write to/from kernel parameters.

Considering case of mounting tmpfs and sysfs on multiple mount points,
tmpfs should keep each contents per a mount point.
On the other hands, sysfs should keep identical contents on every mount points.

Based on the above filesystem's difference,

"mount -vvv /sys" shows

mount: fstab path: "/etc/fstab"
mount: mtab path:  "/etc/mtab"
mount: lock path:  "/etc/mtab~"
mount: temp path:  "/etc/mtab.tmp"
mount: UID:        0
mount: eUID:       0
mount: spec:  "sysfs"
mount: node:  "/sys"
mount: types: "sysfs"
mount: opts:  "rw,nosuid,nodev,noexec,relatime"
mount: mount(2) syscall: source: "sysfs", target: "/sys",
filesystemtype: "sysfs", mountflags: 2097166, data: (null)
mount: sysfs already mounted or /sys busy
mount: according to mtab, sysfs is already mounted on /sys

and returns a busy error.

"mount -vvv /dev" shows

mount: fstab path: "/etc/fstab"
mount: mtab path:  "/etc/mtab"
mount: lock path:  "/etc/mtab~"
mount: temp path:  "/etc/mtab.tmp"
mount: UID:        0
mount: eUID:       0
mount: spec:  "udev"
mount: node:  "/dev"
mount: types: "tmpfs"
mount: opts:  "rw,nosuid,relatime,size=10240k,mode=755"
mount: mount(2) syscall: source: "udev", target: "/dev",
filesystemtype: "tmpfs", mountflags: 2097154, data:
size=10240k,mode=755
udev on /dev type tmpfs (rw,nosuid,relatime,size=10240k,mode=755)

and doesn't return a busy error.

Both commands calls mount(2) syscall.
So we guess this difference is in kernel.

Digging kernel code,
mount(2) syscall of "mount /sys" processes in sysfs_mount() in fs/sysfs/mount.c
mount(2) syscall of "mount /dev"processes in shmem_mount() in mm/shmem.c

In sysfs_mount(), it creates a super block like this,

       sb = sget(fs_type, sysfs_test_super, sysfs_set_super, info);

sysfs_test_super function checks reusability of the super block.
If a super block is already created, it is reused.

In shmem_mount(), it just call mount_nodev() in fs/super.c.
mount_nodev() creates a super block like this

       struct super_block *s = sget(fs_type, NULL, set_anon_super,
       NULL);

so this doesn't check reusability of super block unlike sysfs_mout()
because of the second argument is NULL.
This results new super block is always created.

This implementation difference is trivial, we already consider case of
mounting tmpfs and sysfs on multiple mount points.

And we can see "return a busy error" for "mount /sys".
This is do_add_mount() in fs/namespace.c.

       /* Refuse the same filesystem on the same mount point */
       err = -EBUSY;
       if (path->mnt->mnt_sb == newmnt->mnt_sb &&
           path->mnt->mnt_root == path->dentry)
               goto unlock;

Thus, "mount /dev" always creates new super block and doesn't return a
busy error.
This results, if an user accidentally types "# mount /dev", no busy
error is returned and device files which are managed by udev are
suddenly overlaid new /dev.

Summary:
- "# mount /dev" hides udev managed /dev.
- because it doesn't return a busy error.
- because it uses tmpfs.
- using tmpfs, we are not able to treat this case as error in kernel.

By the way, "umount -l /dev" can unmount the overlaid /dev.

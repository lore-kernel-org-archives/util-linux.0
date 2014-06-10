Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34637 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbaFJPDj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 10 Jun 2014 11:03:39 -0400
Received: by mail-wi0-f176.google.com with SMTP id n3so3649243wiv.15
        for <util-linux@vger.kernel.org>; Tue, 10 Jun 2014 08:03:35 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 10 Jun 2014 08:03:35 -0700
Message-ID: <CA+zRj8Xs=A2sHp3DMD78u9Ak9v-xDSyZVtjB1JGJZ6Dx9t1z=w@mail.gmail.com>
Subject: Using findmnt in the presence of a stale NFS mount
From: Eric Rannaud <eric.rannaud@gmail.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <d@falconindy.com>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

On Arch Linux, various package install scripts use findmnt to check
the status of /boot or /usr. However, if there exists a stale NFS
mount on the system (for instance on /mnt), findmnt hangs when used in
commands such as:

findmnt -snero fstype --tab-file '/etc/fstab' -T '/usr'
findmnt -s /boot
findmnt -s /usr

(note that on my system, /usr is not a mount point of any kind, while
/boot is ext4. /mnt is the stale NFS mount)

This older Arch bug https://bugs.archlinux.org/task/36629 refers to
the problem, but as far as I can tell the problem still exists in the
same form (at the time, the package maintainer added the -T option to
the command "findmnt -snero fstype --tab-file '/etc/fstab' -T '/usr'",
but I don't believe it changed anything).

In any case, from having a look at the code on the latest git (I can
reproduce the hang with 710ed55dcd), I believe the problem comes from
the following sequence.

When used with the -s|--fstab flag, findmnt goes through the list of
mount points in the tab file, and compares them with the target
specified, say '/usr'.

The comparison is done using mnt_fs_match_target() in
findmnt.c:match_func(). mnt_fs_match_target() uses mnt_resolve_path()
on both target ('/usr') and
fs->target, which uses canonicalize_path(fs->target), which uses
realpath(fs->target). As the fs->target is the stale NFS mount point,
this last call hangs in a lstat().

While it is clear that a system with a stale NFS mount point is a
minefield, would it be possible to avoid the call to
"realpath(fs->target)" (maybe controlled by a command line option)?

As it is, it is impossible to upgrade an Arch Linux install when there
is a stale NFS mount anywhere on the system (and listed in fstab).

Thanks,
Eric

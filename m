Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:29091 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753336AbaFPN2U (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Jun 2014 09:28:20 -0400
Date: Mon, 16 Jun 2014 15:28:16 +0200
From: Karel Zak <kzak@redhat.com>
To: Eric Rannaud <eric.rannaud@gmail.com>
Cc: util-linux@vger.kernel.org, Dave Reisner <d@falconindy.com>
Subject: Re: Using findmnt in the presence of a stale NFS mount
Message-ID: <20140616132816.GK30975@x2.net.home>
References: <CA+zRj8Xs=A2sHp3DMD78u9Ak9v-xDSyZVtjB1JGJZ6Dx9t1z=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+zRj8Xs=A2sHp3DMD78u9Ak9v-xDSyZVtjB1JGJZ6Dx9t1z=w@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 10, 2014 at 08:03:35AM -0700, Eric Rannaud wrote:
> findmnt -snero fstype --tab-file '/etc/fstab' -T '/usr'
> findmnt -s /boot
> findmnt -s /usr
> 
> (note that on my system, /usr is not a mount point of any kind, while
> /boot is ext4. /mnt is the stale NFS mount)
> 
> This older Arch bug https://bugs.archlinux.org/task/36629 refers to
> the problem, but as far as I can tell the problem still exists in the
> same form (at the time, the package maintainer added the -T option to
> the command "findmnt -snero fstype --tab-file '/etc/fstab' -T '/usr'",
> but I don't believe it changed anything).
> 
> In any case, from having a look at the code on the latest git (I can
> reproduce the hang with 710ed55dcd), I believe the problem comes from
> the following sequence.
> 
> When used with the -s|--fstab flag, findmnt goes through the list of
> mount points in the tab file, and compares them with the target
> specified, say '/usr'.
> 
> The comparison is done using mnt_fs_match_target() in
> findmnt.c:match_func(). mnt_fs_match_target() uses mnt_resolve_path()
> on both target ('/usr') and
> fs->target, which uses canonicalize_path(fs->target), which uses
> realpath(fs->target). As the fs->target is the stale NFS mount point,
> this last call hangs in a lstat().
> 
> While it is clear that a system with a stale NFS mount point is a
> minefield, would it be possible to avoid the call to
> "realpath(fs->target)" (maybe controlled by a command line option)?
> 
> As it is, it is impossible to upgrade an Arch Linux install when there
> is a stale NFS mount anywhere on the system (and listed in fstab).

 You can try to  exclude NFS at all by --types nonfs, but maybe we can
 add option --nocanonicalize. I'll try to play with that tomorrow. 

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

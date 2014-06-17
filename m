Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:14338 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932697AbaFQMh7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Jun 2014 08:37:59 -0400
Date: Tue, 17 Jun 2014 14:37:54 +0200
From: Karel Zak <kzak@redhat.com>
To: Eric Rannaud <eric.rannaud@gmail.com>
Cc: util-linux@vger.kernel.org, Dave Reisner <d@falconindy.com>
Subject: Re: Using findmnt in the presence of a stale NFS mount
Message-ID: <20140617123754.GM30975@x2.net.home>
References: <CA+zRj8Xs=A2sHp3DMD78u9Ak9v-xDSyZVtjB1JGJZ6Dx9t1z=w@mail.gmail.com>
 <20140616132816.GK30975@x2.net.home>
 <20140616140047.GL30975@x2.net.home>
 <CA+zRj8VZSxJ8dPYOY_wSS5zbxaue1Vy-gyCkYxfLVqA_3FjQfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+zRj8VZSxJ8dPYOY_wSS5zbxaue1Vy-gyCkYxfLVqA_3FjQfA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 16, 2014 at 09:02:14AM -0700, Eric Rannaud wrote:
> Another solution would be to change canonicalize_path(): before
> calling realpath(fs->target), it would first check if fs->target is
> otherwise listed in mtab (using the comparison
> strcmp(from_mtab_fs->target, fs->target), not recursively using
> mnt_fs_target_match()). If found in mtab, canonicalize_path() knows
> that fs->target is not a symlink and it does not need to call
> realpath(fs->target), and it won't blow up.
> 
> There is no need for a command line option: canonicalize_path() can do
> this all the time, it will not change its semantics. However, findmnt

 I like the idea that we can rely on /proc/self/mountinfo and assume
 that all the mountpoints are already canonicalized so we can skip the
 extra canonicalize_path().

 But it would be probably better to extend struct libmnt_cache than
 change too low-level canonicalize_path().

 We can add two functions:

    mnt_cache_set_targets(struct libmnt_cache *cache, struct libmnt_table *mtab);
    mnt_resolve_target(char *path, struct libmnt_cache *cache);

 and check for @path in @mtab before canonicalize_path().

 Then we can use mnt_resolve_target() in mnt_fs_match_target() and
 mnt_table_find_target().
    
 And in findmnt.c all you need is to parse /proc/self/mountinfo and call 
 mnt_cache_set_targets() for the global cache when --target is specified
 (or always?).

> would have to systematically read /proc/mounts or mtab in an
> additional secondary structure, even if --fstab is specified. That
> requires changing findmnt's logic quite a bit, however, as currently
> it doesn't read mtab if --fstab is specified.

 We have to be very careful with /proc/mounts (and mountinfo), unfortunately 
 it has horrible performance impact for kernel on huge servers to generate 
 the /proc files.

> If you wish, I can have a crack at writing such a patch.

 Go ahead.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

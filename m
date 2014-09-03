Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57065 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751109AbaICHpW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 3 Sep 2014 03:45:22 -0400
Date: Wed, 3 Sep 2014 09:45:17 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: umount of unreachable NFS without -f [maybe PATCH]
Message-ID: <20140903074517.GD21325@x2.net.home>
References: <1409684978.14709.15.camel@oct.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1409684978.14709.15.camel@oct.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 02, 2014 at 09:09:38PM +0200, Stanislav Brabec wrote:
> I just analyzed causes of hang while calling umount without -f on an
> unreachable NFS.
> 
> The first hang happens on in lookup_umount_fs():
> 
> stat(tgt, &st) == 0 && S_ISDIR(st.st_mode)
> 
> I don't exactly know, what its removal causes, but I tried it.
> 
> I entered into next hang in mnt_resolve_path() inside has_utab_entry().
> We cannot prevent this hang in all cases, but preventing it in a
> standard situation is pretty straightforward: Try to match provided
> target name before trying to canonicalize.
> 
> Now my umount without -f works well at least in the case, when the mount
> point is recorded in the utab.
> 
> If it is not recorded in utab, it still hangs later in
> lookup_umount_fs() on:
> 
> if (statfs(tgt, &vfs) == 0)
> 
> Well, we can prevent even this hang, but it would be at cost of parsing
> mtab. I read your git comments and I see, that the whole purpose of the
> code is preventing of parsing of the generated mtab/mountinfo.
> 
> Would be parsing of fstab a safe way without paying this cost?

How often do you have NFS mounts without entry within utab? I think it's
pretty unusual (I guess you have mount.nfs linked with libmount).

The change in has_utab_entry() is definitely good idea, but I'm not
sure about the rest. Maybe it would be enough to call has_utab_entry()
before

    stat(tgt, &st) == 0 && S_ISDIR(st.st_mode)


then it will be good enough for almost all NFS mounts (with utab
entries).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

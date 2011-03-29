Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1028 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752285Ab1C2Kgs (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Mar 2011 06:36:48 -0400
Date: Tue, 29 Mar 2011 12:36:48 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>, Miklos Szeredi <mszeredi@suse.cz>
Subject: Re: [PATCH] umount: allow non-root umount of FUSE even if not in
	fstab
Message-ID: <20110329103648.GC2475@nb.net.home>
References: <20110328140454.GA4790@foxbat.suse.cz> <20110328220344.GQ21093@nb.net.home> <20110329084623.GC26819@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110329084623.GC26819@foxbat.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 29, 2011 at 10:46:23AM +0200, Petr Uzel wrote:
> > I believe more and more that we need something like
> > 
> >     /etc/mount.d/{fuse,foo,...}.conf
> > 
> > where we can define such behavior for some filesystems.
> 
> Hm, I fail to understand what (regarding to this 'issue') would
> you configure there. I can imagine e.g. per-fs-type default mount
> options or enable/disable 'user mounts' (-i) per fs-type.
> 
> Is this what you think that should be configured via /etc/mount.d/*,
> or something else?

The mount(8) and umount(8) are very strict about user mounts and about
the way how it calls /sbin/[u]mount helpers. It was fine many years
ago, but now we have things like pam_mount, fuse, HAL/udisks where
mount/umount stuff is managed in a different way. It means that we
need exceptions... and exceptions suck.

I think about:

 $ cat /etc/mount.d/fuse.conf

    [usermount]
    enabled = true
    require_fstab_entry = false
    require_helper = true


and yes, things like per-fs-type default mount options is another
possibility. 

Maybe this is something what should be added to the libmount.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:9618 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751593Ab1C2KDk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Mar 2011 06:03:40 -0400
Date: Tue, 29 Mar 2011 12:03:40 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: Miklos Szeredi <mszeredi@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] umount: allow non-root umount of FUSE even if not in
	fstab
Message-ID: <20110329100340.GA2475@nb.net.home>
References: <20110328140454.GA4790@foxbat.suse.cz> <20110328220344.GQ21093@nb.net.home> <20110329084623.GC26819@foxbat.suse.cz> <1301388690.22846.88.camel@tucsk.pomaz.szeredi.hu> <20110329085601.GD26819@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110329085601.GD26819@foxbat.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 29, 2011 at 10:56:01AM +0200, Petr Uzel wrote:
> On Tue, Mar 29, 2011 at 10:51:30AM +0200, Miklos Szeredi wrote:
> > On Tue, 2011-03-29 at 10:46 +0200, Petr Uzel wrote:
> > > > Wouldn't be better to always call /sbin/umount.fuse for non-roots (except
> > > > umount -i)? 
> > > 
> > > Yes, that's what I meant by umount helpers. The problem is that AFAICS
> > > fuse does not provide this helper.
> > > 
> > > @Miklos: what do you think? Would it make sense to have umount.fuse
> > > (most likely as symlink to /sbin/mount.fuse)? I could look into it.
> > 
> > Could umount.fuse allow umount of fuse filesystem even if not in fstab?

By default umount(8) requires an entry in /etc/fstab. This behaviour
could be changed by uhelper= mount option (the option has to be in
mtab). The solution based on uhelper= also sucks, because it requires
userspace specific mount option...

This is reason why I think that /etc/mount.d/fuse.conf would be better
than add an exception to the code or use uhelper= mount option. The
same problem we have with HAL (udisks) where non-root user stuff is
not in fstab.
 
> > If so, then I don't see any problem with providing /sbin/umount.fuse.
> 
> OK, I'll try to look into it.

It will require the exception for fuse.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

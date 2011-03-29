Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor.suse.de ([195.135.220.2]:37843 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751823Ab1C2Ivd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Mar 2011 04:51:33 -0400
Subject: Re: [PATCH] umount: allow non-root umount of FUSE even if not in
 fstab
From: Miklos Szeredi <mszeredi@suse.cz>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
In-Reply-To: <20110329084623.GC26819@foxbat.suse.cz>
References: <20110328140454.GA4790@foxbat.suse.cz>
	 <20110328220344.GQ21093@nb.net.home>
	 <20110329084623.GC26819@foxbat.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 29 Mar 2011 10:51:30 +0200
Message-ID: <1301388690.22846.88.camel@tucsk.pomaz.szeredi.hu>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, 2011-03-29 at 10:46 +0200, Petr Uzel wrote:
> > Wouldn't be better to always call /sbin/umount.fuse for non-roots (except
> > umount -i)? 
> 
> Yes, that's what I meant by umount helpers. The problem is that AFAICS
> fuse does not provide this helper.
> 
> @Miklos: what do you think? Would it make sense to have umount.fuse
> (most likely as symlink to /sbin/mount.fuse)? I could look into it.

Could umount.fuse allow umount of fuse filesystem even if not in fstab?

If so, then I don't see any problem with providing /sbin/umount.fuse.

Thanks,
Miklos



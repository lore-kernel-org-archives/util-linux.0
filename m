Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36666 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751448Ab1C2KNI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Mar 2011 06:13:08 -0400
Date: Tue, 29 Mar 2011 12:13:09 +0200
From: Karel Zak <kzak@redhat.com>
To: Miklos Szeredi <mszeredi@suse.cz>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] umount: allow non-root umount of FUSE even if not in
	fstab
Message-ID: <20110329101309.GB2475@nb.net.home>
References: <20110328140454.GA4790@foxbat.suse.cz> <1301322200.22846.68.camel@tucsk.pomaz.szeredi.hu> <20110329082850.GR21093@nb.net.home> <1301388524.22846.86.camel@tucsk.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301388524.22846.86.camel@tucsk.pomaz.szeredi.hu>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 29, 2011 at 10:48:44AM +0200, Miklos Szeredi wrote:
> On Tue, 2011-03-29 at 10:28 +0200, Karel Zak wrote:
> > On Mon, Mar 28, 2011 at 04:23:20PM +0200, Miklos Szeredi wrote:
> > > On Mon, 2011-03-28 at 16:04 +0200, Petr Uzel wrote:
> > > > Hi all,
> > > > 
> > > > I hacked the following patch with which it is possible to use 
> > > > "umount $dir" instead of "fusermount -u $dir", which IMHO is an
> > > > improvement in usability. It seems to work (at least for me), however,
> > > > I have to admit that I don't like it very much, because:
> > > > - it complicates umount
> > > > - duplicates code from fusermount
> > > 
> > > And this is not the only one that would have to be duplicated.  The
> > > mount and umount races that were fixed in fusermount in recently and not
> > > so recently would also have to be added to util-linux, which would
> > > actually be a good thing, since in theory they could affect fstab based
> > > user mounts as well (though that is much more unlikely than with fuse,
> > > where the user chooses the mountpoint).
> > 
> >  Maybe we need to call umount2() with UMOUNT_NOFOLLOW flag for
> >  non-root users in umount(8). I think it should be enough for
> >  umount(8) (where almost all is controlled by system admin in fstab). 
> >  
> >  See below. Comments?
> 
> UMOUNT_NOFOLLOW is a good idea but not enough, it will only deal with
> last path component changing to a symlink.  If previous path component
> is changed then UMOUNT_NOFOLLOW will not have any effect.
> 
> What fusermount does is change cwd to the parent directory, check if cwd
> matches that of the intended path, and then umount with UMOUNT_NOFOLLOW.

Ah.. I see the code. Thanks.

It would be nice to have

        mountat(dirfd, ...)
        umountat(dirfd, ...)

syscalls to avoid any races :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

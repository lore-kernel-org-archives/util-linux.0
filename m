Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41308 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751671AbcJDKdc (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 4 Oct 2016 06:33:32 -0400
Date: Tue, 4 Oct 2016 12:33:29 +0200
From: Karel Zak <kzak@redhat.com>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: Bug with read only handling in mount
Message-ID: <20161004103329.a6rgh2ytvivupdym@ws.net.home>
References: <20161004074132.gnjun7jwarp2kcgr@kmo-pixel>
 <20161004082909.2ot3vujqxwskhvyr@ws.net.home>
 <20161004091823.vzp6wili7d73lyvh@kmo-pixel>
 <20161004100240.qveupljutz57ygx4@ws.net.home>
 <20161004101039.uvyygixiopqpn7m6@kmo-pixel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161004101039.uvyygixiopqpn7m6@kmo-pixel>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 04, 2016 at 02:10:39AM -0800, Kent Overstreet wrote:
> > with that filesystem type.
> > 
> > Hmm.. I will try to improve it. The problem is that mount(8) interprets 
> > EACCES/EROFS as information about the device, then flip to RO makes sense 
> > for all next mount(2) attempts.
> > 
> > > > > The end result is that if we're trying to mount by trying every filesystem type
> > > > > (your libblkid doesn't know about your filesystem yet..), and the correct
> > > > > filesystem was listed after iso9600 in /proc/filesystems, mount will always
> > > > > mount RO (unless you specify the filesystem type with -t).
> > > > 
> > > > Not sure if I understand. Does it mean that iso9600 driver returns
> > > > EACCES for all devices although there is no this FS on the device? Or
> > > > your FS shares the device with iso9600?
> > > 
> > > Yes, iso9660 return EACCES when no iso9600 filesystem is present.
> > 
> > 
> > static struct dentry *isofs_mount(struct file_system_type *fs_type,
> >         int flags, const char *dev_name, void *data)
> > {                                 
> >         /* We don't support read-write mounts */
> >         if (!(flags & MS_RDONLY)) 
> >                 return ERR_PTR(-EACCES);
> >         return mount_bdev(fs_type, flags, dev_name, data, isofs_fill_super);
> > }
> > 
> > This is crazy... iso9600 driver starts analyze mount options although
> > the mount request is maybe completely irrelevant for the driver and 
> > there is no iso9600 on the device. 
> > 
> > If we will write FS drivers in this way then old good "try all from /{proc,etc}/filesystems"
> > will be useless...
> > 
> > See another filesystems, for example ext4, first be sure there is
> > superblock and magic string (or return EINVAL) and then try 
> > validate mount options.
> > 
> > CC to Jan Kara (he did the kernel change in Jun 2013).
> 
> Given that the error code is coming from driver code, I think taking it to mean
> anything about the underlying device is going to be flakey at best - we could

That's what we do in last 20 years, good to know it's wrong now.

> fix iso9660, sure, but there's a crap ton of filesystems in the kernel and I'm
> certainly not going to try to audit all their error paths. Even if a driver
> waits until after it verifies its magic string before returnig an error, you
> have cases where multiple drivers may be able to mount the filesystem or - even
> more fun - different filesystem types may have superblocks that don't live at
> the same offset, so the presense of ext4's magic number doesn't mean that not
> actually a completely different filesystem type (don't laugh! I've actually been
> bit by this).

:-)

> What's wrong with just changing mount(8) to only flip to RO for further attempts
> with that particular filesystem type?
 
As I said, I'll improve mount(8).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750724AbcJDKCm (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 4 Oct 2016 06:02:42 -0400
Date: Tue, 4 Oct 2016 12:02:40 +0200
From: Karel Zak <kzak@redhat.com>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: Bug with read only handling in mount
Message-ID: <20161004100240.qveupljutz57ygx4@ws.net.home>
References: <20161004074132.gnjun7jwarp2kcgr@kmo-pixel>
 <20161004082909.2ot3vujqxwskhvyr@ws.net.home>
 <20161004091823.vzp6wili7d73lyvh@kmo-pixel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161004091823.vzp6wili7d73lyvh@kmo-pixel>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 04, 2016 at 01:18:23AM -0800, Kent Overstreet wrote:
> On Tue, Oct 04, 2016 at 10:29:09AM +0200, Karel Zak wrote:
> > On Mon, Oct 03, 2016 at 11:41:32PM -0800, Kent Overstreet wrote:
> > > sys-utils/mount.c, mk_exit_code()
> > > 
> > > If the mount syscall returns EACCESS, the code treats this as meaning that RW
> > > access to the block device wasn't allowed - it switches to RO for all future
> > > mount attempts.
> > 
> > This is pretty old (>10years) mount behavior, util-linux 2.13:
> > 
> >     case EACCES:  /* pre-linux 1.1.38, 1.1.41 and later */
> >     case EROFS:   /* linux 1.1.38 and later */
> > 
> > > This is incorrect though, because EACCESS could just mean that that particular
> > > filesystem doesn't support RW: iso9600 returns EACCESS if you try to mount RW.
> > 
> > So, remount RO makes sense, right? I don't think we want to change
> > this behavior, all CDROM/DVD users depend on this.
> 
> Yes - what I'm saying is that we shouldn't quit trying to mount RW with _other_
> filesystem types. Or alternatively, we should only attempt to mount RO after
> that _particular_ driver has returned EACCES/EROFS.
> 
> The bug is that the global context is flipped to RO, not just for attempting
> with that filesystem type.

Hmm.. I will try to improve it. The problem is that mount(8) interprets 
EACCES/EROFS as information about the device, then flip to RO makes sense 
for all next mount(2) attempts.

> > > The end result is that if we're trying to mount by trying every filesystem type
> > > (your libblkid doesn't know about your filesystem yet..), and the correct
> > > filesystem was listed after iso9600 in /proc/filesystems, mount will always
> > > mount RO (unless you specify the filesystem type with -t).
> > 
> > Not sure if I understand. Does it mean that iso9600 driver returns
> > EACCES for all devices although there is no this FS on the device? Or
> > your FS shares the device with iso9600?
> 
> Yes, iso9660 return EACCES when no iso9600 filesystem is present.


static struct dentry *isofs_mount(struct file_system_type *fs_type,
        int flags, const char *dev_name, void *data)
{                                 
        /* We don't support read-write mounts */
        if (!(flags & MS_RDONLY)) 
                return ERR_PTR(-EACCES);
        return mount_bdev(fs_type, flags, dev_name, data, isofs_fill_super);
}

This is crazy... iso9600 driver starts analyze mount options although
the mount request is maybe completely irrelevant for the driver and 
there is no iso9600 on the device. 

If we will write FS drivers in this way then old good "try all from /{proc,etc}/filesystems"
will be useless...

See another filesystems, for example ext4, first be sure there is
superblock and magic string (or return EINVAL) and then try 
validate mount options.

CC to Jan Kara (he did the kernel change in Jun 2013).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

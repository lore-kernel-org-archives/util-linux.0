Return-Path: linux-fsdevel-owner@vger.kernel.org
Date: Tue, 4 Oct 2016 13:24:21 +0200
From: Karel Zak <kzak@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
        linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org
Subject: Re: Bug with read only handling in mount
Message-ID: <20161004112421.aopmqxzukydqx5jf@ws.net.home>
References: <20161004074132.gnjun7jwarp2kcgr@kmo-pixel>
 <20161004082909.2ot3vujqxwskhvyr@ws.net.home>
 <20161004091823.vzp6wili7d73lyvh@kmo-pixel>
 <20161004100240.qveupljutz57ygx4@ws.net.home>
 <20161004104943.GA22169@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161004104943.GA22169@quack2.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 04, 2016 at 12:49:43PM +0200, Jan Kara wrote:
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
> > If we will write FS drivers in this way then old good "try all from
> > /{proc,etc}/filesystems" will be useless...
> > 
> > See another filesystems, for example ext4, first be sure there is
> > superblock and magic string (or return EINVAL) and then try 
> > validate mount options.
> > 
> > CC to Jan Kara (he did the kernel change in Jun 2013).
> 
> Good point. I'll fix iso9660.

Thanks! 

I have a patch for mount(8), but it's rather complex, because the
/{proc,etc}/filesystems loop is hidden in libmount. I guess move the
MS_RDONLY check in the iso9660 kernel driver will be easy fix.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

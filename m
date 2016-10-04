Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33659 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752647AbcJDJS1 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 4 Oct 2016 05:18:27 -0400
Received: by mail-pf0-f179.google.com with SMTP id 190so26968907pfv.0
        for <util-linux@vger.kernel.org>; Tue, 04 Oct 2016 02:18:27 -0700 (PDT)
Date: Tue, 4 Oct 2016 01:18:23 -0800
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Bug with read only handling in mount
Message-ID: <20161004091823.vzp6wili7d73lyvh@kmo-pixel>
References: <20161004074132.gnjun7jwarp2kcgr@kmo-pixel>
 <20161004082909.2ot3vujqxwskhvyr@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161004082909.2ot3vujqxwskhvyr@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 04, 2016 at 10:29:09AM +0200, Karel Zak wrote:
> On Mon, Oct 03, 2016 at 11:41:32PM -0800, Kent Overstreet wrote:
> > sys-utils/mount.c, mk_exit_code()
> > 
> > If the mount syscall returns EACCESS, the code treats this as meaning that RW
> > access to the block device wasn't allowed - it switches to RO for all future
> > mount attempts.
> 
> This is pretty old (>10years) mount behavior, util-linux 2.13:
> 
>     case EACCES:  /* pre-linux 1.1.38, 1.1.41 and later */
>     case EROFS:   /* linux 1.1.38 and later */
> 
> > This is incorrect though, because EACCESS could just mean that that particular
> > filesystem doesn't support RW: iso9600 returns EACCESS if you try to mount RW.
> 
> So, remount RO makes sense, right? I don't think we want to change
> this behavior, all CDROM/DVD users depend on this.

Yes - what I'm saying is that we shouldn't quit trying to mount RW with _other_
filesystem types. Or alternatively, we should only attempt to mount RO after
that _particular_ driver has returned EACCES/EROFS.

The bug is that the global context is flipped to RO, not just for attempting
with that filesystem type.

> 
> > The end result is that if we're trying to mount by trying every filesystem type
> > (your libblkid doesn't know about your filesystem yet..), and the correct
> > filesystem was listed after iso9600 in /proc/filesystems, mount will always
> > mount RO (unless you specify the filesystem type with -t).
> 
> Not sure if I understand. Does it mean that iso9600 driver returns
> EACCES for all devices although there is no this FS on the device? Or
> your FS shares the device with iso9600?

Yes, iso9660 return EACCES when no iso9600 filesystem is present.

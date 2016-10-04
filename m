Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754241AbcJDI3Q (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 4 Oct 2016 04:29:16 -0400
Date: Tue, 4 Oct 2016 10:29:09 +0200
From: Karel Zak <kzak@redhat.com>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Bug with read only handling in mount
Message-ID: <20161004082909.2ot3vujqxwskhvyr@ws.net.home>
References: <20161004074132.gnjun7jwarp2kcgr@kmo-pixel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161004074132.gnjun7jwarp2kcgr@kmo-pixel>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 03, 2016 at 11:41:32PM -0800, Kent Overstreet wrote:
> sys-utils/mount.c, mk_exit_code()
> 
> If the mount syscall returns EACCESS, the code treats this as meaning that RW
> access to the block device wasn't allowed - it switches to RO for all future
> mount attempts.

This is pretty old (>10years) mount behavior, util-linux 2.13:

    case EACCES:  /* pre-linux 1.1.38, 1.1.41 and later */
    case EROFS:   /* linux 1.1.38 and later */

> This is incorrect though, because EACCESS could just mean that that particular
> filesystem doesn't support RW: iso9600 returns EACCESS if you try to mount RW.

So, remount RO makes sense, right? I don't think we want to change
this behavior, all CDROM/DVD users depend on this.

> The end result is that if we're trying to mount by trying every filesystem type
> (your libblkid doesn't know about your filesystem yet..), and the correct
> filesystem was listed after iso9600 in /proc/filesystems, mount will always
> mount RO (unless you specify the filesystem type with -t).

Not sure if I understand. Does it mean that iso9600 driver returns
EACCES for all devices although there is no this FS on the device? Or
your FS shares the device with iso9600?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

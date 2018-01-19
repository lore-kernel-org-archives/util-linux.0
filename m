Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754972AbeASKMs (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 19 Jan 2018 05:12:48 -0500
Date: Fri, 19 Jan 2018 11:12:45 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: moving filesystem mount options from util-linux to man-pages
Message-ID: <20180119101245.5umnbe6koa22hneh@ws.net.home>
References: <20180119023637.GI7217@vapier>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180119023637.GI7217@vapier>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 18, 2018 at 09:36:37PM -0500, Mike Frysinger wrote:
> the mount(8) man page covers not only the mount command, but also the
> various file system options that come from the kernel.  it seems like
> the communities have settled on the man-pages project for holding all
> the userland-facing documentation, it has good practices for tracking
> features across versions, and updating it is a lot easier/safer (than
> util-linux) and up-to-date on the web (via man7.org).  while looking
> up some proc/ramfs options, i noticed util-linux was out of date by
> over 6 years :/.

Please, send patch if you see any obsolete stuff in mount.8.
Unfortunately kernel guys (usually) don't care...

> imo, it seems like we should move all kernel-specific documentation
> out of the util-linux project and into man-pages.  obviously all the
> mount command line options and such should remain.

I've talked about it (including LKML) many times in last ten years.

> specifically i'm looking at "FILESYSTEM-SPECIFIC MOUNT OPTIONS":
> http://man7.org/linux/man-pages/man8/mount.8.html#FILESYSTEM-SPECIFIC_MOUNT_OPTIONS
> 
> we probably want to leave "FILESYSTEM-INDEPENDENT MOUNT OPTIONS"
> in util-linux since those are all parsed by util-linux's mount
> and turned into the MS_xxx bits.
> 
> thoughts ?  mount(2) doesn't seem like the best place, but these
> are the fields that go in the "data" string to that syscall.

Fortunately, this "move project" is already on the way. The target is 
man section 5 and FS specific packages. We already successfully moved 

 man nfs 
 man xfs
 man ext4 (ext2, ...)

All depends on FS maintainers. I'm going to support arbitrary activity 
in this area, but this does not depend on util-linux project.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52621 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754536AbbEULLg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 21 May 2015 07:11:36 -0400
Date: Thu, 21 May 2015 13:11:34 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix /sys to /dev node name translation
Message-ID: <20150521111134.GB4730@ws.net.home>
References: <555A3E16.6090003@suse.cz>
 <20150519080829.GO4834@ws.net.home>
 <555B2E2A.6000003@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <555B2E2A.6000003@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 19, 2015 at 02:35:54PM +0200, Stanislav Brabec wrote:
> Karel Zak wrote:
> >On Mon, May 18, 2015 at 09:31:34PM +0200, Stanislav Brabec wrote:
> >>linux/drivers/base/core.c: device_get_devnode() defines a translation of
> >>'!' in sysfs nodes to '/' in /dev nodes. The same translation has to be
> >>done to properly support device nodes with slash (e. g. device nodes of
> >>cciss driver and several other drivers).
> >
> >Strange feature.
> 
> It was probably introduced to support drivers that already used /dev
> sub-directories in time of introduction /sys.
> 
> >>+	/* replace '!' in the name with '/', see
> >>+	 * linux/drivers/base/core.c: device_get_devnode() */
> >>+	while ((s = strchr(name, '!')))
> >>+		s[0] = '/';
> >
> >
> >  What about to add small inline function sysfs_fix_devname() to
> >  include/sysfs.h ?
> 
> Yes, it makes sense.
> 
> Do you have an idea how to locate all parts of code that make assumptions
> basename (sysfs_block_path) == basename (dev_path).

I hope we use lib/sysfs.c code always when possible. It should be
possible to detect all /sys code by 

    git grep _PATH_SYS_

so

    disk-utils/partx.c
    lib/loopdev.c
    lib/sysfs.c
    libblkid/src/devname.c
    misc-utils/lsblk.c

 the rest is irrelevant lscpu..

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

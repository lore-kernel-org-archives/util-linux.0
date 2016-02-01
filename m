Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46241 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671AbcBAMSQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 1 Feb 2016 07:18:16 -0500
Date: Mon, 1 Feb 2016 13:18:11 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org,
        David =?utf-8?B?xaB0xJtyYmE=?= <dsterba@suse.cz>
Subject: Re: [PATCH] libmount: handle btrfs default subvolume mount
Message-ID: <20160201121811.tk3eqsr5x3w44p34@ws.net.home>
References: <569FEF38.9010102@suse.cz>
 <56A00178.9000603@suse.cz>
 <56A002B3.5090505@suse.cz>
 <20160121094833.67lg22o4la7j7pto@ws.net.home>
 <56A15487.8020500@suse.cz>
 <56AA240F.5010900@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56AA240F.5010900@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 28, 2016 at 03:22:07PM +0100, Stanislav Brabec wrote:
> Stanislav Brabec wrote:
> >Known problems not covered by this patch:
> >
> >- Use of subvolid= in fstab is not yet handled.
> 
> Patch already created, see mails:
> [PATCH 1/2] libmount: run btrfs subvol checks for "subvolid" option
> [PATCH 2/2] libmount: code re-indentation

I did some changes to the code:

 * use mnt_resolve_target() rather than mnt_resolve_spec() for target
 * move all to get_btrfs_fs_root()
 * make the basic if/else more readable

Please, please, test it.

It would be nice to have tests/ts/mount/btrfs with all the "mount -a"
variants you have in commit messages.

> >- mountinfo contains subvol and subvolid since kernel 4.2. Before kernel
> >   4.2, there is no reasonable way to solve this situation. (One would
> >   create temporary mount point, mount the default, call needed ioctl() to
> >   determine what was mounted, deduce the default subvolume, compare it
> >   with subvolume of mounted volume, unmount and return result.)
> 
> There is no reasonable way to detect whether default subvolume was mounted.
> 
> In case of mounting with subvolid, there is a way to detect subvolume path
> even before kernel 4.2: If mountinfo lookup fails, then use
> btrfs_get_default_subvolume_path(). (See my mail dated
> Thu, 21 Jan 2016 18:24:59 +0100 in this thread.) However fix is possible
> here, I have no plan to extent
> [PATCH 1/2] libmount: run btrfs subvol checks for "subvolid" option
> and implement it. It would be a fix of obscure situation in a kernel with
> unfixable issues of more common cases.

You know, perfect is the enemy of good :-)

Thanks
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

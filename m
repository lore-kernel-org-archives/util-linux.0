Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59192 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758925AbcAUPhP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 21 Jan 2016 10:37:15 -0500
Date: Thu, 21 Jan 2016 16:37:13 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org,
        David =?utf-8?B?xaB0xJtyYmE=?= <dsterba@suse.cz>
Subject: Re: [PATCH] libmount: handle btrfs default subvolume mount
Message-ID: <20160121153713.erxzeieqtnsf2wsu@ws.net.home>
References: <569FEF38.9010102@suse.cz>
 <56A00178.9000603@suse.cz>
 <56A002B3.5090505@suse.cz>
 <20160121094833.67lg22o4la7j7pto@ws.net.home>
 <56A0F847.5000000@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56A0F847.5000000@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 21, 2016 at 04:24:55PM +0100, Stanislav Brabec wrote:
> Karel Zak wrote:
> >On Wed, Jan 20, 2016 at 10:57:07PM +0100, Stanislav Brabec wrote:
> >>+/**
> >>+ * btrfs_get_default_subvol_id:
> >>+ * @path: Path to mounted btrfs volume
> >
> >this comment formatting indicate API docs, for private library functions
> >we don't use "/**".
> >
> Should I export this? I think that no.

It's private function.

> 
> Well, looking again into libbtrfs, it is also possible to use
> btrfs_list_get_default_subvolume() from libbtrfs, as is nearly exactly the
> same. But I am not sure, whether it is good to introduce such a
> dependency just for a single small function.

I really don't want to depend on libbtrfs.

> P. S.:
> 
> David also wrote btrfs_get_default_subvolume_path(), but then we found,
> that there is probably better to use subvolid and path saved in
> procinfo:

Do you mean /proc/self/mountinfo ?

> 
> + The tab.c patch would be much smaller and straightforward.
> - Kernel evaluates it when creating procinfo entries, this would
>   duplicate it.
> x Both subvol and subvolid in procinfo were introduced together in the
>   mainline kernel, and btrfs_get_default_subvolume_path() needs more
>   ioctl() calls.

No sure if I follow.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

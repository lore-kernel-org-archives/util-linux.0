Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:56857 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754077Ab1C1OX3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 28 Mar 2011 10:23:29 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 85E778765C
	for <util-linux@vger.kernel.org>; Mon, 28 Mar 2011 16:23:28 +0200 (CEST)
Subject: Re: [PATCH] umount: allow non-root umount of FUSE even if not in
 fstab
From: Miklos Szeredi <mszeredi@suse.cz>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
In-Reply-To: <20110328140454.GA4790@foxbat.suse.cz>
References: <20110328140454.GA4790@foxbat.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 28 Mar 2011 16:23:20 +0200
Message-ID: <1301322200.22846.68.camel@tucsk.pomaz.szeredi.hu>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 2011-03-28 at 16:04 +0200, Petr Uzel wrote:
> Hi all,
> 
> I hacked the following patch with which it is possible to use 
> "umount $dir" instead of "fusermount -u $dir", which IMHO is an
> improvement in usability. It seems to work (at least for me), however,
> I have to admit that I don't like it very much, because:
> - it complicates umount
> - duplicates code from fusermount

And this is not the only one that would have to be duplicated.  The
mount and umount races that were fixed in fusermount in recently and not
so recently would also have to be added to util-linux, which would
actually be a good thing, since in theory they could affect fstab based
user mounts as well (though that is much more unlikely than with fuse,
where the user chooses the mountpoint).


> - should (???) be implemented using umount helpers

The end goal is to implement permission checking for unprivileged mount
and umount in the kernel.

Thanks,
Miklos



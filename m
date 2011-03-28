Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55661 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753517Ab1C1WDp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 28 Mar 2011 18:03:45 -0400
Date: Tue, 29 Mar 2011 00:03:44 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>, Miklos Szeredi <mszeredi@suse.cz>
Subject: Re: [PATCH] umount: allow non-root umount of FUSE even if not in
	fstab
Message-ID: <20110328220344.GQ21093@nb.net.home>
References: <20110328140454.GA4790@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110328140454.GA4790@foxbat.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 28, 2011 at 04:04:56PM +0200, Petr Uzel wrote:
> I have to admit that I don't like it very much, because:

I don't like it too :-)

> - it complicates umount
> - duplicates code from fusermount
> - should (???) be implemented using umount helpers

[...]

> +		/* If this is fuse-based filesystem, allow user unmount even
> +		 * if the FS is not in fstab.
> +		 *
> +		 * Based on fusermount code. */
> +		if (strcmp(mc->m.mnt_type, "fuse") == 0 ||
> +		    strcmp(mc->m.mnt_type, "fuseblk") == 0 ||
> +		    strncmp(mc->m.mnt_type, "fuse.", 5) == 0 ||
> +		    strncmp(mc->m.mnt_type, "fuseblk.", 8) == 0) {

Wouldn't be better to always call /sbin/umount.fuse for non-roots (except
umount -i)? 

I believe more and more that we need something like

    /etc/mount.d/{fuse,foo,...}.conf

where we can define such behavior for some filesystems.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

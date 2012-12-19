Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36087 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753379Ab2LSNyl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 19 Dec 2012 08:54:41 -0500
Date: Wed, 19 Dec 2012 14:54:30 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 14/14] docs: fsck(8), mkfs(8): update manual references
Message-ID: <20121219135430.GD17959@x2.net.home>
References: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
 <1355654642-22106-15-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1355654642-22106-15-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 16, 2012 at 10:44:02AM +0000, Sami Kerola wrote:
>  .SH SEE ALSO
>  .BR fstab (5),
>  .BR mkfs (8),
> -.BR fsck.ext2 (8)
> -or
> -.BR fsck.ext3 (8)
> -or
>  .BR e2fsck (8),
> -.BR cramfsck (8),
> -.BR fsck.minix (8),
> -.BR fsck.msdos (8),
> +.BR e2fsck.conf (5),
> +.BR jfs_fsck (8),
> +.BR jfs_fscklog (8),

 Everything other than fsck.<type> (mkfs.<type>, mount.<type>) is
 wrong and invisible for the regular system tools.

 The question is if we really need the references to the filesystem
 specific fsck man pages (the list of supported filesystems is disto
 specific) ... why jfs, why not xfs, etc.
 
 Maybe it would be better to add a note that "description for the
 filesystem specific fsck programs is possible to found in
 fsck.<type>(8) man pages where <type> is filesystem name".

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

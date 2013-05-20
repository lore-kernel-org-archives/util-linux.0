Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35577 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754474Ab3ETHkK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 20 May 2013 03:40:10 -0400
Date: Mon, 20 May 2013 09:40:01 +0200
From: Karel Zak <kzak@redhat.com>
To: Linda Walsh <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Subject: Re: mount --no-canonical seems broken.
Message-ID: <20130520074001.GE16493@x2.net.home>
References: <5175BA15.9060803@tlinx.org>
 <20130423123648.GB24501@x2.net.home>
 <517729C7.2030806@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <517729C7.2030806@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 23, 2013 at 05:39:35PM -0700, Linda Walsh wrote:
>     Well my main concern has been how lvm volumes are renamed.
> 
> i.e. /dev/Vol-group/Log-vol ->
> /dev/mapper/Vol--group-Log--vol

The /dev/mapper/<name> is the canonical name, this is only
user-friendly name that is possible to generate by utils in userspace,
because the <name> is exported by /sys/block/dm-<n>/dm/name to
userspace. 

Things like /dev/Vol-group/Log-vol are LVM specific and
there is no way how to convert /dev/dm-<n> to this format. This is
reason why mount(8) canonicalizes the names to /dev/mapper/<name>.

> I have backup and file-system utils that use the values in fstab, and it
> looks for those values in the output of mount (and df).

The ideal solution is to use utils which are able to convert
symlinks/tags/whatever to canonical device names. It's mistake to
assume that fstab matches with /proc/mounts.

Use
    $ findmnt --fstab --canonicalize --evaluate

to get canonical paths and evaluated tags.

> I've been using the mount --no-canonicalize to mount my lvm volumes --
> and also going back and doing the "mount -f --nocanonicalize ..." to get the
> ones mounted at boot time.

> Recently it was changed back to a symlink and on top of that -- whether
> it is a file or a symlink, mount doesn't seem to show the "non-canon" name
> (i.e. /dev/Vol/Log...)
> (though oddly enough -- "df" does!)...

The problem is that "mount" (without options) prints always canonicalized 
paths (and in this case --no-canonicalize has no effect, this option
is used for mounting only). It means if you have non-canonical paths
in /etc/mtab then "mount" still prints canonical paths. I can fix it
and make the output sensitive to --no-canonicalize option too.

Anyway, use findmnt, it provides but complete control on the output.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

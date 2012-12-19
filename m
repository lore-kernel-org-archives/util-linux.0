Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:9841 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755101Ab2LSO3Q (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 19 Dec 2012 09:29:16 -0500
Date: Wed, 19 Dec 2012 15:29:05 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [00/14]: pull: ipcs resubmission, bug fixes, minix todo, etc
Message-ID: <20121219142905.GE17959@x2.net.home>
References: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 16, 2012 at 10:43:48AM +0000, Sami Kerola wrote:
> This review / pull request is partial resubmission.  The ipc stuff was
> sent to list earlier, but it got to be modified after initial review so
> here comes the modified version.
> 
> In these patches there are two documentation bug fixes (0001, 0005), and
> one code bug fix (0013).  There is also one policy change (0008), which
> makes tunelp not to be part of default build.  My feeling is that the
> utility is not much in use.  Please correct if I am wrong, and drop the
> patch.

 That's probably good idea, --enable-tunelp should be enough.

>       docs: swapon.8 option name fix

 This reminds me, what about to use "swapon --show" by default if no
 option is specified? Now "swapon" prints help...

 We did the same change for "losetup", if nothing is requested then
 it prints the list of the loop devices.

>       ipcs: assist debugging
>       ipcs: add --human readable size conversion option

 I have aligned the "size" columns to the right. It's more readable.

>       ipcs: add --bytes size output option
>       isosize: fix usage() -h option print out
>       isosize: inform if file does not look like iso file system
>       more: remove unnecessary variable
>       tunelp: deprecation: remove command from default build
>       minix: change types in header file
>       minix: use off_t, size_t, etc appropriate types
>       minix: replace magic constants with macro names
>       docs: add missing exit value to fsck.minix(8)
>       lib/ismounted: detect loopback mounts

applied

>       docs: fsck(8), mkfs(8): update manual references

not applied

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

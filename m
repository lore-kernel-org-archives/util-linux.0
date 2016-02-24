Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:59143 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751866AbcBXOu2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 24 Feb 2016 09:50:28 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: rc1 planning
Date: Wed, 24 Feb 2016 15:50:21 +0100
Cc: util-linux@vger.kernel.org
References: <20160224125641.kw2t37ofjhmealej@ws.net.home>
In-Reply-To: <20160224125641.kw2t37ofjhmealej@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201602241550.21863.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 24 February 2016, Karel Zak wrote:
>  Hi,
>
>  I'd like to release v2.28-rc1 ASAP, but the rest of this week and
> all next week I have vacation (and all next week I'm going to be
> off-line somewhere in Atlantic). So, my plan is 7th or 8th March.
>
>  remaining issues:
>
>   * btrfs loop devs in libmount
>
>   * libblkid vs. CDROMs (check if last two 2K sectors are readable,
> if not reduce probing area)    [me]
>
>   * add time formatting functions for ISO and ctime [not urgent]
>
>   * cleanup openat() related function [not urgent, Rudi?]

I've changed my mind a bit about lib/at.c removal because it's used by 
sysfs.c and we would lose libblkid and fdisk on non-linux systems. I 
will review first whether we could build libblkid without sysfs for 
non-Linux.

Regarding my stupid commit ...
  8b9cf26a "lib: fix unused parameters and variables"
... next time I would try to add our new "NO_UNUSED_WARN_CFLAGS" just 
for single source files. Not using __unused macros would keep our 
heavily ifdef'ed sources more readable.

>   * add --zeroout to blkdiscard [me]
>
>   * fix look(1) [https://github.com/karelzak/util-linux/issues/284]
>
>   * cleanup docs, gtk-doc warnings, etc.

My favorite warning one could fix is this one:

Making all in libblkid/docs
make[2]: Entering directory `/home/rudi/devel/util-linux/libblkid/docs'
make[2]: Circular libblkid-sections.txt <- scan-build.stamp dependency 
dropped.

>   * ???
>
>
>     Karel

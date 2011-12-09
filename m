Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:61310 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753402Ab1LINBa (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 9 Dec 2011 08:01:30 -0500
Date: Fri, 9 Dec 2011 14:01:28 +0100
From: Karel Zak <kzak@redhat.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: util-linux@vger.kernel.org
Subject: Re: Mount -a and bind mounts. Bug?
Message-ID: <20111209130128.GC7960@nb.net.home>
References: <20111209123357.GA3173@golden.localdomain> <20111209124837.GA7960@nb.net.home> <20111209125537.GC3173@golden.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111209125537.GC3173@golden.localdomain>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 09, 2011 at 12:55:37PM +0000, Andrew Walrond wrote:
> On Fri, Dec 09, 2011 at 01:48:37PM +0100, Karel Zak wrote:
> >  - distro?
> 
> A custom job of my own
> 
> >  - linked with libmount?
> 
> Don't think so.
> 
> $ ldd /bin/mount
>         linux-vdso.so.1 =>  (0x00007fff093af000)
>         libblkid.so.1 => //lib/libblkid.so.1 (0x00007f087b755000)
>         libuuid.so.1 => //lib/libuuid.so.1 (0x00007f087b551000)
>         libc.so.6 => //lib/libc.so.6 (0x00007f087b1ca000)
>         /lib64/ld-linux-x86-64.so.2 => //lib64/ld-linux-x86-64.so.2 (0x00007f087b97b000)
> 
> Saw some mention of libmount somewhere when I upgraded and built 2.20.1 but didn't have time to read further.
> What's the current recommendation? Should I link against it?
> 
> >  - do you have regular mtab or symlink to /proc/mounts
> 
> symlink to /proc/mounts

 ... okay then it's expected behavior. The file /proc/mounts does not
 provide enough information about bind mounts. You need regular mtab
 or link with libmount (the library reads /proc/self/mountinfo and
 does some horrible voodoo to detect already mounted bind mounts).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

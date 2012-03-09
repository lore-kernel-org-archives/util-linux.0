Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56082 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752308Ab2CIKxI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 9 Mar 2012 05:53:08 -0500
Date: Fri, 9 Mar 2012 11:53:04 +0100
From: Karel Zak <kzak@redhat.com>
To: Matt Burgess <matthew@linuxfromscratch.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: mount -f regression in v2.21's new-mount
Message-ID: <20120309105304.GF17711@x2.net.home>
References: <1331073821.1882.16.camel@kyoto.localdomain>
 <20120307074933.GE8389@x2.net.home>
 <1331158201.1910.1.camel@kyoto.localdomain>
 <20120308092342.GC28628@x2.net.home>
 <1331238300.1875.2.camel@kyoto.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331238300.1875.2.camel@kyoto.localdomain>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 08, 2012 at 08:25:00PM +0000, Matt Burgess wrote:
> I've attached LIBMOUNT_DEBUG output from the 'mount -a' call that our
> bootscript does.  Note how mount correctly detects that /proc, /sys

 No, it calls mount(2) syscall for /proc. The problem is that the
 detection code expects /proc/self/mountinfo (used on systems with
 mtab -> /proc/mounts symlink), but your system uses regular mtab.

 I'll fix it. Thanks.

    Karel

> 239: libmount:      CXT: [0x184f060]: mount(2) [source=proc, target=/proc, type=proc,  mountflags=0xc0ed000e, mountdata=<none>]
> 239: libmount:      CXT: [0x184f060]: mount(2) failed [errno=16 Device or resource busy]
> mount: proc is already mounted or /proc busy
>        proc is already mounted on /proc


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

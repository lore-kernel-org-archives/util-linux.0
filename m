Return-Path: d@falconindy.com
Date: Sat, 22 Dec 2012 23:33:42 -0500
From: Dave Reisner <d@falconindy.com>
To: Karel Zak <kzak@redhat.com>
Cc: Werner Fink <werner@suse.de>, util-linux@vger.kernel.org
Subject: Re: [PATCH 4/5] sulogin: mount temporary /dev and /proc if not found
Message-ID: <20121223043342.GA633@rampage>
References: <20121207170118.GG603@rampage>
 <1355142431-8199-1-git-send-email-werner@suse.de>
 <20121218152311.GA13554@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121218152311.GA13554@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

On Tue, Dec 18, 2012 at 04:23:11PM +0100, Karel Zak wrote:
> On Mon, Dec 10, 2012 at 01:27:10PM +0100, Werner Fink wrote:
> >  configure.ac   |   10 +++++++++
> >  lib/consoles.c |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 76 insertions(+)
> 
>  Note that I have applied this (fixed) version of the patch.
> 
>     Karel
> 

This is pretty broken. Using the constructor and destructor attributes
means that ANY programs linking in the code will invoke these functions.
As it's not a direct inclusion, but part of a libtool convenience lib,
the effect is pretty severe:

$ git grep -F libcommon.la | wc -l
78

This includes things such as libblkid and libmount, among others.

It wouldn't generally matter (though I'm still in favor of finding
another solution for this), but this breaks early userspace pretty hard.
Invoking mount (or even findmnt) will preemptively run this code. I'm
not clear on why, but the filesystems were NOT umounted by the
destructor, and my busybox umount as well as util-linux's switch_root
simply failed with EINVAL.

I suggest that this code be relegated to sulogin.

d

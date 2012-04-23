Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:12519 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752239Ab2DWL1g (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 23 Apr 2012 07:27:36 -0400
Date: Mon, 23 Apr 2012 13:27:31 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] Fix typos found by misspellings
Message-ID: <20120423112731.GH11847@x2.net.home>
References: <4F90908A.1010401@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F90908A.1010401@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Apr 20, 2012 at 12:24:10AM +0200, Bernhard Voelker wrote:
> On the coreutils mailing list, there was recently a patch
> for fixing common typos identified by misspellings:
> http://lists.gnu.org/archive/html/coreutils/2012-04/msg00056.html
> 
> I ran that nice tool against U-L and fixed all but the following typos:

 Good work! It would be nice to check the comments and docs always after
 -rc1 release (and before -rc2).

>   Documentation/releases/v2.13-ReleaseNotes[195]: lenght -> "length"
>   Documentation/releases/v2.19-ReleaseNotes[321]: managment -> "management"
>   Documentation/releases/v2.19-ReleaseNotes[326]: managment -> "management"
>   Documentation/releases/v2.20-ReleaseNotes[340]: exmaple -> "example"
>   Documentation/releases/v2.21-ReleaseNotes[753]: lenght -> "length"
>   NEWS[210]: doesnt -> "doesn't"
>   NEWS[1291]: necesarily -> "necessarily"
> 
> They are all in old changelogs - are these frozen or also to be changed?

 I think we can change it, frozen is FTP and git history, but not the
 current source tree.

>   disk-utils/blockdev.c[289]: larg -> "large"
>   disk-utils/blockdev.c[350]: larg -> "large"
>   fdisk/sfdisk.c[1284]: ect -> "etc"
> 
> These are variable names.

 Please, ignore variable names. (for example, larg means "long arg")

>  Documentation/TODO                     |    2 +-
>  Documentation/poeigl.txt               |    2 +-
>  Documentation/release-schedule.txt     |    2 +-
>  config/texinfo.tex                     |    4 ++--
>  configure.ac                           |    2 +-
>  disk-utils/isosize.c                   |    2 +-
>  fdisk/fdisk.8                          |    2 +-
>  fdisk/fdisk.c                          |    2 +-
>  getopt/getopt.c                        |    4 ++--
>  hwclock/cmos.c                         |    4 ++--
>  hwclock/hwclock.c                      |    2 +-
>  lib/strutils.c                         |    2 +-
>  libblkid/libblkid.3                    |    2 +-
>  libblkid/src/encode.c                  |    2 +-
>  libblkid/src/partitions/gpt.c          |    4 ++--
>  libblkid/src/partitions/partitions.c   |    2 +-
>  libblkid/src/superblocks/linux_raid.c  |    4 ++--
>  libblkid/src/superblocks/superblocks.c |    4 ++--
>  libmount/src/context.c                 |    2 +-
>  libmount/src/context_mount.c           |    4 ++--
>  libmount/src/context_umount.c          |    4 ++--
>  login-utils/login.c                    |    2 +-
>  misc-utils/blkid.8                     |    2 +-
>  misc-utils/blkid.c                     |    2 +-
>  mount/mount.8                          |    2 +-
>  sys-utils/dmesg.c                      |    2 +-
>  sys-utils/ipcs.c                       |    2 +-
>  sys-utils/lscpu.c                      |    2 +-
>  sys-utils/mount.8                      |    2 +-
>  tests/ts/lscpu/mk-input.sh             |    2 +-
>  text-utils/more.c                      |    4 ++--
>  text-utils/ul.c                        |    2 +-
>  32 files changed, 41 insertions(+), 41 deletions(-)

 Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

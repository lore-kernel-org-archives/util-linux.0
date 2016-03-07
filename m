Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41056 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752180AbcCGMnU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Mar 2016 07:43:20 -0500
Date: Mon, 7 Mar 2016 13:43:18 +0100
From: Karel Zak <kzak@redhat.com>
To: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] snprintf: safer (and uniform) handling of return
 value
Message-ID: <20160307124318.l4vhkq5vnohjn2m7@ws.net.home>
References: <m3r3fymc4d.fsf@gmail.com>
 <m3mvqmm8p7.fsf@gmail.com>
 <m3io1am83y.fsf_-_@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m3io1am83y.fsf_-_@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Feb 27, 2016 at 07:27:29PM +0300, Yuriy M. Kaminskiy wrote:
> From aa9e84c4c9a7e35e76a4856de98c73c12318fa44 Mon Sep 17 00:00:00 2001
> From: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
> Date: Fri, 26 Feb 2016 16:05:29 +0300
> Subject: [PATCH 3/3] snprintf: safer (and uniform) handling of return value
> 
> When `rc` is `INT_MAX`, `rc + 1` result in signed integer overflow.
> ---
> Note: likely impossible to trigger, so this only fixes "formal correctness".
> 
>  disk-utils/fsck.c      |  2 +-
>  lib/at.c               |  6 +++---
>  lib/cpuset.c           |  7 ++-----
>  lib/sysfs.c            | 12 ++++++------
>  libfdisk/src/ask.c     |  8 ++------
>  login-utils/login.c    |  2 +-
>  login-utils/lslogins.c |  2 +-
>  misc-utils/cal.c       |  7 ++++++-
>  sys-utils/lscpu.c      |  8 ++++++--
>  sys-utils/mountpoint.c |  2 +-
>  term-utils/agetty.c    |  4 ++--
>  term-utils/ttymsg.c    |  8 ++++----
>  term-utils/wall.c      |  4 ++--
>  13 files changed, 37 insertions(+), 35 deletions(-)
> 
> diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
> index 83053cd..f859055 100644
> --- a/disk-utils/fsck.c
> +++ b/disk-utils/fsck.c
> @@ -316,7 +316,7 @@ static int is_irrotational_disk(dev_t disk)
>  			"/sys/dev/block/%d:%d/queue/rotational",
>  			major(disk), minor(disk));
>  
> -	if (rc < 0 || (unsigned int) (rc + 1) > sizeof(path))
> +	if (rc < 0 || (unsigned int) rc >= sizeof(path))

Yes, good catch. It's always painful if a return code is possible to
interpret by more ways. Maybe we can introduce some macro to test the
result:

  if (is_snprintf_error(rc, sizeof(path)))

to make it more readable and to avoid creativity in code ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

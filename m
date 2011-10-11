Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:31656 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753276Ab1JKIw6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 11 Oct 2011 04:52:58 -0400
Date: Tue, 11 Oct 2011 10:52:51 +0200
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <d@falconindy.com>
Cc: util-linux@vger.kernel.org, Dave Reisner <dreisner@archlinux.org>
Subject: Re: [PATCH 2/2] mountpoint: fallback on stat when /proc isn't
	mounted
Message-ID: <20111011085251.GI11730@nb.net.home>
References: <1318131111-30395-1-git-send-email-dreisner@archlinux.org> <1318131111-30395-2-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318131111-30395-2-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Oct 08, 2011 at 11:31:51PM -0400, Dave Reisner wrote:
> mountpoint will fail when /proc isn't available, which lessens its
> usefulness as a tool to detect mountpoints. In this case, mimic what
> sysvinit's mountpoint tool does and compare the device and inode values
> of root and specified target.
> 
> Signed-off-by: Dave Reisner <dreisner@archlinux.org>
> ---
> Rationale: I think this patch is especially important for folks who are still
> using sysvinit. Particularly in the case of a user not having an initramfs, the
> userspace initscripts need to be able to detect, without fail, the presence of
> /proc, /sys, and /dev being mounted (and mount them when they aren't). While
> checking for /proc first and mounting it when mountpoint returns failure will
> result in the correct action, it's reliant on broken behavior -- that is,
> mountpoint returned false because /proc isn't mounted, not because /proc isn't
> a mountpoint.

 Good point.

>  sys-utils/mountpoint.c |   15 +++++++++++++--
>  1 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/sys-utils/mountpoint.c b/sys-utils/mountpoint.c
> index 065d96b..1297d82 100644
> --- a/sys-utils/mountpoint.c
> +++ b/sys-utils/mountpoint.c
> @@ -46,8 +46,19 @@ static dev_t dir_to_device(const char *spec)
>  	struct libmnt_fs *fs;
>  	dev_t res = (dev_t)-1;
>  
> -	if (!tb)
> -		return (dev_t)-1;
> +	if (!tb) {
> +		struct stat root_st, spec_st;
> +
> +		/* fallback on using stat when /proc isn't available. return success when
> +		 * we're examining different devices or encounter an exact match for the
> +		 * root device */
> +		if (stat(spec, &spec_st) == 0 && stat("/", &root_st) == 0 &&
> +				root_st.st_dev != spec_st.st_dev ||
> +				(root_st.st_dev == spec_st.st_dev && root_st.st_ino == spec_st.st_ino))

 Hmm ... && ... || ..., you forgot brackets here  ;-)

 Anyway, this is very poor solution. The tradition way how to detect
 mountpoint is compare "/path" and /path/.."

 Fixed, applied.
    
        Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

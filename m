Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51920 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753357AbbDMK1H (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 Apr 2015 06:27:07 -0400
Date: Mon, 13 Apr 2015 12:27:05 +0200
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] fsck: drop hardcoded search path
Message-ID: <20150413102705.GN3923@ws.net.home>
References: <1428829613-30423-1-git-send-email-vapier@gentoo.org>
 <1428829613-30423-3-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428829613-30423-3-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 12, 2015 at 05:06:53AM -0400, Mike Frysinger wrote:
> We also drop the hardcoded minimal list of filesystem types that we
> "really want" to check.  Instead, we blindly execute the fsck.<type>
> program whenever it's been requested.

 This change makes fsck.<type> required for all filesystem, so it
 breaks boot on many systems... Now fsck.<type> is optional for many
 fs types (e.g. btrfs, xfs, ...).

> @@ -888,18 +838,8 @@ static int fsck_device(struct libmnt_fs *fs, int interactive)
>  	else
>  		type = DEFAULT_FSTYPE;
>  
> -	sprintf(progname, "fsck.%s", type);
> -	progpath = find_fsck(progname);
> -	if (progpath == NULL) {
> -		if (fs_check_required(type)) {
> -			retval = ENOENT;
> -			goto err;
> -		}
> -		return 0;
> -	}

 This is important detail.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

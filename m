Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:11477 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754519AbaDGKNG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Apr 2014 06:13:06 -0400
Date: Mon, 7 Apr 2014 12:12:58 +0200
From: Karel Zak <kzak@redhat.com>
To: Patrick McLean <chutzpah@gentoo.org>
Cc: util-linux@vger.kernel.org
Subject: Re: mount: "nofail" option does not seem to work as expected
Message-ID: <20140407101258.GG22126@x2.net.home>
References: <20140324154426.0e5d2781@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140324154426.0e5d2781@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 24, 2014 at 03:44:26PM -0700, Patrick McLean wrote:
> First the "nofail" doesn't actually prevent "failure" when using "mount
> -a". If any filesystem fails to mount with mount -a due to the device
> not existing, even if "nofail" is specified in the mount, mount will
> exit with a status of 32. I would expect that "nofail" would imply that
> such failures would cause the exit status to be 0.
> 
> Also, it seems that the "nofail" mount option does not work at all when
> using the tag-style partition identifiers rather than udev symlinks.
> 
> Using this line in fstab:
> UUID=nonexist /mnt/nonexist1 ext4 nofail 0 1
> 
> Will produce an error message:
> # mount -av
> mount: can't find UUID=nonexist
> #
> 
> Where this line:
> /dev/disk/by-uuid/nonexist /mnt/nonexist ext4 nofail 0 1
> 
> Does not produce any error:
> # mount -av

 Excellent catch, thanks!

 Fixed and will be in v2.24.2.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1677 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755966Ab3DWMgw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 23 Apr 2013 08:36:52 -0400
Date: Tue, 23 Apr 2013 14:36:48 +0200
From: Karel Zak <kzak@redhat.com>
To: Linda Walsh <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Subject: Re: mount --no-canonical seems broken.
Message-ID: <20130423123648.GB24501@x2.net.home>
References: <5175BA15.9060803@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5175BA15.9060803@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Apr 22, 2013 at 03:30:45PM -0700, Linda Walsh wrote:
> 
> I would use mount --no-canonical to rewrite mtab to match fstab so
> 
> my utils could find volumes in /etc/fstab -- but recently in
> util-linux-2.21.2
> this has no longer worked.
> 
> I made sure to have /etc/mtab NOT be a symlink to /proc/self/mounts so
> mount could write to it.  It DOES write to it, but it doesn't display it.
> 
> Example:
> After doing a remount as recommended by the manpage...
> 
>     mount -f --no-canonical -a -o remount

 Well, --no-canonicalize assume that all paths are already
 canonicalized and the remount updates mount options only.


 What exactly do you want to do? Maybe we can try to find a better
 solution than play nasty games with mtab ;-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

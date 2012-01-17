Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44437 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752481Ab2AQKOg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Jan 2012 05:14:36 -0500
Date: Tue, 17 Jan 2012 11:14:29 +0100
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <d@falconindy.com>
Cc: util-linux@vger.kernel.org, Dave Reisner <dreisner@archlinux.org>
Subject: Re: [PATCH] mount: avoid canonicalizing pseudofs paths
Message-ID: <20120117101429.GB12310@x2.net.home>
References: <1326763075-11690-1-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326763075-11690-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 16, 2012 at 08:17:55PM -0500, Dave Reisner wrote:
> This fixes a display bug in the new mount wherein a psuedofs existing in
> $PWD by name will be resolved and shown as a real mount point.

 Cool, we really need to test the code.

>   $ cd /tmp; mkdir nfsd; mount | grep nfsd
>   /tmp/nfsd on /proc/fs/nfsd type nfsd (rw,relatime)
> 
> Signed-off-by: Dave Reisner <dreisner@archlinux.org>
> ---
>  sys-utils/mount.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49210 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549AbbKII6u (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 9 Nov 2015 03:58:50 -0500
Date: Mon, 9 Nov 2015 09:58:48 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/12] pull: race fixes
Message-ID: <20151109085848.GR19508@ws.net.home>
References: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Oct 31, 2015 at 07:21:12PM +0000, Sami Kerola wrote:
>   login: fix stat(2) race
>   swapon: fix stat(3) and open(3) race
>   fsck: retire stat(3) when access(3) does better job
>   agetty: fix chown(3), chmod(3) and open(3) race
>   script, hwclock: check file exist with access(3) rather than stat(3)

 Applied, thanks.

>   lib/fileutils: add is_same_inode() check
>   include/blkdev: add open_blkdev_or_file() function
>   mkfs.bfs: fix block device open race
>   mkfs.minix: fix block device open race
>   mkswap: fix block device open race
>   mesg: fix multiple races
>   fdformat: fix block device open race

 Here I don't like the pattern

  open_blkdev_or_file()
  fstat()

 IMHO it would be enough to use is_same_inode() to avoid race.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

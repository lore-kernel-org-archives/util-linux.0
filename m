Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34018 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570AbaF3Iqh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 30 Jun 2014 04:46:37 -0400
Date: Mon, 30 Jun 2014 10:46:26 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] swapon: align --summary fields
Message-ID: <20140630084626.GE750@x2.net.home>
References: <1404065533-7557-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404065533-7557-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 29, 2014 at 07:12:13PM +0100, Sami Kerola wrote:
> This commit makes  partitions and files to have remaining three columns
> aligned.  Below print out demonstrates earlier misalignment.
> 
> $ swapon -s
> Filename                                Type            Size    Used    Priority
> /dev/sda2                               partition       4194300 0       3
> /home/src/util-linux/newswap            file    496     0       -1
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  sys-utils/swapon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

 Applied, thanks.

 Maybe we can mark the --summary output format deprecated in favour of
 --show. The old fixed output sucks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

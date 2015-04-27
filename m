Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40980 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752696AbbD0I1e (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 27 Apr 2015 04:27:34 -0400
Date: Mon, 27 Apr 2015 10:27:29 +0200
From: Karel Zak <kzak@redhat.com>
To: Alexey Galakhov <agalakhov@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] hwclock: flush stdout in hwclock -c
Message-ID: <20150427082729.GK27969@ws.net.home>
References: <1429197987-8751-1-git-send-email-agalakhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1429197987-8751-1-git-send-email-agalakhov@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 16, 2015 at 05:26:27PM +0200, Alexey Galakhov wrote:
> This allows using hwclock -c in automated test scripts that parse
> its output line-by-line. The standard output is flushed before
> each 10 second delay.
> 
> Signed-off-by: Alexey Galakhov <agalakhov@gmail.com>
> ---
>  sys-utils/hwclock.c | 1 +
>  1 file changed, 1 insertion(+)

 Applied, thanks. We will see shat happen in future...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

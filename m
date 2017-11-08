Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751826AbdKHLcN (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 8 Nov 2017 06:32:13 -0500
Date: Wed, 8 Nov 2017 12:32:09 +0100
From: Karel Zak <kzak@redhat.com>
To: Joshua Watt <jpewhacker@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount: Allow MNT_FORCE and MNT_DETACH at umount
Message-ID: <20171108113209.ri3smegy6ym5eus4@ws.net.home>
References: <20171106222536.9806-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171106222536.9806-1-JPEWhacker@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 06, 2017 at 04:25:36PM -0600, Joshua Watt wrote:
> MNT_FORCE and MNT_DETACH are orthogonal in the Linux kernel, so both may
> be specified without any problems. Even if there were a problem with
> this combination, it should be up to the kernel to take the correct
> action or report an error.
> 
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  libmount/src/context_umount.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

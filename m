Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35424 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065Ab3AXPfU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 24 Jan 2013 10:35:20 -0500
Date: Thu, 24 Jan 2013 16:35:06 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/4] include: add missing values to sysfs_cxt initializer
 definition
Message-ID: <20130124153506.GC27413@x2.net.home>
References: <1357760216-4068-1-git-send-email-kerolasa@iki.fi>
 <1357760216-4068-4-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357760216-4068-4-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 09, 2013 at 07:36:56PM +0000, Sami Kerola wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  include/sysfs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/sysfs.h b/include/sysfs.h
> index 4f9c46b..739f9de 100644
> --- a/include/sysfs.h
> +++ b/include/sysfs.h
> @@ -30,7 +30,7 @@ struct sysfs_cxt {
>  	unsigned int	has_hctl : 1;
>  };
>  
> -#define UL_SYSFSCXT_EMPTY { 0, -1, NULL, NULL }
> +#define UL_SYSFSCXT_EMPTY { 0, -1, NULL, NULL, 0, 0, 0, 0, 0 }

 Applied, but it's very probably unnecessary. All unspecified fields
 should be zeroized according to the standard.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

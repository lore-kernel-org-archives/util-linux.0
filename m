Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:8243 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027Ab3GHICY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 8 Jul 2013 04:02:24 -0400
Date: Mon, 8 Jul 2013 10:02:11 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 13/34] libmount: fix memory leak [clang-analyzer]
Message-ID: <20130708080211.GA11126@x2.net.home>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
 <1373226889-3451-14-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1373226889-3451-14-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 07, 2013 at 08:54:28PM +0100, Sami Kerola wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  libmount/src/utils.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/libmount/src/utils.c b/libmount/src/utils.c
> index 1655764..7714b50 100644
> --- a/libmount/src/utils.c
> +++ b/libmount/src/utils.c
> @@ -198,6 +198,7 @@ int mnt_chdir_to_parent(const char *target, char **filename)
>  		else
>  			memcpy(*filename, last, strlen(last) + 1);
>  	}
    else

> +	free(buf);
>  	return 0;

 Please, read the code and don't blindly follow analyzers.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

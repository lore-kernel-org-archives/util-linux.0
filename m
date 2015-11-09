Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35288 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751275AbbKIIyW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 9 Nov 2015 03:54:22 -0500
Date: Mon, 9 Nov 2015 09:54:17 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 06/12] lib/fileutils: add is_same_inode() check
Message-ID: <20151109085417.GQ19508@ws.net.home>
References: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
 <1446319284-24778-7-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446319284-24778-7-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Oct 31, 2015 at 07:21:18PM +0000, Sami Kerola wrote:
> Check if a file path and descriptor are indeed the same file.  This function
> is needed for TACTOU avoidance.
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  include/fileutils.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/fileutils.h b/include/fileutils.h
> index be6d1f7..55df1a7 100644
> --- a/include/fileutils.h
> +++ b/include/fileutils.h
> @@ -4,6 +4,7 @@
>  #include <stdio.h>
>  #include <fcntl.h>
>  #include <unistd.h>
> +#include <sys/stat.h>
>  
>  #include "c.h"
>  
> @@ -25,6 +26,19 @@ static inline FILE *xfmkstemp(char **tmpname, const char *dir, const char *prefi
>  	return ret;
>  }
>  
> +static inline int is_same_inode(const int fd, const char *path)
> +{
> +	struct stat f, p;
> +
> +	if (fstat(fd, &f) < 0)
> +		return 0;
> +	if (stat(path, &p) < 0)
> +		return 0;
> +	if (f.st_dev != p.st_dev || f.st_ino != p.st_ino)
> +		return 0;
> +	return 1;
> +}

Maybe don't call fstat() here and use 

    static inline int is_same_inode(struct stat st, const char *path)

than you reduce stat() calls on many places...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mail3.vodafone.ie ([213.233.128.45]:60312 "EHLO
	mail3.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727Ab3IIDdf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 Sep 2013 23:33:35 -0400
Message-ID: <522D3F3F.3090509@draigBrady.com>
Date: Mon, 09 Sep 2013 04:23:43 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Sami Kerola <kerolasa@iki.fi>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/4] lib/fileutils: advice there is no point caching temporary
 files
References: <1378656549-3729-1-git-send-email-kerolasa@iki.fi> <1378656549-3729-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1378656549-3729-3-git-send-email-kerolasa@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 09/08/2013 05:09 PM, Sami Kerola wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  lib/fileutils.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/lib/fileutils.c b/lib/fileutils.c
> index 92b474c..23cf80c 100644
> --- a/lib/fileutils.c
> +++ b/lib/fileutils.c
> @@ -8,6 +8,7 @@
>  #include <unistd.h>
>  #include <sys/time.h>
>  #include <sys/resource.h>
> +#include <fcntl.h>
>  
>  #include "c.h"
>  #include "fileutils.h"
> @@ -43,6 +44,9 @@ int xmkstemp(char **tmpname, char *dir)
>  		free(localtmp);
>  		localtmp = NULL;
>  	}
> +#ifdef POSIX_FADV_NOREUSE
> +	posix_fadvise(fd, 0, lseek(fd, 0, 0), POSIX_FADV_NOREUSE);
> +#endif
>  	*tmpname = localtmp;
>  	return fd;
>  }
> 

I don't follow. The above is saying to NOREUSE the data
from the start to the current position?
But won't the file be empty and the current position == 0 here?
Also POSIX_FADV_NOREUSE currently does nothing in the kernel.
There is POSIX_FADV_DONTNEED to drop the file (range) from cache.
But I'm not sure that's appropriate or needed for all temp files?
Note also DONTNEED is auto done when a file is unlinked.

cheers,
Pádraig.


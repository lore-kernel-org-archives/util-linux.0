Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36286 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752965AbcLFPBd (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 6 Dec 2016 10:01:33 -0500
Date: Tue, 6 Dec 2016 16:01:31 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 01/11] last: include libgen.h for basename(3p)
Message-ID: <20161206150131.twqbvpl7oqvhkddt@ws.net.home>
References: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de>
 <1480582332-17407-2-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1480582332-17407-2-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Dec 01, 2016 at 09:52:04AM +0100, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> 
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  login-utils/last.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/login-utils/last.c b/login-utils/last.c
> index 6d0e892..90eee68 100644
> --- a/login-utils/last.c
> +++ b/login-utils/last.c
> @@ -40,6 +40,7 @@
>  #include <netinet/in.h>
>  #include <netdb.h>
>  #include <arpa/inet.h>
> +#include <libgen.h>
>  
>  #include "c.h"
>  #include "nls.h"
> @@ -877,7 +878,11 @@ static void process_wtmp_file(const struct last_control *ctl,
>  		}
>  	}
>  
> -	printf(_("\n%s begins %s"), basename(filename), ctime(&begintime));
> +	{
> +		char* tmp = xstrdup(filename);
> +		printf(_("\n%s begins %s"), basename(tmp), ctime(&begintime));
> +		free(tmp);

 This seems like pretty common pattern, what about to introduce
 xbasename(filename, &tmp)?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

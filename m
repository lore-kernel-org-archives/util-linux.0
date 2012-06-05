Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56085 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934105Ab2FEN1T (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 5 Jun 2012 09:27:19 -0400
Date: Tue, 5 Jun 2012 15:27:13 +0200
From: Karel Zak <kzak@redhat.com>
To: Ludwig Nussel <ludwig.nussel@suse.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/7] introduce xsetenv globally
Message-ID: <20120605132713.GJ14536@x2.net.home>
References: <1338555081-2061-1-git-send-email-ludwig.nussel@suse.de>
 <1338555081-2061-4-git-send-email-ludwig.nussel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338555081-2061-4-git-send-email-ludwig.nussel@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jun 01, 2012 at 02:51:18PM +0200, Ludwig Nussel wrote:
> +++ b/include/env.h
> @@ -4,5 +4,12 @@
>  extern void sanitize_env (void);
>  extern char *safe_getenv(const char *arg);
>  
> +static inline void
> +xsetenv (char const *name, char const *val, int overwrite)
> +{
> +  if (setenv (name, val, overwrite) != 0)
> +    err (EXIT_FAILURE,  _("failed to set the %s environment variable"), name);
> +}
> +

 It would be nice to use it also in login.c :-)

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:62160 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751545AbdF1U2a (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 28 Jun 2017 16:28:30 -0400
Received: from tenfore.site ([92.195.15.151]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MBZ9u-1dYbYw2zgM-00ATwt for
 <util-linux@vger.kernel.org>; Wed, 28 Jun 2017 22:28:28 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/8] lib/path: add error handling to path_vcreate()
Date: Wed, 28 Jun 2017 22:28:28 +0200
References: <1498668057-8256-1-git-send-email-sweet_f_a@gmx.de> <1498668057-8256-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498668057-8256-3-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201706282228.28080.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 28 June 2017, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>
> Do not operate on truncated/random paths. Note, path_strdup()
> can now really return NULL, to be handled in next commit.
>
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  lib/path.c | 40 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 32 insertions(+), 8 deletions(-)
>
> diff --git a/lib/path.c b/lib/path.c
> index eaa6d88..48ffe17 100644
> --- a/lib/path.c
> +++ b/lib/path.c
> @@ -38,11 +38,21 @@ static char pathbuf[PATH_MAX];
>  static const char *
>  path_vcreate(const char *path, va_list ap)
>  {
> +	int rc;
> +
>  	if (prefixlen)
> -		vsnprintf(pathbuf + prefixlen,
> +		rc = vsnprintf(pathbuf + prefixlen,
>  			  sizeof(pathbuf) - prefixlen, path, ap);
>  	else
> -		vsnprintf(pathbuf, sizeof(pathbuf), path, ap);
> +		rc = vsnprintf(pathbuf, sizeof(pathbuf), path, ap);

I've updated this part for cosmetics on github:

-	if (prefixlen)
-		vsnprintf(pathbuf + prefixlen,
-			  sizeof(pathbuf) - prefixlen, path, ap);
-	else
-		vsnprintf(pathbuf, sizeof(pathbuf), path, ap);
+	int rc = vsnprintf(
+		pathbuf + prefixlen, sizeof(pathbuf) - prefixlen, path, ap);


> +	if (rc < 0)
> +		return NULL;
> +	if ((size_t)rc >= sizeof(pathbuf)) {
> +		errno = ENAMETOOLONG;
> +		return NULL;
> +	}
> +
>  	return pathbuf;
>  }
>
> @@ -64,11 +74,19 @@ path_vfopen(const char *mode, int exit_on_error,
> const char *path, va_list ap) {
>  	FILE *f;
>  	const char *p = path_vcreate(path, ap);
> -
> +	if (!p) {
> +		p = "vpath";
> +		goto err;
> +	}
>  	f = fopen(p, mode);
> -	if (!f && exit_on_error)
> -		err(EXIT_FAILURE, _("cannot open %s"), p);
> +	if (!f)
> +		goto err;
> +
>  	return f;
> +err:
> +	if (exit_on_error)
> +		err(EXIT_FAILURE, _("cannot open %s"), p);
> +	return NULL;
>  }
>
>  static int
> @@ -76,11 +94,17 @@ path_vopen(int flags, const char *path, va_list
> ap) {
>  	int fd;
>  	const char *p = path_vcreate(path, ap);
> -
> +	if (!p) {
> +		p = "vpath";
> +		goto err;
> +	}
>  	fd = open(p, flags);
>  	if (fd == -1)
> -		err(EXIT_FAILURE, _("cannot open %s"), p);
> +		goto err;
> +
>  	return fd;
> +err:
> +	err(EXIT_FAILURE, _("cannot open %s"), p);
>  }
>
>  FILE *
> @@ -181,7 +205,7 @@ path_exist(const char *path, ...)
>  	p = path_vcreate(path, ap);
>  	va_end(ap);
>
> -	return access(p, F_OK) == 0;
> +	return p && access(p, F_OK) == 0;
>  }
>
>  #ifdef HAVE_CPU_SET_T

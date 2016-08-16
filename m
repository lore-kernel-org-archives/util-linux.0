Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53346 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753163AbcHPKlT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 16 Aug 2016 06:41:19 -0400
Date: Tue, 16 Aug 2016 12:41:17 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] misc: always check setenv(3) return value
Message-ID: <20160816104117.2brgml3mkuouzlbf@ws.net.home>
References: <20160814072406.2991-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160814072406.2991-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Aug 14, 2016 at 08:24:04AM +0100, Sami Kerola wrote:
> @@ -9,7 +9,7 @@ extern char *safe_getenv(const char *arg);
>  static inline void xsetenv(char const *name, char const *val, int overwrite)
>  {
>  	if (setenv(name, val, overwrite) != 0)
> -		err(EXIT_FAILURE, "failed to set the %s environment variable", name);
> +		err(EXIT_FAILURE, _("failed to set the %s environment variable"), name);
>  }

no nls.h included

In file included from lib/env.c:22:0:
./include/env.h: In function ‘xsetenv’:
./include/env.h:12:21: warning: implicit declaration of function ‘_’ [-Wimplicit-function-declaration]
./include/env.h:12:3: warning: nested extern declaration of ‘_’ [-Wnested-externs]
./include/env.h:12:21: warning: passing argument 2 of ‘err’ makes pointer from integer without a cast [-Wint-conversion]


>  	if (pwd->pw_uid)
> -		logindefs_setenv("PATH", "ENV_PATH", _PATH_DEFPATH);
> +		if (logindefs_setenv("PATH", "ENV_PATH", _PATH_DEFPATH) != 0)
> +			err(EXIT_FAILURE, _("failed to set the %s environment variable"), "PATH");
>  
>  	else if (logindefs_setenv("PATH", "ENV_ROOTPATH", NULL) != 0)
> -		logindefs_setenv("PATH", "ENV_SUPATH", _PATH_DEFPATH_ROOT);
> +		if (logindefs_setenv("PATH", "ENV_SUPATH", _PATH_DEFPATH_ROOT) != 0)
> +			err(EXIT_FAILURE, _("failed to set the %s environment variable"), "PATH");

What about to use { } ?

 login-utils/login.c: In function ‘init_environ’:
 login-utils/login.c:1050:5: warning: suggest explicit braces to avoid  ambiguous ‘else’ [-Wparentheses]


Fixed.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

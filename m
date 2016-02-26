Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:43679 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885AbcBZM37 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 26 Feb 2016 07:29:59 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1aZHWw-0000mj-7h
	for util-linux@vger.kernel.org; Fri, 26 Feb 2016 13:29:58 +0100
Received: from ppp37-190-56-35.pppoe.spdop.ru ([37.190.56.35])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 26 Feb 2016 13:29:58 +0100
Received: from yumkam by ppp37-190-56-35.pppoe.spdop.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 26 Feb 2016 13:29:58 +0100
To: util-linux@vger.kernel.org
From: yumkam@gmail.com (Yuriy M. Kaminskiy)
Subject: Re: [PATCH 06/14] newgrp: rename memset_s()
Date: Fri, 26 Feb 2016 15:29:51 +0300
Message-ID: <m37fhrods0.fsf@gmail.com>
References: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
	<1456455812-19453-7-git-send-email-sweet_f_a@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Ruediger Meier <sweet_f_a@gmx.de> writes:

> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>
> It's already defined in OSX standard c library.

Would not it be better to just use system-provided memset_s instead by
then? (And it is well possible glibc will provide memset_s in future
too).

> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  login-utils/newgrp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/login-utils/newgrp.c b/login-utils/newgrp.c
> index 141b41b..56639d1 100644
> --- a/login-utils/newgrp.c
> +++ b/login-utils/newgrp.c
> @@ -62,7 +62,7 @@ static char *xgetpass(FILE *input, const char *prompt)
>  
>  /* Ensure memory is set to value c without compiler optimization getting
>   * into way that could happen with memset(3). */
> -static int memset_s(void *v, size_t sz, const int c)
> +static int xmemset_s(void *v, size_t sz, const int c)
>  {
>  	volatile unsigned char *p = v;
>  
> @@ -148,7 +148,7 @@ static int allow_setgid(const struct passwd *pe, const struct group *ge)
>  	if (pwd && *pwd && (xpwd = xgetpass(stdin, _("Password: ")))) {
>  		char *cbuf = crypt(xpwd, pwd);
>  
> -		memset_s(xpwd, strlen(xpwd), 0);
> +		xmemset_s(xpwd, strlen(xpwd), 0);
>  		free(xpwd);
>  		if (!cbuf)
>  			warn(_("crypt failed"));


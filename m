Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:59924 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753957AbcBZMrg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 26 Feb 2016 07:47:36 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Subject: Re: [PATCH 06/14] newgrp: rename memset_s()
Date: Fri, 26 Feb 2016 13:47:26 +0100
Cc: util-linux@vger.kernel.org
References: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de> <1456455812-19453-7-git-send-email-sweet_f_a@gmx.de> <m37fhrods0.fsf@gmail.com>
In-Reply-To: <m37fhrods0.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201602261347.26863.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Friday 26 February 2016, Yuriy M. Kaminskiy wrote:
> Ruediger Meier <sweet_f_a@gmx.de> writes:
> > From: Ruediger Meier <ruediger.meier@ga-group.nl>
> >
> > It's already defined in OSX standard c library.
>
> Would not it be better to just use system-provided memset_s instead
> by then? (And it is well possible glibc will provide memset_s in
> future too).

I think we should do this when there are existing Linux systems with 
memset_s. For now I don't want to do bigger changes just to be portable 
because portability is not our primary goal.

BTW it's also well possible that the affected newgrp sources may 
disappear soon anyways, see Documentation/TODO.

> > Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> > ---
> >  login-utils/newgrp.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/login-utils/newgrp.c b/login-utils/newgrp.c
> > index 141b41b..56639d1 100644
> > --- a/login-utils/newgrp.c
> > +++ b/login-utils/newgrp.c
> > @@ -62,7 +62,7 @@ static char *xgetpass(FILE *input, const char
> > *prompt)
> >
> >  /* Ensure memory is set to value c without compiler optimization
> > getting * into way that could happen with memset(3). */
> > -static int memset_s(void *v, size_t sz, const int c)
> > +static int xmemset_s(void *v, size_t sz, const int c)
> >  {
> >  	volatile unsigned char *p = v;
> >
> > @@ -148,7 +148,7 @@ static int allow_setgid(const struct passwd
> > *pe, const struct group *ge) if (pwd && *pwd && (xpwd =
> > xgetpass(stdin, _("Password: ")))) { char *cbuf = crypt(xpwd, pwd);
> >
> > -		memset_s(xpwd, strlen(xpwd), 0);
> > +		xmemset_s(xpwd, strlen(xpwd), 0);
> >  		free(xpwd);
> >  		if (!cbuf)
> >  			warn(_("crypt failed"));
>
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

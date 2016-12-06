Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:56887 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752353AbcLFRAt (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 6 Dec 2016 12:00:49 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 01/11] last: include libgen.h for basename(3p)
Date: Tue, 6 Dec 2016 18:00:42 +0100
Cc: util-linux@vger.kernel.org
References: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de> <1480582332-17407-2-git-send-email-sweet_f_a@gmx.de> <20161206150131.twqbvpl7oqvhkddt@ws.net.home>
In-Reply-To: <20161206150131.twqbvpl7oqvhkddt@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201612061800.42299.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 06 December 2016, Karel Zak wrote:
> On Thu, Dec 01, 2016 at 09:52:04AM +0100, Ruediger Meier wrote:
> > From: Ruediger Meier <ruediger.meier@ga-group.nl>
> >
> > Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> > ---
> >  login-utils/last.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/login-utils/last.c b/login-utils/last.c
> > index 6d0e892..90eee68 100644
> > --- a/login-utils/last.c
> > +++ b/login-utils/last.c
> > @@ -40,6 +40,7 @@
> >  #include <netinet/in.h>
> >  #include <netdb.h>
> >  #include <arpa/inet.h>
> > +#include <libgen.h>
> >
> >  #include "c.h"
> >  #include "nls.h"
> > @@ -877,7 +878,11 @@ static void process_wtmp_file(const struct
> > last_control *ctl, }
> >  	}
> >
> > -	printf(_("\n%s begins %s"), basename(filename),
> > ctime(&begintime)); +	{
> > +		char* tmp = xstrdup(filename);
> > +		printf(_("\n%s begins %s"), basename(tmp), ctime(&begintime));
> > +		free(tmp);
>
>  This seems like pretty common pattern, what about to introduce
>  xbasename(filename, &tmp)?

Or the comfort version below? Caller has to
free the returned string only.

char *xbasename(const char *path)
{
        char *tmp, *p, *ret;

        tmp = xstrdup(path);
        p = basename(tmp);
        ret = xstrdup(p);

        free(tmp);
        return ret;
}

... plus we could also import musl's basename code to get rid of this
libgen.h/GNU thing at all:

char *basename(char *s)
{
        size_t i;
        if (!s || !*s) return ".";
        i = strlen(s)-1;
        for (; i&&s[i]=='/'; i--) s[i] = 0;
        for (; i&&s[i-1]!='/'; i--);
        return s+i;
}

cu,
Rudi

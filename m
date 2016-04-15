Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44245 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753281AbcDOIat (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 15 Apr 2016 04:30:49 -0400
Date: Fri, 15 Apr 2016 10:30:46 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH] script: close file descriptors on exec
Message-ID: <20160415083046.gaeryvxivffxrbal@ws.net.home>
References: <1460665325-7793-1-git-send-email-kerolasa@iki.fi>
 <201604150922.14811.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201604150922.14811.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Apr 15, 2016 at 09:22:14AM +0200, Ruediger Meier wrote:
> On Thursday 14 April 2016, Sami Kerola wrote:
> > The commands spawned from script(1) will never need access various
> > file descriptors the script(1) is using.
> >
> > Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> > ---
> >  term-utils/script.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/term-utils/script.c b/term-utils/script.c
> > index 1199742..88b522a 100644
> > --- a/term-utils/script.c
> > +++ b/term-utils/script.c
> > @@ -419,15 +419,15 @@ static void do_io(struct script_control *ctl)
> >  	};
> >
> >
> > -	if ((ctl->typescriptfp = fopen(ctl->fname, ctl->append ? "a" :
> > "w")) == NULL) { +	if ((ctl->typescriptfp = fopen(ctl->fname,
> > ctl->append ? "ae" : "we")) == NULL) { warn(_("cannot open %s"),
> > ctl->fname);
> >  		fail(ctl);
> >  	}
> >  	if (ctl->timing) {
> >  		if (!ctl->tname) {
> > -			if (!(ctl->timingfp = fopen("/dev/stderr", "w")))
> > +			if (!(ctl->timingfp = fopen("/dev/stderr", "we")))
> >  				err(EXIT_FAILURE, _("cannot open %s"), "/dev/stderr");
> > -		} else if (!(ctl->timingfp = fopen(ctl->tname, "w")))
> > +		} else if (!(ctl->timingfp = fopen(ctl->tname, "we")))
> 
> "e" works for glibc only.

Yep, see c.h, should be 

    else if (!(ctl->timingfp = fopen(ctl->tname, "w" UL_CLOEXECSTR))) 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

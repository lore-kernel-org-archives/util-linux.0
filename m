Return-Path: dennis.h.jensen@siemens.com
Subject: Re: [PATCH] agetty: map NL to CR-NL on output in initial
 termiossettings
From: Dennis Jensen <dennis.h.jensen@siemens.com>
To: Karel Zak <kzak@redhat.com>
Cc: Werner Fink <werner@suse.de>, util-linux@vger.kernel.org
In-Reply-To: <20111123110851.GA516@nb.net.home>
References: <1321437290.29540.75.camel@djensen-laptop>
	 <20111123110851.GA516@nb.net.home>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 24 Nov 2011 18:55:57 +0100
Message-ID: <1322157357.6169.541.camel@djensen-laptop>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

On Wed, 2011-11-23 at 12:08 +0100, Karel Zak wrote:
> [CC: to Werner Fink]
> 
> On Wed, Nov 16, 2011 at 10:54:50AM +0100, Dennis Jensen wrote:
> > This fixes situations where messages "scroll horizontally", making
> 
> Do you mean /etc/issue and prompt strings? The terminal end-of-line
> should be detected in get_logname() and then the proper flags should
> be set in termio_final().

I mean something like this, after enabling DEBUG: 

-wL8ttyS019200linuxaterm_io 2
                             before autobaud
                                            waiting for cr-lf

So if agetty is on the console and messages are written to the console
while it is waiting for cr-lf, before get_logname(), they will scroll
like above.
> 
> > them unreadable, because agetty has opened and initialized the
> > terminal.
> > 
> > From: Jacoby Hickerson <hickersonjl@gmail.com>
> > Signed-off-by: Dennis Jensen <dennis.h.jensen@siemens.com>
> > ---
> >  term-utils/agetty.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > diff --git a/term-utils/agetty.c b/term-utils/agetty.c
> > index 041e1f7..27edac5 100644
> > --- a/term-utils/agetty.c
> > +++ b/term-utils/agetty.c
> > @@ -1091,7 +1091,8 @@ static void termio_init(struct options *op, struct termios *tp)
> >  #else
> >  	tp->c_iflag = 0;
> >  #endif
> > -	tp->c_lflag = tp->c_oflag = 0;
> > +	tp->c_lflag = 0;
> > +	tp->c_oflag = OPOST | ONLCR;
> 
> Is it correct to always set ONLCR? Would be better to follow the
> current (kernel) setting? I mean:
> 
>   tp->c_oflag = (tp->c_oflag & POST) | (tp->c_oflag & ONLCR);
> 
> Can you try it?

Sure, that also works for me. This seems as safe to me as setting the
output flags to 0. Here's the new patch.

Regards,
Dennis

From: Jacoby Hickerson <hickersonjl@gmail.com>
Signed-off-by: Dennis Jensen <dennis.h.jensen@siemens.com>
---
 term-utils/agetty.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 041e1f7..079a737 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -1091,7 +1091,8 @@ static void termio_init(struct options *op, struct termios *tp)
 #else
 	tp->c_iflag = 0;
 #endif
-	tp->c_lflag = tp->c_oflag = 0;
+	tp->c_lflag = 0;
+	tp->c_oflag &= OPOST | ONLCR;
 
 	if ((op->flags & F_KEEPCFLAGS) == 0)
 		tp->c_cflag = CS8 | HUPCL | CREAD | (tp->c_cflag & CLOCAL);
-- 
1.7.0.4

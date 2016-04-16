Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35294 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbcDPP1B (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 16 Apr 2016 11:27:01 -0400
Received: by mail-wm0-f50.google.com with SMTP id a140so66632651wma.0
        for <util-linux@vger.kernel.org>; Sat, 16 Apr 2016 08:27:00 -0700 (PDT)
Date: Sat, 16 Apr 2016 16:26:52 +0100 (BST)
From: Sami Kerola <kerolasa@iki.fi>
To: Ruediger Meier <sweet_f_a@gmx.de>
cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] script: close file descriptors on exec
In-Reply-To: <201604151042.08728.sweet_f_a@gmx.de>
Message-ID: <alpine.LNX.2.20.1604161623470.4742@imuri>
References: <1460665325-7793-1-git-send-email-kerolasa@iki.fi> <201604150922.14811.sweet_f_a@gmx.de> <20160415083046.gaeryvxivffxrbal@ws.net.home> <201604151042.08728.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, 15 Apr 2016, Ruediger Meier wrote:

> On Friday 15 April 2016, Karel Zak wrote:
> > On Fri, Apr 15, 2016 at 09:22:14AM +0200, Ruediger Meier wrote:
> > > On Thursday 14 April 2016, Sami Kerola wrote:
> > > > The commands spawned from script(1) will never need access
> > > > various file descriptors the script(1) is using.
> > > >
> > > > Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> > > > ---
> > > >  term-utils/script.c | 12 ++++++------
> > > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/term-utils/script.c b/term-utils/script.c
> > > > index 1199742..88b522a 100644
> > > > --- a/term-utils/script.c
> > > > +++ b/term-utils/script.c
> > > > @@ -419,15 +419,15 @@ static void do_io(struct script_control
> > > > *ctl) };
> > > >
> > > >
> > > > -	if ((ctl->typescriptfp = fopen(ctl->fname, ctl->append ? "a" :
> > > > "w")) == NULL) { +	if ((ctl->typescriptfp = fopen(ctl->fname,
> > > > ctl->append ? "ae" : "we")) == NULL) { warn(_("cannot open %s"),
> > > > ctl->fname);
> > > >  		fail(ctl);
> > > >  	}
> > > >  	if (ctl->timing) {
> > > >  		if (!ctl->tname) {
> > > > -			if (!(ctl->timingfp = fopen("/dev/stderr", "w")))
> > > > +			if (!(ctl->timingfp = fopen("/dev/stderr", "we")))
> > > >  				err(EXIT_FAILURE, _("cannot open %s"), "/dev/stderr");
> > > > -		} else if (!(ctl->timingfp = fopen(ctl->tname, "w")))
> > > > +		} else if (!(ctl->timingfp = fopen(ctl->tname, "we")))
> > >
> > > "e" works for glibc only.
> >
> > Yep, see c.h, should be
> >
> >     else if (!(ctl->timingfp = fopen(ctl->tname, "w" UL_CLOEXECSTR)))
> 
> Could be also fixed here:
> login-utils/sulogin-consoles.c:163:  if (!(fp = fopen(file, "re")))
> login-utils/sulogin-consoles.c:364:  fc = fopen("/proc/consoles", "re");

Thank you for reviews Rudi and Karel. Fixes you asked are available in the 
git repository at:

git://github.com/kerolasa/lelux-utiliteetit.git 2016wk15

https://github.com/kerolasa/lelux-utiliteetit/commit/3cd326de56993e90a646219dd810c55ab7809453
https://github.com/kerolasa/lelux-utiliteetit/commit/6c73b302c68ea422b7809fceb3afdb358e315c73

Since the later commit is new here it is as email in-line patch as well to 
provide appropriate visibility for review.

--->8----
From: Sami Kerola <kerolasa@iki.fi>
Date: Sat, 16 Apr 2016 15:43:17 +0100
Subject: [PATCH] sulogin: make fopen O_CLOEXEC specifier usage portable

The close at exit specifier "e" is glibc extension, so use it only if when
the extension is available.

Proposed-by: Ruediger Meier <sweet_f_a@gmx.de>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/sulogin-consoles.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/login-utils/sulogin-consoles.c b/login-utils/sulogin-consoles.c
index fe8eab1..4dcc77c 100644
--- a/login-utils/sulogin-consoles.c
+++ b/login-utils/sulogin-consoles.c
@@ -160,7 +160,7 @@ char *oneline(const char *file)
 
 	DBG(dbgprint("reading %s", file));
 
-	if (!(fp = fopen(file, "re")))
+	if (!(fp = fopen(file, "r" UL_CLOEXECSTR)))
 		return NULL;
 	len = getline(&ret, &dummy, fp);
 	if (len >= 0) {
@@ -361,7 +361,7 @@ static int detect_consoles_from_proc(struct list_head *consoles)
 
 	DBG(dbgprint("trying /proc"));
 
-	fc = fopen("/proc/consoles", "re");
+	fc = fopen("/proc/consoles", "r" UL_CLOEXECSTR);
 	if (!fc) {
 		rc = 2;
 		goto done;
-- 
2.8.0


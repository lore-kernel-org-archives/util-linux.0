Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:51255 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981AbaEETpW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 5 May 2014 15:45:22 -0400
Message-ID: <1399319120.11780.46.camel@oct.suse.cz>
Subject: Re: [PATCH] hwclock: Warning typo fix
From: Stanislav Brabec <sbrabec@suse.cz>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Date: Mon, 05 May 2014 21:45:20 +0200
In-Reply-To: <CAG27Bk3HocOszOVAXfzTeLUgr_6fhgpRt61_KuwVxCV4tKADYQ@mail.gmail.com>
References: <1399317654.11780.43.camel@oct.suse.cz>
	 <CAG27Bk3HocOszOVAXfzTeLUgr_6fhgpRt61_KuwVxCV4tKADYQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-2"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Sami Kerola wrote:
> On 5 May 2014 20:20, Stanislav Brabec <sbrabec@suse.cz> wrote:
> > Trailing '\n' is missing in:
> > "Not setting clock because last adjustment time is zero, so history is bad."
> >
> > Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
> > ---
> >  sys-utils/hwclock.c | 2 +-
> 
> Hi Stanislav,
> 
> The hwclock.c change is OK. The po files are not updated this way.
> 
> See also http://www.spinics.net/lists/util-linux-ng/msg09087.html
> 
OK. I just wanted to save translators' time and fixed all po files,
including existing translations.

>From baf61d938ec3c72be9cffb65b15a44ecca681e22 Mon Sep 17 00:00:00 2001
From: Stanislav Brabec <sbrabec@suse.cz>
Date: Mon, 5 May 2014 21:16:31 +0200
Subject: [PATCH] hwclock: Warning typo fix

The hwclock.c change is OK. The po files are not updated this way.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 sys-utils/hwclock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index fe97fcb..beb2845 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1210,7 +1210,7 @@ do_adjustment(struct adjtime *adjtime_p,
 		if (debug)
 			printf(_
 			       ("Not setting clock because last adjustment time is zero, "
-				"so history is bad."));
+				"so history is bad.\n"));
 	} else if (abs(adjtime_p->drift_factor) > MAX_DRIFT) {
 		if (debug)
 		printf(_("Not setting clock because drift factor %f is far too high.\n"),
-- 
1.8.4.5

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76


Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f172.google.com ([209.85.215.172]:39473 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756368Ab3H2SBN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 29 Aug 2013 14:01:13 -0400
Received: by mail-ea0-f172.google.com with SMTP id r16so419218ead.3
        for <util-linux@vger.kernel.org>; Thu, 29 Aug 2013 11:01:12 -0700 (PDT)
Date: Thu, 29 Aug 2013 19:01:07 +0100
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 11/17] last: parse easy to use time formats
Message-ID: <20130829180104.GA28314@gmail.com>
References: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
 <1377626779-26030-11-git-send-email-kerolasa@iki.fi>
 <20130829100919.GC24438@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130829100919.GC24438@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Aug 29, 2013 at 12:09:19PM +0200, Karel Zak wrote:
> On Tue, Aug 27, 2013 at 07:06:13PM +0100, Sami Kerola wrote:
> >  		case 'p':
> >  			present = parsetm(optarg);
> > -			if (present == (time_t) -1)
> > +			if (present != (time_t) -1)
> > +				break;
> > +			if (parse_timestamp(optarg, &p) < 0)
> >  				errx(EXIT_FAILURE, _("invalid time value \"%s\""), optarg);
> > +			present = (time_t) (p / 1000000);
> >  			break;
> 
>  It would be better to add support for YYYYMMDDHHMMSS into
>  parse_timestamp() rather than maintain and use two parsers.

Done as proposed.

This, and there rest of the changes I will sent shortly, are also in the
git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2013wk34



>From 10e295c115849c0467eee550fb5b2176e6885839 Mon Sep 17 00:00:00 2001
From: Sami Kerola <kerolasa@iki.fi>
Date: Thu, 29 Aug 2013 16:11:41 +0100
Subject: [PATCH 13/26] lib/time-util: move YYYYMMDDHHMMSS to common parser
Organization: Lastminute.com

Even while the YYYYMMDDHHMMSS time format it not magnificent it is best
to make it to be part of the one, and only, time format parser.

Proposed-by: Karel Zak <kzak@redhat.com>
References: http://markmail.org/message/6baqt4ttkopu7ra6
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/time-util.c    |  7 +++++++
 login-utils/last.c | 45 ---------------------------------------------
 2 files changed, 7 insertions(+), 45 deletions(-)

diff --git a/lib/time-util.c b/lib/time-util.c
index a0b27bf..e027bac 100644
--- a/lib/time-util.c
+++ b/lib/time-util.c
@@ -306,6 +306,13 @@ int parse_timestamp(const char *t, usec_t *usec)
 		goto finish;
 	}
 
+	tm = copy;
+	k = strptime(t, "%Y%m%d%H%M%S", &tm);
+	if (k && *k == 0) {
+		tm.tm_sec = 0;
+		goto finish;
+	}
+
 	return -EINVAL;
 
  finish:
diff --git a/login-utils/last.c b/login-utils/last.c
index df78436..410e612 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -440,45 +440,6 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 }
 
 
-static time_t parsetm(char *ts)
-{
-	struct tm	u, origu;
-	time_t		tm;
-
-	memset(&tm, 0, sizeof(tm));
-
-	if (sscanf(ts, "%4d%2d%2d%2d%2d%2d", &u.tm_year,
-	    &u.tm_mon, &u.tm_mday, &u.tm_hour, &u.tm_min,
-	    &u.tm_sec) != 6)
-		return (time_t)-1;
-
-	u.tm_year -= 1900;
-	u.tm_mon -= 1;
-	u.tm_isdst = -1;
-
-	origu = u;
-
-	if ((tm = mktime(&u)) == (time_t)-1)
-		return tm;
-
-	/*
-	 *	Unfortunately mktime() is much more forgiving than
-	 *	it should be.  For example, it'll gladly accept
-	 *	"30" as a valid month number.  This behavior is by
-	 *	design, but we don't like it, so we want to detect
-	 *	it and complain.
-	 */
-	if (u.tm_year != origu.tm_year ||
-	    u.tm_mon != origu.tm_mon ||
-	    u.tm_mday != origu.tm_mday ||
-	    u.tm_hour != origu.tm_hour ||
-	    u.tm_min != origu.tm_min ||
-	    u.tm_sec != origu.tm_sec)
-		return (time_t)-1;
-
-	return tm;
-}
-
 static void process_wtmp_file(char *ufile, int lastb, int extended,
 			      time_t until, time_t present)
 {
@@ -796,17 +757,11 @@ int main(int argc, char **argv)
 			fulltime++;
 			break;
 		case 'p':
-			present = parsetm(optarg);
-			if (present != (time_t) -1)
-				break;
 			if (parse_timestamp(optarg, &p) < 0)
 				errx(EXIT_FAILURE, _("invalid time value \"%s\""), optarg);
 			present = (time_t) (p / 1000000);
 			break;
 		case 't':
-			until = parsetm(optarg);
-			if (until != (time_t) -1)
-				break;
 			if (parse_timestamp(optarg, &p) < 0)
 				errx(EXIT_FAILURE, _("invalid time value \"%s\""), optarg);
 			until = (time_t) (p / 1000000);
-- 
1.8.4




-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/

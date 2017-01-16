Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33466 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdAPWqh (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 16 Jan 2017 17:46:37 -0500
Received: by mail-wm0-f66.google.com with SMTP id r144so34161166wme.0
        for <util-linux@vger.kernel.org>; Mon, 16 Jan 2017 14:46:36 -0800 (PST)
Date: Mon, 16 Jan 2017 22:40:05 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] last: use --time-format instruction when printing wtmp
 creation time
In-Reply-To: <20170116112528.x72dn2pcxjxbfjp7@ws.net.home>
Message-ID: <alpine.LNX.2.20.1701162236440.12085@imuri>
References: <20170115101718.8885-1-kerolasa@iki.fi> <20170116112528.x72dn2pcxjxbfjp7@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 16 Jan 2017, Karel Zak wrote:

> On Sun, Jan 15, 2017 at 10:17:18AM +0000, Sami Kerola wrote:
> > --- a/login-utils/last.c
> > +++ b/login-utils/last.c
> > @@ -874,11 +874,23 @@ static void process_wtmp_file(const struct last_control *ctl,
> >  		}
> >  	}
> >  
> > -	{
> > -		char* tmp = xstrdup(filename);
> > -		printf(_("\n%s begins %s"), basename(tmp), ctime(&begintime));
> > +	if (ctl->time_fmt != LAST_TIMEFTM_NONE) {
> > +		struct last_timefmt *fmt;
> > +		char timestr[LAST_TIMESTAMP_LEN];
> > +		size_t len;
> > +		char *tmp = xstrdup(filename);
> > +
> > +		fmt = &timefmts[ctl->time_fmt];
> > +		if (time_formatter(fmt->in_fmt, timestr,
> > +				   sizeof(timestr), &begintime) < 0)
> > +			errx(EXIT_FAILURE, _("preallocation size exceeded"));
> > +		len = strlen(timestr) - 1;
> > +		if (timestr[len] == '\n')
> > +			timestr[len] = '\0';
> 
> Do we expect this '\n' somewhere in the code?
> 
> I guess that also for LAST_TIMEFTM_CTIME is the \n char truncated.
> What about to remove \n from the string in the time_formatter() to
> avoid this timestr[len] = '\0' in the code?

Hi Karel,

Well \n removal has to be somewhere and it does make sense to move it to 
time_formatter().  How about the following that is also available at:

  git://github.com/kerolasa/lelux-utiliteetit.git last

--->8----
From: Sami Kerola <kerolasa@iki.fi>
Date: Mon, 16 Jan 2017 22:31:36 +0000
Subject: [PATCH] last: use --time-format instruction when printing wtmp creation time

This makes --time-format=iso timestamp to look the same as login/logout
times.  When --time-format=noformat is used the file creation time not
printed.  There is no change to default format.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c             | 17 +++++++++++++----
 tests/expected/utmp/last-nodns |  4 +---
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 7c243f147..5ebd5e2ba 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -345,7 +345,8 @@ static int time_formatter(int fmt, char *dst, size_t dlen, time_t *when)
 		break;
 	}
 	case LAST_TIMEFTM_CTIME:
-		ret = snprintf(dst, dlen, "%s", ctime(when));
+		snprintf(dst, dlen, "%s", ctime(when));
+		ret = rtrim_whitespace((unsigned char *) dst);
 		break;
 	case LAST_TIMEFTM_ISO8601:
 		ret = strtime_iso(when, ISO_8601_DATE|ISO_8601_TIME|ISO_8601_TIMEZONE, dst, dlen);
@@ -874,11 +875,19 @@ static void process_wtmp_file(const struct last_control *ctl,
 		}
 	}
 
-	{
-		char* tmp = xstrdup(filename);
-		printf(_("\n%s begins %s"), basename(tmp), ctime(&begintime));
+	if (ctl->time_fmt != LAST_TIMEFTM_NONE) {
+		struct last_timefmt *fmt;
+		char timestr[LAST_TIMESTAMP_LEN];
+		char *tmp = xstrdup(filename);
+
+		fmt = &timefmts[ctl->time_fmt];
+		if (time_formatter(fmt->in_fmt, timestr,
+				   sizeof(timestr), &begintime) < 0)
+			errx(EXIT_FAILURE, _("preallocation size exceeded"));
+		printf(_("\n%s begins %s\n"), basename(tmp), timestr);
 		free(tmp);
 	}
+
 	fclose(fp);
 
 	for (p = ulist; p; p = next) {
diff --git a/tests/expected/utmp/last-nodns b/tests/expected/utmp/last-nodns
index cb7cfde09..e92366266 100644
--- a/tests/expected/utmp/last-nodns
+++ b/tests/expected/utmp/last-nodns
@@ -91,8 +91,6 @@ init     foo          five                (01:00)
 login    foo          six                 (01:00)
 user_pro foo          seven               (01:00)
 accounti foo          nine                (01:00)
-
-wtmp-a begins Wed Aug 28 03:00:00 2013
 ~~~ iso-8601 time ~~~
 rick     long         never-gonna-logout 1970-01-01T00:00:00+0000 - 2038-01-19T03:14:07+0000 (24855+03:14)
 torvalds linux        hobby            1991-08-26T00:57:08+0000   gone - no logout
@@ -109,7 +107,7 @@ login    foo          six              2013-08-28T06:00:00+0000 - 2013-08-28T07:
 user_process foo          seven            2013-08-28T05:00:00+0000 - 2013-08-28T06:00:00+0000  (01:00)
 accounting foo          nine             2013-08-28T03:00:00+0000 - 2013-08-28T04:00:00+0000  (01:00)
 
-wtmp-a begins Wed Aug 28 03:00:00 2013
+wtmp-a begins 2013-08-28T03:00:00+0000
 ~~~ since and until ~~~
 oldtime  foo          four             Wed Aug 28 08:00    gone - no logout
 init     foo          five             Wed Aug 28 07:00 - 08:00  (01:00)
-- 
2.11.0


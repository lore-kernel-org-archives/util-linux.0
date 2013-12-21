Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f53.google.com ([74.125.82.53]:32844 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217Ab3LUL5x (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 21 Dec 2013 06:57:53 -0500
Received: by mail-wg0-f53.google.com with SMTP id k14so3408299wgh.8
        for <util-linux@vger.kernel.org>; Sat, 21 Dec 2013 03:57:52 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] docs: cal: mention where Gregorian reformation happen in September 1752
Date: Sat, 21 Dec 2013 11:57:46 +0000
Message-Id: <1387627066-29740-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In September 1752 the Gregorian reformation happen in Great Britain and
Dominions (including what is now the USA).  One could argue the cal(1)
should consider locale when determining the reformation, but such is
nearly impossible implement correctly.

The dates when reformation happen are split by areas that cannot be
expressed with current locales, for example the Netherlands is split to
two and Germany three categories depending on where in the modern country
one is.  Secondly the track when reformation happen is lost for some
countries, Lithuania or Japan are good examples of such.

One of the worst for a programmer is Sweden.  They got gradual calendar
change which made Swedish calendar to be completely out of sync.  Later
the Swedish calendar jumped in 1753 to be in sync with everyone else.

Notice that some countries, including Saudi Arabia, Ethiopia, Nepal, Iran
and Afghanistan, still have not adopted the Gregorian calendar.  Hence
the output of the cal(1) can be considered correct for most but not for
each individual separately.

References: http://calendopedia.com/gregory.htm
References: http://en.wikipedia.org/wiki/Gregorian_calendar#Gregorian_reform
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.1 | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/misc-utils/cal.1 b/misc-utils/cal.1
index fa79f91..1ce0e26 100644
--- a/misc-utils/cal.1
+++ b/misc-utils/cal.1
@@ -102,17 +102,23 @@ specified, the current month's calendar is displayed.
 A year starts on Jan 1. The first day of the week is determined by the
 locale.
 .PP
-The Gregorian Reformation is assumed to have occurred in 1752 on the 3rd of
-September. By this time, most countries had recognized the reformation
-(although a few did not recognize it until the early 1900's). Ten days
-following that date were eliminated by the reformation, so the calendar for
-that month is a bit unusual.
-.PP
 The week numbering depends on the first day of the week. If Sunday (the
 default) is used for the first day of the week, then the customary North
 American numbering will be used, i.e. first Sunday of the week starts the
 first week. If Monday is selected, then the ISO-8601 standard week numbering
 is used, where the first Thursday is in week number 1.
+.SH BUGS
+.PP
+The
+.B cal
+is using for Gregorian reformation the date of 1752 on the 3rd of
+September when it happen in Great Britain and it's colonies (including
+what is now the USA).  Ten days following that date were eliminated by
+the reformation, so the calendar for that month is a bit unusual.  The
+history when calendar reformation happen in different locales is ignored.
+.PP
+Alternative calendars, such as the Umm al-Qura, the Solar Hijri, the Ge'ez,
+or the lunisolar Hindu, are not supported.
 .SH HISTORY
 A cal command appeared in Version 6 AT&T UNIX.
 .SH AVAILABILITY
-- 
1.8.5.2


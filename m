Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f176.google.com ([74.125.82.176]:58613 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754548Ab3LVSc3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Dec 2013 13:32:29 -0500
Received: by mail-we0-f176.google.com with SMTP id p61so4193793wes.21
        for <util-linux@vger.kernel.org>; Sun, 22 Dec 2013 10:32:27 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: kerolasa@iki.fi, "Util-Linux" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] docs: cal: mention where Gregorian reformation happen in September 1752
Date: Sun, 22 Dec 2013 18:31:42 +0000
Message-Id: <1387737102-32083-1-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1387645415.1452.62357161.76BB1F01@webmail.messagingengine.com>
References: <1387645415.1452.62357161.76BB1F01@webmail.messagingengine.com> <1387627066-29740-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Dec 21, 2013 at 06:03:35PM +0100, Benno Schulenberg wrote:
> The change looks okay, but the wording needs some improvement.

Thank you for review Benno, the below resubmission uses your wording.

BTW after reading a bit about historic calendars I have lost hope
historically correct calendar would be doable.  If BC calendar is ever
made to work is should probably implement what modern day western people
can agree was correct, even if the people who lived at the time would
disagree.

--->8----
From: Sami Kerola <kerolasa@iki.fi>
Date: Sun, 22 Dec 2013 18:06:04 +0000
Subject: [PATCH] docs: cal: mention where Gregorian reformation happen in September 1752

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
the output of the cal(1) cannot be considered to be correct for everyone.

References: http://calendopedia.com/gregory.htm
References: http://en.wikipedia.org/wiki/Gregorian_calendar#Gregorian_reform
Reviewed-by: Benno Schulenberg <bensberg@justemail.net>
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


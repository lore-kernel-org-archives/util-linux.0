Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:51672 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753368AbeABO6J (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 2 Jan 2018 09:58:09 -0500
Subject: [v3 PATCH 05/11] cal: add private --caesar option
To: Karel Zak <kzak@redhat.com>
References: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <9c6b27fc-6792-d93e-15d7-99364fe50a1a@gmx.com>
Date: Tue, 2 Jan 2018 09:58:08 -0500
MIME-Version: 1.0
In-Reply-To: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Add a private option named --caesar that will display the
Julian Calendar system exclusively.

After an appropriate mourning period for deprecating --julian
in favor of --ordinal, the private --caesar can be renamed to
-j, --julian and made public.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 misc-utils/cal.1 | 11 +++++++++++
 misc-utils/cal.c | 19 ++++++++++++++-----
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/misc-utils/cal.1 b/misc-utils/cal.1
index afd3bdc5f..17439d2f9 100644
--- a/misc-utils/cal.1
+++ b/misc-utils/cal.1
@@ -90,6 +90,17 @@ Display three months spanning the date.
 Display calendars based upon the Chesterfield's Act.
 This means that dates previous to 3 Sept 1752 will be Julian calendar dates.
 .RB See \ BUGS \ below.
+.\"
+.\" FIXME Dec 25 2017 - after an appropriate mourning period for deprecating
+.\" --julian in favor of --ordinal, the private --caesar will be renamed
+.\" --julian and made public.  Un-comment this section and delete the old
+.\" Julian option description.  Also update the DESCRIPTION section accordingly.
+.\"
+.\" .TP
+.\" .BR \-j ,\ \-\-julian
+.\" Display the Julian calendar system only.
+.\" Note: the old functionality for this option name is now called
+.\" .BR \-\-ordinal .
 .TP
 \fB\-n , \-\-months\fR \fInumber\fR
 Display \fInumber\fR of months, starting from the month containing the date.
diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 0990f5199..2f0a6be16 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -267,9 +267,14 @@ int main(int argc, char **argv)
 		.req.day = 0,
 		.req.month = 0
 	};
-
+	/*
+	 * FIXME Dec 25 2017 - after an appropriate mourning period for
+	 * deprecating --julian in favor of --ordinal, the private --caesar
+	 * will be renamed -j, --julian and made public.
+	 */
 	enum {
 		OPT_1752_REFORM = CHAR_MAX + 1,
+		OPT_CAESAR,
 		OPT_COLOR,
 		OPT_ORDINAL
 	};
@@ -286,6 +291,7 @@ int main(int argc, char **argv)
 		{"week", optional_argument, NULL, 'w'},
 		{"color", optional_argument, NULL, OPT_COLOR},
 		{"ordinal", no_argument, NULL, OPT_ORDINAL},
+		{"caesar", no_argument, NULL, OPT_CAESAR},
 		{"1752-reform", no_argument, NULL, OPT_1752_REFORM},
 		{"version", no_argument, NULL, 'V'},
 		{"twelve", no_argument, NULL, 'Y'},
@@ -406,6 +412,9 @@ int main(int argc, char **argv)
 		case OPT_1752_REFORM:
 			ctl.reform_year = 1752;
 			break;
+		case OPT_CAESAR:
+			ctl.reform_year = INT32_MAX;
+			break;
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
@@ -921,14 +930,14 @@ static int day_in_week(const struct cal_control *ctl, int day,
 	if (ctl->reform_year < year
 	    || (year == ctl->reform_year && REFORM_MONTH < month)
 	    || (year == ctl->reform_year && month == REFORM_MONTH && 13 < day)) {
-		int64_t long_year = year;
-		return (long_year + (year / 4) - (year / 100) + (year / 400) +
-			reform[month - 1] + day) % DAYS_IN_WEEK;
+		return ((int64_t) year + (year / 4) - (year / 100) + (year / 400)
+			+ reform[month - 1] + day) % DAYS_IN_WEEK;
 	}
 	if (year < ctl->reform_year
 	    || (year == ctl->reform_year && month < REFORM_MONTH)
 	    || (year == ctl->reform_year && month == REFORM_MONTH && day < 3))
-		return (year + year / 4 + old[month - 1] + day) % DAYS_IN_WEEK;
+		return ((int64_t) year + year / 4 + old[month - 1] + day)
+			% DAYS_IN_WEEK;
 	return NONEDAY;
 }
 

Return-Path: elseifthen@gmx.com
Subject: [PATCH 1/1] hwclock.c, hwclock.8.in: new --show format
To: Karel Zak <kzak@redhat.com>
References: <56BD2A87.30009@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <56BD2BE8.3030501@gmx.com>
Date: Thu, 11 Feb 2016 19:48:40 -0500
MIME-Version: 1.0
In-Reply-To: <56BD2A87.30009@gmx.com>
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>


* hwclock.c: change --get and --show functions to the ISO 8601
  format and concatenate fractional seconds to the time display.

* hwclock.8.in: document this.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.8.in |  8 +++-----
 sys-utils/hwclock.c    | 16 +++++++++-------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index d72b7a8..eddb864 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -88,16 +88,14 @@ command, such as \%'11\ minute\ mode' or from dual-booting another OS.
 .TQ
 .B \-\-get
 .br
-Read the Hardware Clock and print the time on standard output.
+Read the Hardware Clock and print its time to standard output in the
+.B ISO 8601
+format.
 The time shown is always in local time, even if you keep your Hardware Clock
 in UTC.  See the
 .B \%\-\-localtime
 option.
 .sp
-The time shown is in same format as that of 
-.BR \%date (1)
-by default, and additionally, the number of microseconds is shown.
-.sp 
 Showing the Hardware Clock time is the default when no function is specified.
 .sp
 The
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 2eb21ac..6f14081 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -687,13 +687,15 @@ display_time(const bool hclock_valid, struct timeval hwctime)
 		       "either invalid (e.g. 50th day of month) or beyond the range "
 		       "we can handle (e.g. Year 2095)."));
 	else {
-		struct tm *lt;
-		char *format = "%c";
-		char ctime_now[200];
-
-		lt = localtime(&hwctime.tv_sec);
-		strftime(ctime_now, sizeof(ctime_now), format, lt);
-		printf(_("%s and %06d microseconds\n"), ctime_now, (int)hwctime.tv_usec);
+		struct tm lt;
+		int zhour, zmin;
+
+		lt = *localtime(&hwctime.tv_sec);
+		zhour = - timezone / 60 / 60;
+		zmin = abs(timezone / 60 % 60);
+		printf(_("%4d-%.2d-%.2d %02d:%02d:%02d.%06d%+02d:%02d\n"),
+		       lt.tm_year + 1900, lt.tm_mon + 1, lt.tm_mday, lt.tm_hour,
+		       lt.tm_min, lt.tm_sec, (int)hwctime.tv_usec, zhour, zmin);
 	}
 }
 

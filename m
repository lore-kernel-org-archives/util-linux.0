Return-Path: elseifthen@gmx.com
Subject: [V2 2/4] build-system: add hwclock-date
To: Karel Zak <kzak@redhat.com>
References: <ee9e12b4-a921-b47e-975d-53a5b8575361@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <641e2ffe-49d4-a342-ffb1-4f9e1c5119ce@gmx.com>
Date: Sat, 25 Feb 2017 13:30:42 -0500
MIME-Version: 1.0
In-Reply-To: <ee9e12b4-a921-b47e-975d-53a5b8575361@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


sys-utils/Makemodule.am: add hwclock-date source file
sys-utils/hwclock.h: add parse_datetime functions

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/Makemodule.am |  1 +
 sys-utils/hwclock.h     | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index c565194..a453486 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -424,6 +424,7 @@ sbin_PROGRAMS += hwclock
 dist_man_MANS += sys-utils/hwclock.8
 PATHFILES += sys-utils/hwclock.8
 hwclock_SOURCES = \
+	sys-utils/hwclock-date.c \
 	sys-utils/hwclock.c \
 	sys-utils/hwclock.h \
 	sys-utils/hwclock-cmos.c
diff --git a/sys-utils/hwclock.h b/sys-utils/hwclock.h
index b08bd2d..e6f16d3 100644
--- a/sys-utils/hwclock.h
+++ b/sys-utils/hwclock.h
@@ -82,4 +82,14 @@ extern int set_epoch_rtc(const struct hwclock_control *ctl);
 
 extern void hwclock_exit(const struct hwclock_control *ctl, int status);
 
+/* date.c */
+int parse_datetime (struct timespec *, char const *, struct timespec const *);
+
+/* parse_datetime2 flag: if set, print debug/progress information to STDERR */
+#define PARSE_DATETIME_DEBUG 1
+
+/* same as above, supporting additional flags */
+int parse_datetime2 (struct timespec *, char const *, struct timespec const *,
+			unsigned int flags);
+
 #endif				/* HWCLOCK_CLOCK_H */

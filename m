Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38707 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753013AbdICWeM (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 3 Sep 2017 18:34:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id u26so4903596wma.5
        for <util-linux@vger.kernel.org>; Sun, 03 Sep 2017 15:34:11 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] hwclock: add -a that is short of --adjust to manual page and usage
Date: Sun,  3 Sep 2017 23:34:07 +0100
Message-Id: <20170903223407.5459-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In same go use -V as return value of --version from getopts_long().

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/hwclock.8.in | 2 +-
 sys-utils/hwclock.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index 107e3f196..2be7147e2 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -34,7 +34,7 @@ was added.  See their respective descriptions below.
 The following functions are mutually exclusive, only one can be given at
 a time.  If none is given, the default is \fB\-\-show\fR.
 .TP
-.B \-\-adjust
+.B \-a, \-\-adjust
 Add or subtract time from the Hardware Clock to account for systematic
 drift since the last time the clock was set or adjusted.  See the
 discussion below, under
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 0b8444156..0da053617 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1089,7 +1089,7 @@ usage(const struct hwclock_control *ctl)
 	puts(_(" -s, --hctosys        set the system time from the RTC"));
 	puts(_(" -w, --systohc        set the RTC from the system time"));
 	puts(_("     --systz          send timescale configurations to the kernel"));
-	puts(_("     --adjust         adjust the RTC to account for systematic drift"));
+	puts(_(" -a, --adjust         adjust the RTC to account for systematic drift"));
 #if defined(__linux__) && defined(__alpha__)
 	puts(_("     --getepoch       display the RTC epoch"));
 	puts(_("     --setepoch       set the RTC epoch according to --epoch"));
@@ -1167,7 +1167,7 @@ int main(int argc, char **argv)
 		{ "show",         no_argument,       NULL, 'r'            },
 		{ "hctosys",      no_argument,       NULL, 's'            },
 		{ "utc",          no_argument,       NULL, 'u'            },
-		{ "version",      no_argument,       NULL, 'v'            },
+		{ "version",      no_argument,       NULL, 'V'            },
 		{ "systohc",      no_argument,       NULL, 'w'            },
 		{ "debug",        no_argument,       NULL, 'D'            },
 		{ "set",          no_argument,       NULL, OPT_SET        },
-- 
2.14.1


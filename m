Return-Path: elseifthen@gmx.com
Subject: [PATCH 1/2] hwclock: remove unused epoch_option
To: Karel Zak <kzak@redhat.com>
References: <b8d24f10-1bea-aa80-0a28-9f573dd81d2a@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <9a83ee2d-3fa4-f871-55fd-70d135dea7e9@gmx.com>
Date: Tue, 18 Jul 2017 16:00:51 -0400
MIME-Version: 1.0
In-Reply-To: <b8d24f10-1bea-aa80-0a28-9f573dd81d2a@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Also one whitespace fix.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 2 +-
 sys-utils/hwclock.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 423ebcd..9745158 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1468,7 +1468,7 @@ int main(int argc, char **argv)
 	}
 
 	if (ctl.set || ctl.predict) {
-		if (!ctl.date_opt){
+		if (!ctl.date_opt) {
 		warnx(_("--date is required for --set or --predict"));
 		hwclock_exit(&ctl, EX_USAGE);
 		}
diff --git a/sys-utils/hwclock.h b/sys-utils/hwclock.h
index 61be57a..a1ef80c 100644
--- a/sys-utils/hwclock.h
+++ b/sys-utils/hwclock.h
@@ -64,7 +64,6 @@ typedef int bool;
 
 /* hwclock.c */
 extern int debug;
-extern unsigned long epoch_option;
 extern double time_diff(struct timeval subtrahend, struct timeval subtractor);
 
 /* rtc.c */

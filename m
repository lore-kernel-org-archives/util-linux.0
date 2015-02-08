Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38609 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbbBHUos (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 Feb 2015 15:44:48 -0500
Received: by mail-wi0-f169.google.com with SMTP id z2so1815373wiv.0
        for <util-linux@vger.kernel.org>; Sun, 08 Feb 2015 12:44:47 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/2] sulogin, hwclock: use xusleep() instead of usleep()
Date: Sun,  8 Feb 2015 20:44:41 +0000
Message-Id: <1423428281-12040-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1423428281-12040-1-git-send-email-kerolasa@iki.fi>
References: <1423428281-12040-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

As said in include/c.h the usleep() is marked as obsolete, so do the same
that most of the other util-linux calls do with this interface.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/sulogin.c | 2 +-
 sys-utils/hwclock.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index f4d68c4..51bc582 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -1066,7 +1066,7 @@ int main(int argc, char **argv)
 			if (*usemask & (1<<con->id))
 				continue;
 			kill(con->pid, SIGHUP);
-			usleep(50000);
+			xusleep(50000);
 			kill(con->pid, SIGKILL);
 		}
 	}
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 9000c95..52a7874 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -609,7 +609,7 @@ set_hardware_clock_exact(const time_t sethwtime,
 		if (debug >= 10) {
 			int usec = random() % 1000000;
 			printf(_("sleeping ~%d usec\n"), usec);
-			usleep(usec);
+			xusleep(usec);
 		}
 
 		gettimeofday(&nowsystime, NULL);
-- 
2.3.0


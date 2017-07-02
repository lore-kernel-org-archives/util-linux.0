Return-Path: elseifthen@gmx.com
Subject: [PATCH 3/5] hwclock: final usage() strings slice
To: Karel Zak <kzak@redhat.com>
References: <9cf88d57-3a45-cd47-ac96-3495e09d81c5@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <40df38f4-6bf5-1959-74af-6ee481b88a12@gmx.com>
Date: Sun, 2 Jul 2017 15:53:06 -0400
MIME-Version: 1.0
In-Reply-To: <9cf88d57-3a45-cd47-ac96-3495e09d81c5@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index eeb68e7..19d7652 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1238,7 +1238,8 @@ usage(const struct hwclock_control *ctl)
 #endif
 	puts(_("     --update-drift   update the RTC drift factor"));
 	printf(_(
-	       "     --noadjfile      do not use %1$s\n"
+	       "     --noadjfile      do not use %1$s\n"), _PATH_ADJTIME);
+	printf(_(
 	       "     --adjfile <file> use an alternate file to %1$s\n"), _PATH_ADJTIME);
 	puts(_("     --test           dry run; use -D to view what would have happened"));
 	puts(_(" -D, --debug          use debug mode"));

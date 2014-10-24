Return-Path: elseifthen@gmx.com
Message-ID: <5449BD44.2040408@gmx.com>
Date: Thu, 23 Oct 2014 22:45:24 -0400
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 1/5] hwclock: Remove newline from 'date' debug output
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

The date command includes a newline.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 008b20a..ced1314 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -767,7 +767,7 @@ static int interpret_date_string(const char *date_opt, time_t * const time_p)
 	if (!fgets(date_resp, sizeof(date_resp), date_child_fp))
 		date_resp[0] = '\0';	/* in case fgets fails */
 	if (debug)
-		printf(_("response from date command = %s\n"), date_resp);
+		printf(_("response from date command = %s"), date_resp);
 	if (strncmp(date_resp, magic, sizeof(magic) - 1) != 0) {
 		warnx(_("The date command issued by %s returned "
 				  "unexpected results.\n"

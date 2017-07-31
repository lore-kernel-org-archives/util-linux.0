Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:57947 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751658AbdGaXhw (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 31 Jul 2017 19:37:52 -0400
Subject: [PATCH 1/5] hwclock: squash custom errno strings
To: Karel Zak <kzak@redhat.com>
References: <ccb78676-1284-5880-0ca9-ff15d2920de7@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <18605853-d895-83bb-68f8-d1e645516ddf@gmx.com>
Date: Mon, 31 Jul 2017 19:37:44 -0400
MIME-Version: 1.0
In-Reply-To: <ccb78676-1284-5880-0ca9-ff15d2920de7@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


hwclock previously used printf for custom errno messages.
Later they were converted to use warn(), but were not
squashed. One of the reasons for warn and errno is to avoid
making translators deal with a multitude custom strings.

Also the custom strings are incorrect:

hwclock --hctosys
hwclock: Must be superuser to set system clock.
Unable to set system clock.

We do not know what the system permissions are set to.  The
correct response is to simply say permission was denied; as
the default errno string does. The second line is redundant
and just adds noise the code and to logs.

Patched:

hwclock --hctosys
hwclock: settimeofday() failed: Operation not permitted

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index aadf196..c74e0e2 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -648,14 +648,8 @@ set_system_clock(const struct hwclock_control *ctl, const bool hclock_valid,
 			if (!rc)
 				rc = settimeofday(&newtime, &tz);
 			if (rc) {
-				if (errno == EPERM) {
-					warnx(_
-					      ("Must be superuser to set system clock."));
-					retcode = EX_NOPERM;
-				} else {
-					warn(_("settimeofday() failed"));
-					retcode = 1;
-				}
+				warn(_("settimeofday() failed"));
+				retcode = 1;
 			} else
 				retcode = 0;
 		}
@@ -744,14 +738,8 @@ static int set_system_clock_timezone(const struct hwclock_control *ctl)
 			rc = settimeofday(tv_null, &tz);
 
 		if (rc) {
-			if (errno == EPERM) {
-				warnx(_
-				      ("Must be superuser to set system clock."));
-				retcode = EX_NOPERM;
-			} else {
-				warn(_("settimeofday() failed"));
-				retcode = 1;
-			}
+			warn(_("settimeofday() failed"));
+			retcode = 1;
 		} else
 			retcode = 0;
 	}
@@ -1134,17 +1122,9 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 			adjust_drift_factor(ctl, adjtime, nowtime,
 					    hclock_valid, hclocktime);
 	} else if (ctl->hctosys) {
-		rc = set_system_clock(ctl, hclock_valid, hclocktime);
-		if (rc) {
-			printf(_("Unable to set system clock.\n"));
-			return rc;
-		}
+		return set_system_clock(ctl, hclock_valid, hclocktime);
 	} else if (ctl->systz) {
-		rc = set_system_clock_timezone(ctl);
-		if (rc) {
-			printf(_("Unable to set system clock.\n"));
-			return rc;
-		}
+		return set_system_clock_timezone(ctl);
 	} else if (ctl->predict) {
 		hclocktime = time_inc(hclocktime, (double)
 				      -(tdrift.tv_sec + tdrift.tv_usec / 1E6));

Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:57712 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015AbbAUSC7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 21 Jan 2015 13:02:59 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0MHHZT-1Xzx7y1scl-00E6Um for
 <util-linux@vger.kernel.org>; Wed, 21 Jan 2015 19:02:57 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/5] build: fix printf warnings for icc (-Wformat-security)
Date: Wed, 21 Jan 2015 19:02:54 +0100
Message-Id: <1421863374-9953-6-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1421863374-9953-1-git-send-email-sweet_f_a@gmx.de>
References: <1421863374-9953-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Intel compiler complains about printf style function calls with trivial
format string and no other arguments. Like this one:

../sys-utils/ipcrm.c(117): warning #2279: printf/scanf format not a string literal and no format arguments
                        err(EXIT_FAILURE, iskey ? _("key failed") : _("id failed"));

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/ipcrm.c   | 2 +-
 sys-utils/lscpu.c   | 8 ++++----
 sys-utils/rtcwake.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sys-utils/ipcrm.c b/sys-utils/ipcrm.c
index 4b59217..0b40f15 100644
--- a/sys-utils/ipcrm.c
+++ b/sys-utils/ipcrm.c
@@ -114,7 +114,7 @@ static int remove_id(int type, int iskey, int id)
 			errmsg = iskey ? _("already removed key") : _("already removed id");
 			break;
 		default:
-			err(EXIT_FAILURE, iskey ? _("key failed") : _("id failed"));
+			err(EXIT_FAILURE, "%s", iskey ? _("key failed") : _("id failed"));
 		}
 		warnx("%s (%d)", errmsg, id);
 		return 1;
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 9b3adbc..82a7dbe 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -1242,20 +1242,20 @@ get_cell_data(struct lscpu_desc *desc, int idx, int col,
 		if (!desc->configured)
 			break;
 		if (mod->mode == OUTPUT_PARSABLE)
-			snprintf(buf, bufsz,
+			snprintf(buf, bufsz, "%s",
 				 desc->configured[idx] ? _("Y") : _("N"));
 		else
-			snprintf(buf, bufsz,
+			snprintf(buf, bufsz, "%s",
 				 desc->configured[idx] ? _("yes") : _("no"));
 		break;
 	case COL_ONLINE:
 		if (!desc->online)
 			break;
 		if (mod->mode == OUTPUT_PARSABLE)
-			snprintf(buf, bufsz,
+			snprintf(buf, bufsz, "%s",
 				 is_cpu_online(desc, cpu) ? _("Y") : _("N"));
 		else
-			snprintf(buf, bufsz,
+			snprintf(buf, bufsz, "%s",
 				 is_cpu_online(desc, cpu) ? _("yes") : _("no"));
 		break;
 	case COL_MAXMHZ:
diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index 35ca7e8..bf99a5b 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -492,7 +492,7 @@ int main(int argc, char **argv)
 		}
 	}
 	if (verbose)
-		printf(clock_mode == CM_UTC ? _("Using UTC time.\n") :
+		printf("%s", clock_mode == CM_UTC ? _("Using UTC time.\n") :
 				_("Using local time.\n"));
 
 	if (!alarm && !seconds && strcmp(suspend,"disable") &&
-- 
1.8.4.5


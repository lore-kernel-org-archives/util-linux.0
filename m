Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:54314 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753755AbdGCLxF (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 3 Jul 2017 07:53:05 -0400
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LtVLE-1dtfmV2gYG-010vuG for <util-linux@vger.kernel.org>; Mon, 03 Jul 2017
 13:53:03 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/6] zramctl: add --sysroot
Date: Mon,  3 Jul 2017 13:53:00 +0200
Message-Id: <1499082781-16968-6-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1499082781-16968-1-git-send-email-sweet_f_a@gmx.de>
References: <1499082781-16968-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/zramctl.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sys-utils/zramctl.c b/sys-utils/zramctl.c
index aee28cc..c6224b3 100644
--- a/sys-utils/zramctl.c
+++ b/sys-utils/zramctl.c
@@ -278,7 +278,7 @@ static int zram_used(struct zram *z)
 static int zram_has_control(struct zram *z)
 {
 	if (!z->control_probed) {
-		z->has_control = access(_PATH_SYS_CLASS "/zram-control/", F_OK) == 0 ? 1 : 0;
+		z->has_control = path_exist(_PATH_SYS_CLASS "/zram-control/") == 0 ? 1 : 0;
 		z->control_probed = 1;
 		DBG(fprintf(stderr, "zram-control: %s", z->has_control ? "yes" : "no"));
 	}
@@ -569,7 +569,10 @@ int main(int argc, char **argv)
 	int rc = 0, c, find = 0, act = A_NONE;
 	struct zram *zram = NULL;
 
-	enum { OPT_RAW = CHAR_MAX + 1 };
+	enum {
+		OPT_RAW = CHAR_MAX + 1,
+		OPT_SYSROOT,
+	};
 
 	static const struct option longopts[] = {
 		{ "algorithm", required_argument, NULL, 'a' },
@@ -583,6 +586,7 @@ int main(int argc, char **argv)
 		{ "size",      required_argument, NULL, 's' },
 		{ "streams",   required_argument, NULL, 't' },
 		{ "version",   no_argument, NULL, 'V' },
+		{ "sysroot",   required_argument, NULL, OPT_SYSROOT },
 		{ NULL, 0, NULL, 0 }
 	};
 
@@ -641,6 +645,11 @@ int main(int argc, char **argv)
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
+		case OPT_SYSROOT:
+			if(path_set_prefix(optarg))
+				err(EXIT_FAILURE, _("invalid argument to %s"), "--sysroot");
+			/* TODO: mod->system = SYSTEM_SNAPSHOT; */
+			break;
 		case 'h':
 			usage();
 		default:
-- 
1.8.5.6


Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38021 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872Ab2GYTP6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:15:58 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr14so1133220wib.1
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:15:57 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/19] lscpu: fix shadow declaration
Date: Wed, 25 Jul 2012 21:15:29 +0200
Message-Id: <1343243745-1172-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

sys-utils/lscpu.c:1084:8: warning: declaration of 'buf' shadows a previous local [-Wshadow]
sys-utils/lscpu.c:1077:7: warning: shadowed declaration is here [-Wshadow]
sys-utils/lscpu.c:1144:9: warning: declaration of 'buf' shadows a previous local [-Wshadow]
sys-utils/lscpu.c:1077:7: warning: shadowed declaration is here [-Wshadow]
sys-utils/lscpu.c:1196:8: warning: declaration of 'buf' shadows a previous local [-Wshadow]
sys-utils/lscpu.c:1077:7: warning: shadowed declaration is here [-Wshadow]
sys-utils/lscpu.c:1197:7: warning: declaration of 'i' shadows a previous local [-Wshadow]
sys-utils/lscpu.c:1078:6: warning: shadowed declaration is here [-Wshadow]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/lscpu.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 3984b2d..7a712de 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -1081,7 +1081,7 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 	print_s(_("Architecture:"), desc->arch);
 
 	if (desc->mode) {
-		char buf[64], *p = buf;
+		char mbuf[64], *p = mbuf;
 
 		if (desc->mode & MODE_32BIT) {
 			strcpy(p, "32-bit, ");
@@ -1092,7 +1092,7 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 			p += 8;
 		}
 		*(p - 2) = '\0';
-		print_s(_("CPU op-mode(s):"), buf);
+		print_s(_("CPU op-mode(s):"), mbuf);
 	}
 #if !defined(WORDS_BIGENDIAN)
 	print_s(_("Byte Order:"), "Little Endian");
@@ -1141,11 +1141,11 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		 */
 		if (path_exist(_PATH_PROC_SYSINFO)) {
 			FILE *fd = path_fopen("r", 0, _PATH_PROC_SYSINFO);
-			char buf[BUFSIZ];
+			char pbuf[BUFSIZ];
 			int t0, t1, t2;
 
-			while (fd && fgets(buf, sizeof(buf), fd) != NULL) {
-				if (sscanf(buf, "CPU Topology SW:%d%d%d%d%d%d",
+			while (fd && fgets(pbuf, sizeof(pbuf), fd) != NULL) {
+				if (sscanf(pbuf, "CPU Topology SW:%d%d%d%d%d%d",
 					   &t0, &t1, &t2, &books, &sockets_per_book,
 					   &cores_per_socket) == 6)
 					break;
@@ -1193,13 +1193,12 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 	if (desc->dispatching >= 0)
 		print_s(_("Dispatching mode:"), _(disp_modes[desc->dispatching]));
 	if (desc->ncaches) {
-		char buf[512];
-		int i;
+		char cbuf[512];
 
 		for (i = desc->ncaches - 1; i >= 0; i--) {
-			snprintf(buf, sizeof(buf),
+			snprintf(cbuf, sizeof(cbuf),
 					_("%s cache:"), desc->caches[i].name);
-			print_s(buf, desc->caches[i].size);
+			print_s(cbuf, desc->caches[i].size);
 		}
 	}
 
-- 
1.7.11.3


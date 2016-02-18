Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:50065 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946087AbcBRNW4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Feb 2016 08:22:56 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0MMTZa-1acT5M3ld8-008GOG for
 <util-linux@vger.kernel.org>; Thu, 18 Feb 2016 14:22:55 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 11/15] lsns: use xcalloc()
Date: Thu, 18 Feb 2016 14:22:54 +0100
Message-Id: <1455801774-10773-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
References: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

... found by tools/checkxalloc.sh

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/lsns.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/lsns.c b/sys-utils/lsns.c
index 7b8f17d..71ae3f9 100644
--- a/sys-utils/lsns.c
+++ b/sys-utils/lsns.c
@@ -233,7 +233,7 @@ static int read_process(struct lsns *ls, pid_t pid)
 	if (!dir)
 		return -errno;
 
-	p = calloc(1, sizeof(*p));
+	p = xcalloc(1, sizeof(*p));
 	if (!p) {
 		rc = -ENOMEM;
 		goto done;
@@ -338,7 +338,7 @@ static int namespace_has_process(struct lsns_namespace *ns, pid_t pid)
 
 static struct lsns_namespace *add_namespace(struct lsns *ls, int type, ino_t ino)
 {
-	struct lsns_namespace *ns = calloc(1, sizeof(*ns));
+	struct lsns_namespace *ns = xcalloc(1, sizeof(*ns));
 
 	if (!ns)
 		return NULL;
-- 
1.8.4.5


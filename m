Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:35147 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051AbcGNN3W (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Jul 2016 09:29:22 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 55ABCAC8D
	for <util-linux@vger.kernel.org>; Thu, 14 Jul 2016 13:29:21 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 5/7] Implement loopcxt_check_conflict()
Message-ID: <8f466000-034e-74a4-dd9f-823b64b5cc8c@suse.cz>
Date: Thu, 14 Jul 2016 15:29:21 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add a function that searches for a possible conflicting (i. e. overlaying loop
device).

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 include/loopdev.h |  3 +++
 lib/loopdev.c     | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/loopdev.h b/include/loopdev.h
index 57fcc1b..706388e 100644
--- a/include/loopdev.h
+++ b/include/loopdev.h
@@ -188,6 +188,9 @@ extern int loopcxt_find_by_backing_file(struct loopdev_cxt *lc,
 				const char *filename,
 				uint64_t offset, uint64_t sizelimit,
 				int flags);
+extern int loopcxt_check_conflict(struct loopdev_cxt *lc,
+				  const char *filename,
+				  uint64_t offset, uint64_t sizelimit);
 
 extern int loopcxt_is_used(struct loopdev_cxt *lc,
                     struct stat *st,
diff --git a/lib/loopdev.c b/lib/loopdev.c
index 2db80fc..4606003 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -1566,6 +1566,61 @@ int loopcxt_find_by_backing_file(struct loopdev_cxt *lc, const char *filename,
 }
 
 /*
+ * Returns: 0 = conflict, < 0 error, 1 no conflicting device
+ */
+int loopcxt_check_conflict(struct loopdev_cxt *lc, const char *filename,
+			   uint64_t offset, uint64_t sizelimit)
+{
+	int rc, hasst;
+	struct stat st;
+
+	if (!filename)
+		return -EINVAL;
+
+	hasst = !stat(filename, &st);
+
+	rc = loopcxt_init_iterator(lc, LOOPITER_FL_USED);
+	if (rc)
+		return rc;
+
+	while ((rc = loopcxt_next(lc)) == 0) {
+		uint64_t lc_sizelimit, lc_offset;
+
+		rc = loopcxt_is_used(lc, hasst ? &st : NULL,
+				     filename, offset, sizelimit, 0);
+		if (!rc)
+			continue;
+		if (rc != 1)
+			break;
+		DBG(CXT, ul_debugobj(lc, "found %s backed by %s",
+			loopcxt_get_device(lc), filename));
+		rc = loopcxt_get_offset(lc, &lc_offset);
+		if (rc) {
+			DBG(CXT, ul_debugobj(lc, "failed to get offset for device %s",
+				loopcxt_get_device(lc)));
+			break;
+		}
+		rc = loopcxt_get_sizelimit(lc, &lc_sizelimit);
+		if (rc) {
+			DBG(CXT, ul_debugobj(lc, "failed to get sizelimit for device %s",
+				loopcxt_get_device(lc)));
+			break;
+		}
+
+		if (lc_sizelimit != 0 && offset >= lc_offset + lc_sizelimit)
+			continue;
+		if (sizelimit != 0 && offset + sizelimit <= lc_offset)
+			continue;
+		DBG(CXT, ul_debugobj(lc, "overlapping loop device %s",
+			loopcxt_get_device(lc)));
+			rc = 0;
+			break;
+	}
+	loopcxt_deinit_iterator(lc);
+	return rc;
+}
+
+/*
  * Returns allocated string with device name
  */
 char *loopdev_find_by_backing_file(const char *filename, uint64_t offset, uint64_t sizelimit, int flags)
-- 
2.9.0

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

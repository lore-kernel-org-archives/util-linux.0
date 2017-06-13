Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:58992 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752326AbdFMPcn (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 13 Jun 2017 11:32:43 -0400
Received: from adsiz.fritz.box ([146.52.24.88]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LtlG5-1dmoK13IZx-011DQh for
 <util-linux@vger.kernel.org>; Tue, 13 Jun 2017 17:32:36 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/5] libsmartcols: fix warning "unused parameter"
Date: Tue, 13 Jun 2017 17:32:33 +0200
Message-Id: <20170613153235.11164-4-sweet_f_a@gmx.de>
In-Reply-To: <20170613153235.11164-1-sweet_f_a@gmx.de>
References: <20170613153235.11164-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Noticed on OSX.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libsmartcols/src/table_print.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/libsmartcols/src/table_print.c b/libsmartcols/src/table_print.c
index 691a4b2f8..73250c68a 100644
--- a/libsmartcols/src/table_print.c
+++ b/libsmartcols/src/table_print.c
@@ -1635,9 +1635,9 @@ int scols_print_table(struct libscols_table *tb)
  *
  * Returns: 0, a negative value in case of an error.
  */
+#ifdef HAVE_OPEN_MEMSTREAM
 int scols_print_table_to_string(struct libscols_table *tb, char **data)
 {
-#ifdef HAVE_OPEN_MEMSTREAM
 	FILE *stream, *old_stream;
 	size_t sz;
 	int rc;
@@ -1659,8 +1659,13 @@ int scols_print_table_to_string(struct libscols_table *tb, char **data)
 	scols_table_set_stream(tb, old_stream);
 
 	return rc;
+}
 #else
+int scols_print_table_to_string(
+		struct libscols_table *tb __attribute__((__unused__)),
+		char **data  __attribute__((__unused__)))
+{
 	return -ENOSYS;
-#endif
 }
+#endif
 
-- 
2.12.3


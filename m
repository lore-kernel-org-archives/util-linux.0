Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:34183 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753172Ab1ISN3S (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 19 Sep 2011 09:29:18 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 255928EE5B
	for <util-linux@vger.kernel.org>; Mon, 19 Sep 2011 15:29:18 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/7] sfdisk: introduce get_ull() function
Date: Mon, 19 Sep 2011 15:29:13 +0200
Message-Id: <1316438955-20790-6-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1316438955-20790-1-git-send-email-petr.uzel@suse.cz>
References: <1316438955-20790-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 fdisk/sfdisk.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
index 9c94185..fe51908 100644
--- a/fdisk/sfdisk.c
+++ b/fdisk/sfdisk.c
@@ -1861,6 +1861,44 @@ get_ul(char *u, unsigned long *up, unsigned long def, int base) {
     return 0;
 }
 
+
+/* read a number, use default if absent */
+/* a sign gives an offset from the default */
+static int
+get_ull(char *u, unsigned long long *up, unsigned long long def, int base) {
+    char *nu;
+    int sign = 0;
+    unsigned long long val;
+
+    if (*u == '+') {
+	sign = 1;
+	u++;
+    } else if (*u == '-') {
+	sign = -1;
+	u++;
+    }
+    if (*u) {
+	errno = 0;
+	val = strtoull(u, &nu, base);
+	if (errno == ERANGE) {
+	    do_warn(_("number too big\n"));
+	    return -1;
+	}
+	if (*nu) {
+	    do_warn(_("trailing junk after number\n"));
+	    return -1;
+	}
+	if (sign == 1)
+	    val = def + val;
+	else if (sign == -1)
+	    val = def - val;
+	*up = val;
+    } else
+	*up = def;
+    return 0;
+}
+
+
 /* There are two common ways to structure extended partitions:
    as nested boxes, and as a chain. Sometimes the partitions
    must be given in order. Sometimes all logical partitions
-- 
1.7.3.4


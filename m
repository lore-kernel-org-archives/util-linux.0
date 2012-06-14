Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:40937 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756038Ab2FNONT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Jun 2012 10:13:19 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 4E07093182
	for <util-linux@vger.kernel.org>; Thu, 14 Jun 2012 16:13:18 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 3/3] libmount: fix trivial typos
Date: Thu, 14 Jun 2012 16:13:03 +0200
Message-Id: <1339683183-21804-3-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1339683183-21804-1-git-send-email-petr.uzel@suse.cz>
References: <1339683183-21804-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 libmount/src/context_mount.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
index e00fbe9..36dc414 100644
--- a/libmount/src/context_mount.c
+++ b/libmount/src/context_mount.c
@@ -168,7 +168,7 @@ done:
 }
 
 /*
- * Converts already evalulated and fixed options to the form that is compatible
+ * Converts already evaluated and fixed options to the form that is compatible
  * with /sbin/mount.type helpers.
  */
 static int generate_helper_optstr(struct libmnt_context *cxt, char **optstr)
@@ -182,7 +182,7 @@ static int generate_helper_optstr(struct libmnt_context *cxt, char **optstr)
 	assert(cxt->fs);
 	assert(optstr);
 
-	DBG(CXT, mnt_debug_h(cxt, "mount: generate heper mount options"));
+	DBG(CXT, mnt_debug_h(cxt, "mount: generate helper mount options"));
 
 	*optstr = mnt_fs_strdup_options(cxt->fs);
 	if (!*optstr)
-- 
1.7.7


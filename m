Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:63323 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab2GYTPx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:15:53 -0400
Received: by weyx8 with SMTP id x8so794233wey.19
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:15:52 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 02/19] libmount: fix shadow declaration
Date: Wed, 25 Jul 2012 21:15:23 +0200
Message-Id: <1343243745-1172-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

libmount/src/tab_update.c:203:8: warning: declaration of 'rc' shadows a previous local [-Wshadow]
libmount/src/tab_update.c:159:6: warning: shadowed declaration is here [-Wshadow]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libmount/src/tab_update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libmount/src/tab_update.c b/libmount/src/tab_update.c
index 56e87cf..caabd05 100644
--- a/libmount/src/tab_update.c
+++ b/libmount/src/tab_update.c
@@ -200,7 +200,7 @@ int mnt_update_set_fs(struct libmnt_update *upd, unsigned long mountflags,
 
 	} else if (fs) {
 		if (upd->userspace_only && !(mountflags & MS_MOVE)) {
-			int rc = utab_new_entry(upd, fs, mountflags);
+			rc = utab_new_entry(upd, fs, mountflags);
 			if (rc)
 				return rc;
 		} else {
-- 
1.7.11.3


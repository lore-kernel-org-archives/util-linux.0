Return-Path: util-linux-owner@vger.kernel.org
Received: from hzn01.notanisp.net ([88.198.64.134]:45992 "EHLO goatse.co.uk"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750923AbaGZUbS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 26 Jul 2014 16:31:18 -0400
From: bobtfish@bobtfish.net
To: util-linux@vger.kernel.org
Cc: Tomas Doran <bobtfish@bobtfish.net>
Subject: [PATCH] Setting uid / gid is generally useful in nseneter
Date: Sat, 26 Jul 2014 13:22:54 -0700
Message-Id: <1406406174-20938-1-git-send-email-bobtfish@bobtfish.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Tomas Doran <bobtfish@bobtfish.net>

It's useful to be able to set the UID/GID even when not using user namespaces
(for example when creating a non-root shell in a pre-existing docker container)

Signed-off-by: Tomas Doran <bobtfish@bobtfish.net>
---
 sys-utils/nsenter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index d57edc8..23798f9 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -328,7 +328,7 @@ int main(int argc, char *argv[])
 	if (do_fork == 1)
 		continue_as_child();
 
-	if (namespaces & CLONE_NEWUSER) {
+	if (uid > 0 || gid > 0) {
 		if (setgroups(0, NULL))		/* drop supplementary groups */
 			err(EXIT_FAILURE, _("setgroups failed"));
 		if (setgid(gid) < 0)
-- 
2.0.1


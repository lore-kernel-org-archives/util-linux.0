Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:59611 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320Ab3CAEBw (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 28 Feb 2013 23:01:52 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 9F84733DC51
	for <util-linux-ng@vger.kernel.org>; Fri,  1 Mar 2013 04:01:51 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux-ng@vger.kernel.org
Subject: [PATCH 2/2] unshare: tweak style
Date: Thu, 28 Feb 2013 23:03:02 -0500
Message-Id: <1362110582-23406-2-git-send-email-vapier@gentoo.org>
In-Reply-To: <1362110582-23406-1-git-send-email-vapier@gentoo.org>
References: <1362110582-23406-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sys-utils/unshare.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 2eea165..8cc9c46 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -78,8 +78,8 @@ int main(int argc, char *argv[])
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while((c = getopt_long(argc, argv, "hVmuinpU", longopts, NULL)) != -1) {
-		switch(c) {
+	while ((c = getopt_long(argc, argv, "hVmuinpU", longopts, NULL)) != -1) {
+		switch (c) {
 		case 'h':
 			usage(EXIT_SUCCESS);
 		case 'V':
@@ -108,7 +108,7 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if(-1 == unshare(unshare_flags))
+	if (-1 == unshare(unshare_flags))
 		err(EXIT_FAILURE, _("unshare failed"));
 
 	if (optind < argc) {
-- 
1.8.1.2


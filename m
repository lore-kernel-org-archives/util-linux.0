Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51948 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752Ab2BZLGx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 26 Feb 2012 06:06:53 -0500
Received: by pbcup15 with SMTP id up15so1069957pbc.19
        for <util-linux@vger.kernel.org>; Sun, 26 Feb 2012 03:06:53 -0800 (PST)
From: raghu.prabhu13@gmail.com
To: util-linux@vger.kernel.org
Cc: raghu.prabhu13@gmail.com, Raghavendra D Prabhu <rprabhu@wnohang.net>
Subject: [PATCH] [PATCH] Add 'internal-only(i)' to non-root allowed option
Date: Sun, 26 Feb 2012 16:36:42 +0530
Message-Id: <af8e3d24976a99c6f478f4db27a59d7abb8842ee.1330254236.git.rprabhu@wnohang.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Raghavendra D Prabhu <rprabhu@wnohang.net>

Commit ce433404 introduced the change, which causes something like mount -i
<user-mount-path> to break which worked well before util-linux-2.21, now it
gives message 'mount: only root can use "--internal-only" option' when that
shouldn't be the case when it is already in fstab.

Signed-off-by: Raghavendra D Prabhu <rprabhu@wnohang.net>
---
 sys-utils/mount.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/mount.c b/sys-utils/mount.c
index 3fbac04..d2ed296 100644
--- a/sys-utils/mount.c
+++ b/sys-utils/mount.c
@@ -708,7 +708,7 @@ int main(int argc, char **argv)
 					longopts, NULL)) != -1) {
 
 		/* only few options are allowed for non-root users */
-		if (mnt_context_is_restricted(cxt) && !strchr("hlLUVvpr", c))
+		if (mnt_context_is_restricted(cxt) && !strchr("hlLUVvpri", c))
 			exit_non_root(option_to_longopt(c, longopts));
 
 		switch(c) {
-- 
1.7.9.2


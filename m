Return-Path: richard@nod.at
From: Richard Weinberger <richard@nod.at>
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH] [RFC] switch_root: Add a sanity check
Date: Sat,  9 Feb 2013 19:22:50 +0100
Message-Id: <1360434170-27206-1-git-send-email-richard@nod.at>
List-ID: <util-linux.vger.kernel.org>

As switch_root basically does rm -Rf / we should make sure
that / is really an initramfs.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 sys-utils/switch_root.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/sys-utils/switch_root.c b/sys-utils/switch_root.c
index f0ef677..f26f7da 100644
--- a/sys-utils/switch_root.c
+++ b/sys-utils/switch_root.c
@@ -174,7 +174,13 @@ static int switchroot(const char *newroot)
 	if (cfd >= 0) {
 		pid = fork();
 		if (pid <= 0) {
-			recursiveRemove(cfd);
+			if (fstat(cfd, &sb) == 0) {
+				if (sb.st_dev == makedev(0, 1))
+					recursiveRemove(cfd);
+				else
+					warn(_("old root filesystem is not an initramfs"));
+			}
+
 			if (pid == 0)
 				exit(EXIT_SUCCESS);
 		}
-- 
1.7.7.3

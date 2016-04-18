Return-Path: util-linux-owner@vger.kernel.org
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50112 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751223AbcDRM0f (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Apr 2016 08:26:35 -0400
Message-ID: <1460982392.2452.6.camel@HansenPartnership.com>
Subject: [PATCH] nsenter: fix ability to enter unprivileged containers
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: util-linux@vger.kernel.org
Cc: ebiederm@xmission.com
Date: Mon, 18 Apr 2016 08:26:32 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If you enter it first, you lose privilege for subsequent namespace
enters,see issue

https://github.com/karelzak/util-linux/issues/315

The fix is to enter the user namespace last of all.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index d8690db..1525f15 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -52,13 +52,13 @@ static struct namespace_file {
 	 * first.  This gives an unprivileged user the potential to
 	 * enter the other namespaces.
 	 */
-	{ .nstype = CLONE_NEWUSER,  .name = "ns/user", .fd = -1 },
 	{ .nstype = CLONE_NEWCGROUP,.name = "ns/cgroup", .fd = -1 },
 	{ .nstype = CLONE_NEWIPC,   .name = "ns/ipc",  .fd = -1 },
 	{ .nstype = CLONE_NEWUTS,   .name = "ns/uts",  .fd = -1 },
 	{ .nstype = CLONE_NEWNET,   .name = "ns/net",  .fd = -1 },
 	{ .nstype = CLONE_NEWPID,   .name = "ns/pid",  .fd = -1 },
 	{ .nstype = CLONE_NEWNS,    .name = "ns/mnt",  .fd = -1 },
+	{ .nstype = CLONE_NEWUSER,  .name = "ns/user", .fd = -1 },
 	{ .nstype = 0, .name = NULL, .fd = -1 }
 };
 

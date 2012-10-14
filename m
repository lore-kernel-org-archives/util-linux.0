Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:53859 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415Ab2JNUWe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:22:34 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so1296598wib.1
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:22:33 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/13] ipcs: add new permissions printing function
Date: Sun, 14 Oct 2012 21:22:16 +0100
Message-Id: <1350246145-10600-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
References: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The function has silly name which eventually will be fixed, once the
current print_perms() that uses legacy structures is obsoleted.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/ipcs.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index 4737f28..8ac7e1c 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -439,6 +439,31 @@ static void print_perms (int id, struct ipc_perm *ipcp)
 	else
 		printf(" %-10u\n", ipcp->gid);
 }
+static void FIXED_print_perms(struct ipc_stat *is)
+{
+	struct passwd *pw;
+	struct group *gr;
+
+	printf("%-10d %-10o", is->id, is->mode & 0777);
+
+	if ((pw = getpwuid(is->cuid)))
+		printf(" %-10s", pw->pw_name);
+	else
+		printf(" %-10u", is->cuid);
+	if ((gr = getgrgid(is->cgid)))
+		printf(" %-10s", gr->gr_name);
+	else
+		printf(" %-10u", is->cgid);
+
+	if ((pw = getpwuid(is->uid)))
+		printf(" %-10s", pw->pw_name);
+	else
+		printf(" %-10u", is->uid);
+	if ((gr = getgrgid(is->gid)))
+		printf(" %-10s\n", gr->gr_name);
+	else
+		printf(" %-10u\n", is->gid);
+}
 
 void do_shm (char format, int use_proc)
 {
-- 
1.7.12.3


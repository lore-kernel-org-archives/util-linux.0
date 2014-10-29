Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.alpinelinux.org ([74.117.189.114]:40908 "EHLO
	mail.alpinelinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756043AbaJ2IRS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 29 Oct 2014 04:17:18 -0400
From: Natanael Copa <ncopa@alpinelinux.org>
To: util-linux@vger.kernel.org
Cc: Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH] hexdump: use 'll' format modifier instead of the non-standard 'q'.
Date: Wed, 29 Oct 2014 08:07:31 +0000
Message-Id: <1414570051-11374-1-git-send-email-ncopa@alpinelinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The printf(3) man page says about 'q':
("quad". 4.4BSD and Linux libc5 only. Don't use.) This is a synonym for ll.

This fixes hexdump with musl libc.

Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
---
 text-utils/hexdump-parse.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/text-utils/hexdump-parse.c b/text-utils/hexdump-parse.c
index 8d14c5b..98e1972 100644
--- a/text-utils/hexdump-parse.c
+++ b/text-utils/hexdump-parse.c
@@ -226,7 +226,7 @@ void rewrite_rules(struct hexdump_fs *fs, struct hexdump *hex)
 	struct hexdump_fu *fu;
 	struct list_head *p, *q;
 	char *p1, *p2, *fmtp;
-	char savech, cs[3];
+	char savech, cs[4];
 	int nconv, prec = 0;
 
 	list_for_each (p, &fs->fulist) {
@@ -301,9 +301,10 @@ void rewrite_rules(struct hexdump_fs *fs, struct hexdump *hex)
 				goto isint;
 			} else if (first_letter(cs, "ouxX")) {
 				pr->flags = F_UINT;
-isint:				cs[2] = '\0';
-				cs[1] = cs[0];
-				cs[0] = 'q';
+isint:				cs[3] = '\0';
+				cs[2] = cs[0];
+				cs[1] = 'l'
+				cs[0] = 'l';
 				switch(fu->bcnt) {
 					case 0:
 						pr->bcnt = 4;
@@ -355,9 +356,10 @@ isint:				cs[2] = '\0';
 						pr->flags = F_ADDRESS;
 						++p2;
 						if (first_letter(p1 + 2, "dox")) {
-							cs[0] = 'q';
-							cs[1] = p1[2];
-							cs[2] = '\0';
+							cs[0] = 'l';
+							cs[1] = 'l';
+							cs[2] = p1[2];
+							cs[3] = '\0';
 						} else {
 							p1[3] = '\0';
 							badconv(p1);
-- 
2.1.2


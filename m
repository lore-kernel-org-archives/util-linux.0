Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.alpinelinux.org ([74.117.189.114]:51850 "EHLO
	mail.alpinelinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755468AbaJ2JEp (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 29 Oct 2014 05:04:45 -0400
From: Natanael Copa <ncopa@alpinelinux.org>
To: util-linux@vger.kernel.org
Cc: Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH v2] hexdump: use 'll' format modifier instead of the non-standard 'q'.
Date: Wed, 29 Oct 2014 09:04:27 +0000
Message-Id: <1414573467-15174-1-git-send-email-ncopa@alpinelinux.org>
In-Reply-To: <1414570051-11374-1-git-send-email-ncopa@alpinelinux.org>
References: <1414570051-11374-1-git-send-email-ncopa@alpinelinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The printf(3) man page says about 'q':
("quad". 4.4BSD and Linux libc5 only. Don't use.) This is a synonym for ll.

This fixes hexdump with musl libc.

Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
---

Changes v1 -> v2:

> @@ -301,9 +301,10 @@ void rewrite_rules(struct hexdump_fs *fs, struct hexdump *hex)
>                               goto isint;
>                       } else if (first_letter(cs, "ouxX")) {
>                               pr->flags = F_UINT;
> -isint:                               cs[2] = '\0';
> -                             cs[1] = cs[0];
> -                             cs[0] = 'q';
> +isint:                               cs[3] = '\0';
> +                             cs[2] = cs[0];
> +                             cs[1] = 'l'
add missing ; above                       ^^^


I missed the ; when rebasing the patch. sorry.

This patch have been used in Alpine Linux since May 2014:
http://git.alpinelinux.org/cgit/aports/commit/main/util-linux?id=3c201cf3c1b78959444efa8cc2c49ecff7a6727c


 text-utils/hexdump-parse.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/text-utils/hexdump-parse.c b/text-utils/hexdump-parse.c
index 8d14c5b..9eb016d 100644
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
+				cs[1] = 'l';
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


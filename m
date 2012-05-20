Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdccah.dreamhost.com ([208.97.132.207]:35512 "EHLO
	homiemail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752606Ab2ETQLX (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 20 May 2012 12:11:23 -0400
Subject: [PATCH 1/6] fdisk: add an quit/exit handling function
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 20 May 2012 18:11:21 +0200
Message-ID: <1337530281.2677.12.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 3f83297..2f3c119 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -1810,6 +1810,13 @@ move_begin(int i) {
 	}
 }
 
+static void __attribute__ ((__noreturn__)) handle_quit(void)
+{
+	close(fd);
+	printf("\n");
+	exit(EXIT_SUCCESS);
+}
+
 static void
 expert_command_prompt(void)
 {
@@ -1875,9 +1882,7 @@ expert_command_prompt(void)
 				x_list_table(0);
 			break;
 		case 'q':
-			close(fd);
-			printf("\n");
-			exit(0);
+			handle_quit();
 		case 'r':
 			return;
 		case 's':
@@ -2064,9 +2069,7 @@ static void command_prompt(void)
 			list_table(0);
 			break;
 		case 'q':
-			close(fd);
-			printf("\n");
-			exit(0);
+			handle_quit();
 		case 's':
 			create_sunlabel();
 			break;
-- 
1.7.4.1





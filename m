Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbef.dreamhost.com ([208.97.132.145]:51022 "EHLO
	homiemail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752160Ab2E0ToN (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 27 May 2012 15:44:13 -0400
Subject: [PATCH 3/7] fdisk: remove useless comments
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 27 May 2012 21:44:07 +0200
Message-ID: <1338147847.22474.2.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index b304fe3..3e15b6b 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -1887,7 +1887,7 @@ expert_command_prompt(struct fdisk_context *cxt)
 			verify();
 			break;
 		case 'w':
-			write_table(cxt); 	/* does not return */
+			write_table(cxt);
 			break;
 		case 'y':
 			if (disklabel == SUN_LABEL)
@@ -2084,7 +2084,7 @@ static void command_prompt(struct fdisk_context *cxt)
 			verify();
 			break;
 		case 'w':
-			write_table(cxt); 		/* does not return */
+			write_table(cxt);
 			break;
 		case 'x':
 			expert_command_prompt(cxt);
-- 
1.7.4.1





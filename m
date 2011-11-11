Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58483 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616Ab1KKKMt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 11 Nov 2011 05:12:49 -0500
Received: by mail-wy0-f174.google.com with SMTP id 15so3671797wyh.19
        for <util-linux@vger.kernel.org>; Fri, 11 Nov 2011 02:12:48 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 5/5] fdisk: enable expert menu with SGI label
Date: Fri, 11 Nov 2011 11:12:11 +0100
Message-Id: <1321006331-7633-5-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1321006331-7633-1-git-send-email-cosoleto@gmail.com>
References: <1321006331-7633-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This allows the creation of a new label if the disk already has an existing
SGI disklabel without working around this problem such as creating a DOS
disklabel or overwriting with zero the partition table (problem reported in
'Gentoo Linux/MIPS Handbook').

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 fdisk/fdisk.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 934d458..9ca3f2b 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -103,7 +103,7 @@ static const struct menulist_descr menulist[] = {
 	{'e', N_("list extended partitions"), {0, DOS_LABEL}},
 	{'e', N_("edit drive data"), {OSF_LABEL, 0}},
 	{'f', N_("fix partition order"), {0, DOS_LABEL}},
-	{'g', N_("create an IRIX (SGI) partition table"), {0, DOS_LABEL | SGI_LABEL}},
+	{'g', N_("create an IRIX (SGI) partition table"), {0, ANY_LABEL}},
 	{'h', N_("change number of heads"), {0, DOS_LABEL | SUN_LABEL}},
 	{'i', N_("change interleave factor"), {0, SUN_LABEL}},
 	{'i', N_("change the disk identifier"), {0, DOS_LABEL}},
@@ -124,7 +124,7 @@ static const struct menulist_descr menulist[] = {
 	{'v', N_("verify the partition table"), {DOS_LABEL | SUN_LABEL | SGI_LABEL, DOS_LABEL | SUN_LABEL | SGI_LABEL}},
 	{'w', N_("write table to disk and exit"), {DOS_LABEL | SUN_LABEL | SGI_LABEL, DOS_LABEL | SUN_LABEL | SGI_LABEL}},
 	{'w', N_("write disklabel to disk"), {OSF_LABEL, 0}},
-	{'x', N_("extra functionality (experts only)"), {DOS_LABEL | SUN_LABEL, 0}},
+	{'x', N_("extra functionality (experts only)"), {DOS_LABEL | SUN_LABEL | SGI_LABEL, 0}},
 #if !defined (__alpha__)
 	{'x', N_("link BSD partition to non-BSD partition"), {OSF_LABEL, 0}},
 #endif
@@ -2985,12 +2985,7 @@ static void command_prompt(void)
 			write_table(); 		/* does not return */
 			break;
 		case 'x':
-			if (disklabel == SGI_LABEL) {
-				fprintf(stderr,
-					_("\n\tSorry, no experts menu for SGI "
-					"partition tables available.\n\n"));
-			} else
-				expert_command_prompt();
+			expert_command_prompt();
 			break;
 		default:
 			unknown_command(c);
-- 
1.7.3.4


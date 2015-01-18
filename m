Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:58615 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752364AbbARQVy (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 18 Jan 2015 11:21:54 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] cfdisk: shorten the help screen to make it fit within 25 lines
Date: Sun, 18 Jan 2015 17:21:25 +0100
Message-Id: <1421598085-4394-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1421598085-4394-1-git-send-email-bensberg@justemail.net>
References: <1421598085-4394-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When the terminal has less than 32 lines, the new cfdisk ignored the
fact that the help-screen text was longer and just skipped printing
the remaining lines.  Instead of introducing a minipager for the help
screen, just condense its text and remove unneeded lines.  Now the
text occupies just 25 lines, which should fit on most terminals.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/cfdisk.c |   21 +++++++--------------
 1 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index b461b21..bad8681 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -1797,14 +1797,8 @@ static int ui_help(void)
 {
 	size_t i;
 	static const char *help[] = {
-		N_("Help Screen for cfdisk"),
-		"  ",
-		N_("This is cfdisk, a curses based disk partitioning program, which"),
-		N_("allows you to create, delete and modify partitions on your hard"),
-		N_("disk drive."),
-		"  ",
-		N_("Copyright (C) 2014 Karel Zak <kzak@redhat.com> "),
-		N_("Based on the original cfdisk from Kevin E. Martin & aeb."),
+		N_("This is cfdisk, a curses-based disk partitioning program."),
+		N_("It lets you create, delete, and modify partitions on a block device."),
 		"  ",
 		N_("Command      Meaning"),
 		N_("-------      -------"),
@@ -1813,20 +1807,19 @@ static int ui_help(void)
 		N_("  h          Print this screen"),
 		N_("  n          Create new partition from free space"),
 		N_("  q          Quit program without writing partition table"),
-		N_("  t          Change the partition type"),
 		N_("  s          Fix partitions order (only when in disarray)"),
+		N_("  t          Change the partition type"),
 		N_("  u          Dump disk layout to sfdisk compatible script file"),
-		N_("  W          Write partition table to disk (must enter upper case W)"),
-		N_("             Since this might destroy data on the disk, you must"),
-		N_("             either confirm or deny the write by entering `yes' or"),
-		N_("             `no'"),
+		N_("  W          Write partition table to disk (you must enter uppercase W);"),
+		N_("               since this might destroy data on the disk, you must either"),
+		N_("               confirm or deny the write by entering 'yes' or 'no'"),
 		N_("Up Arrow     Move cursor to the previous partition"),
 		N_("Down Arrow   Move cursor to the next partition"),
 		N_("Left Arrow   Move cursor to the previous menu item"),
 		N_("Right Arrow  Move cursor to the next menu item"),
 		"  ",
 		N_("Note: All of the commands can be entered with either upper or lower"),
-		N_("case letters (except for Writes)."),
+		N_("case letters (except for Write)."),
 		"  ",
 		N_("Use lsblk(8) or partx(8) to see more details about the device.")
 	};
-- 
1.7.0.4


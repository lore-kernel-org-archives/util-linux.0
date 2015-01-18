Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews10.kpnxchange.com ([213.75.39.15]:58388 "EHLO
	cpsmtpb-ews10.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751899AbbARQVe (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 18 Jan 2015 11:21:34 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] cfdisk: don't mess up the help screen by printing the PO file header
Date: Sun, 18 Jan 2015 17:21:24 +0100
Message-Id: <1421598085-4394-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Asking for the translation of the empty string ("") produces the header
of the PO file corresponding to the current locale, which messes up the
help screen.  So, don't use empty strings in the array of help strings
but (arbitrary) double spaces.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/cfdisk.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index 1d4e2d5..b461b21 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -1798,14 +1798,14 @@ static int ui_help(void)
 	size_t i;
 	static const char *help[] = {
 		N_("Help Screen for cfdisk"),
-		"",
+		"  ",
 		N_("This is cfdisk, a curses based disk partitioning program, which"),
 		N_("allows you to create, delete and modify partitions on your hard"),
 		N_("disk drive."),
-		"",
+		"  ",
 		N_("Copyright (C) 2014 Karel Zak <kzak@redhat.com> "),
 		N_("Based on the original cfdisk from Kevin E. Martin & aeb."),
-		"",
+		"  ",
 		N_("Command      Meaning"),
 		N_("-------      -------"),
 		N_("  b          Toggle bootable flag of the current partition"),
@@ -1824,11 +1824,10 @@ static int ui_help(void)
 		N_("Down Arrow   Move cursor to the next partition"),
 		N_("Left Arrow   Move cursor to the previous menu item"),
 		N_("Right Arrow  Move cursor to the next menu item"),
-
-		"",
+		"  ",
 		N_("Note: All of the commands can be entered with either upper or lower"),
 		N_("case letters (except for Writes)."),
-		"",
+		"  ",
 		N_("Use lsblk(8) or partx(8) to see more details about the device.")
 	};
 
-- 
1.7.0.4


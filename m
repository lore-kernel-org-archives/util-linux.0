Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55038 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581Ab1HPWTM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 16 Aug 2011 18:19:12 -0400
Received: by wwf5 with SMTP id 5so398671wwf.1
        for <util-linux@vger.kernel.org>; Tue, 16 Aug 2011 15:19:11 -0700 (PDT)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 3/5] fdisk: print welcome message
Date: Wed, 17 Aug 2011 00:19:04 +0200
Message-Id: <1313533146-2806-3-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1313533146-2806-1-git-send-email-cosoleto@gmail.com>
References: <1313533146-2806-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This adds a welcome message with util-linux version number, information
about fdisk behaviour that doesn't write to disk after a command (unlike
gparted) and a warning about possible data loss.

The message appears just before the first command prompt.

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 fdisk/fdisk.c         |   10 +++++-----
 fdisk/fdisksgilabel.c |    4 +---
 fdisk/fdisksunlabel.c |    4 +---
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index d3fc200..1c1f492 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -932,11 +932,7 @@ static void
 create_doslabel(void) {
 	unsigned int id = get_random_id();
 
-	fprintf(stderr,
-	_("Building a new DOS disklabel with disk identifier 0x%08x.\n"
-	  "Changes will remain in memory only, until you decide to write them.\n"
-	  "After that, of course, the previous content won't be recoverable.\n\n"),
-		id);
+	fprintf(stderr, _("Building a new DOS disklabel with disk identifier 0x%08x.\n"), id);
 	sun_nolabel();  /* otherwise always recognised as sun */
 	sgi_nolabel();  /* otherwise always recognised as sgi */
 	disklabel = DOS_LABEL;
@@ -3093,6 +3089,10 @@ main(int argc, char **argv) {
 		disklabel = DOS_LABEL;
 	}
 
+	fprintf(stderr, _("Welcome to fdisk (%s).\n\n"
+		"Changes will remain in memory only, until you decide to write them.\n"
+		"Be careful before using the write command.\n"), PACKAGE_STRING);
+
 	while (1) {
 		putchar('\n');
 		c = tolower(read_char(_("Command (m for help): ")));
diff --git a/fdisk/fdisksgilabel.c b/fdisk/fdisksgilabel.c
index 20ed92d..c553abc 100644
--- a/fdisk/fdisksgilabel.c
+++ b/fdisk/fdisksgilabel.c
@@ -697,9 +697,7 @@ create_sgilabel(void)
 	sec_fac = sector_size / 512;	/* determine the sector factor */
 
 	fprintf(stderr,
-		_("Building a new SGI disklabel. Changes will remain in memory only,\n"
-		  "until you decide to write them. After that, of course, the previous\n"
-		  "content will be unrecoverably lost.\n\n"));
+		_("Building a new SGI disklabel.\n"));
 
 	other_endian = (BYTE_ORDER == LITTLE_ENDIAN);
 
diff --git a/fdisk/fdisksunlabel.c b/fdisk/fdisksunlabel.c
index 7d3aa09..80408dd 100644
--- a/fdisk/fdisksunlabel.c
+++ b/fdisk/fdisksunlabel.c
@@ -189,9 +189,7 @@ void create_sunlabel(void)
 	int res;
 
 	fprintf(stderr,
-	_("Building a new sun disklabel. Changes will remain in memory only,\n"
-       	"until you decide to write them. After that, of course, the previous\n"
-	"content won't be recoverable.\n\n"));
+	_("Building a new Sun disklabel.\n"));
 #if BYTE_ORDER == LITTLE_ENDIAN
 	other_endian = 1;
 #else
-- 
1.7.3.4


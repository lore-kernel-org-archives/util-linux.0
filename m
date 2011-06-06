Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ew0-f46.google.com ([209.85.215.46]:63725 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716Ab1FFTH1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 6 Jun 2011 15:07:27 -0400
Received: by ewy4 with SMTP id 4so1471009ewy.19
        for <util-linux@vger.kernel.org>; Mon, 06 Jun 2011 12:07:26 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/6] sfdisk: declare unused function attributes
Date: Mon,  6 Jun 2011 21:07:14 +0200
Message-Id: <1307387239-9022-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1307387239-9022-1-git-send-email-kerolasa@iki.fi>
References: <1307387239-9022-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add `__attribute__ ((__unused__))' where needed.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 fdisk/sfdisk.c |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
index c38128a..8d8ccea 100644
--- a/fdisk/sfdisk.c
+++ b/fdisk/sfdisk.c
@@ -1590,17 +1590,29 @@ msdos_partition(char *dev, int fd, unsigned long start, struct disk_desc *z) {
 }
 
 static int
-osf_partition(char *dev, int fd, unsigned long start, struct disk_desc *z) {
+osf_partition(char *dev __attribute__ ((__unused__)),
+	      int fd __attribute__ ((__unused__)),
+	      unsigned long start __attribute__ ((__unused__)),
+	      struct disk_desc *z __attribute__ ((__unused__)))
+{
 	return 0;
 }
 
 static int
-sun_partition(char *dev, int fd, unsigned long start, struct disk_desc *z) {
+sun_partition(char *dev __attribute__ ((__unused__)),
+	      int fd __attribute__ ((__unused__)),
+	      unsigned long start __attribute__ ((__unused__)),
+	      struct disk_desc *z __attribute__ ((__unused__)))
+{
 	return 0;
 }
 
 static int
-amiga_partition(char *dev, int fd, unsigned long start, struct disk_desc *z) {
+amiga_partition(char *dev __attribute__ ((__unused__)),
+		int fd __attribute__ ((__unused__)),
+		unsigned long start __attribute__ ((__unused__)),
+		struct disk_desc *z __attribute__ ((__unused__)))
+{
 	return 0;
 }
 
@@ -2348,7 +2360,7 @@ activate_usage(char *progn) {
 }
 
 static void
-unhide_usage(char *progn) {
+unhide_usage(char *progn __attribute__ ((__unused__))) {
     exit(1);
 }
 
-- 
1.7.5.2


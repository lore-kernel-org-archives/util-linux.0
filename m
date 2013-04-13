Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f181.google.com ([74.125.82.181]:36471 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701Ab3DMTze (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:55:34 -0400
Received: by mail-we0-f181.google.com with SMTP id r6so1089687wey.40
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:55:33 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/33] cfdisk: check writing to a file was successful
Date: Sat, 13 Apr 2013 20:54:38 +0100
Message-Id: <1365882901-11429-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 fdisks/cfdisk.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fdisks/cfdisk.c b/fdisks/cfdisk.c
index db9e233..dcaa05d 100644
--- a/fdisks/cfdisk.c
+++ b/fdisks/cfdisk.c
@@ -1849,7 +1849,11 @@ print_raw_table(void) {
 
     if (to_file) {
 	if (!print_only)
-	    fclose(fp);
+	    if (close_stream(fp) != 0) {
+		char errstr[LINE_LENGTH];
+		snprintf(errstr, sizeof(errstr), _("write failed: %s"), fname);
+		print_warning(errstr);
+	    }
     } else {
         menuContinue();
     }
@@ -1966,7 +1970,11 @@ print_p_info(void) {
 
     if (to_file) {
 	if (!print_only)
-	    fclose(fp);
+	    if (close_stream(fp) != 0) {
+		char errstr[LINE_LENGTH];
+		snprintf(errstr, sizeof(errstr), _("write failed: %s"), fname);
+		print_warning(errstr);
+	    }
     } else {
         menuContinue();
     }
@@ -2060,7 +2068,11 @@ print_part_table(void) {
 
     if (to_file) {
 	if (!print_only)
-	    fclose(fp);
+	    if (close_stream(fp) != 0) {
+		char errstr[LINE_LENGTH];
+		snprintf(errstr, sizeof(errstr), _("write failed: %s"), fname);
+		print_warning(errstr);
+	    }
     } else {
         menuContinue();
     }
-- 
1.8.2.1


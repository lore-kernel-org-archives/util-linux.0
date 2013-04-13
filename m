Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f171.google.com ([74.125.82.171]:46143 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab3DMT4D (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:56:03 -0400
Received: by mail-we0-f171.google.com with SMTP id i48so1100169wef.30
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:56:02 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 20/33] cfdisk: check writing to a file descriptor was successful
Date: Sat, 13 Apr 2013 20:54:48 +0100
Message-Id: <1365882901-11429-21-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 fdisks/cfdisk.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fdisks/cfdisk.c b/fdisks/cfdisk.c
index dcaa05d..e685f71 100644
--- a/fdisks/cfdisk.c
+++ b/fdisks/cfdisk.c
@@ -406,8 +406,12 @@ static void
 fdexit(int ret) {
     if (opened) {
 	if (changed)
-		fsync(fd);
-	close(fd);
+	    if (close_fd(fd) != 0) {
+		fprintf(stderr, _("write failed\n"));
+		exit(2);
+	    }
+	else
+	    close(fd);
     }
     if (changed) {
 	fprintf(stderr, _("Disk has been changed.\n"));
-- 
1.8.2.1


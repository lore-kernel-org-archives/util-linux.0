Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f175.google.com ([74.125.82.175]:48131 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244Ab3DMT4O (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:56:14 -0400
Received: by mail-we0-f175.google.com with SMTP id t11so2824492wey.6
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:56:13 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 24/33] fsck.minix: check writing to a file descriptor was successful
Date: Sat, 13 Apr 2013 20:54:52 +0100
Message-Id: <1365882901-11429-25-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/fsck.minix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/disk-utils/fsck.minix.c b/disk-utils/fsck.minix.c
index 89e96fc..c0ed017 100644
--- a/disk-utils/fsck.minix.c
+++ b/disk-utils/fsck.minix.c
@@ -1385,6 +1385,8 @@ main(int argc, char **argv) {
 	if (repair && !automatic)
 		tcsetattr(STDIN_FILENO, TCSANOW, &termios);
 
+	if (close_fd(IN) != 0)
+		err(FSCK_EX_ERROR, _("write failed"));
 	if (changed)
 		retcode += 3;
 	if (errors_uncorrected)
-- 
1.8.2.1


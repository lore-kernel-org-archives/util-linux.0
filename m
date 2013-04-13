Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:40392 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab3DMT4U (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:56:20 -0400
Received: by mail-wi0-f174.google.com with SMTP id hj8so506676wib.13
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:56:19 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 26/33] mkfs.cramfs: unify write check to a file descriptor
Date: Sat, 13 Apr 2013 20:54:54 +0100
Message-Id: <1365882901-11429-27-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkfs.cramfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/disk-utils/mkfs.cramfs.c b/disk-utils/mkfs.cramfs.c
index b5edb7a..cb3e657 100644
--- a/disk-utils/mkfs.cramfs.c
+++ b/disk-utils/mkfs.cramfs.c
@@ -879,12 +879,11 @@ int main(int argc, char **argv)
 			(long long) fslen_ub, offset);
 
 	written = write(fd, rom_image, offset);
-	close(fd);
-	if (written < 0)
-		err(MKFS_EX_ERROR, _("ROM image"));
 	if (offset != written)
 		errx(MKFS_EX_ERROR, _("ROM image write failed (%zd %zd)"),
 			written, offset);
+	if (close_fd(fd) != 0)
+		err(MKFS_EX_ERROR, _("ROM image"));
 
 	/*
 	 * (These warnings used to come at the start, but they scroll off
-- 
1.8.2.1


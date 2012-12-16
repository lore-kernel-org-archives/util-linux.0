Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:36643 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614Ab2LPKoX (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Dec 2012 05:44:23 -0500
Received: by mail-we0-f174.google.com with SMTP id x10so2228563wey.19
        for <util-linux@vger.kernel.org>; Sun, 16 Dec 2012 02:44:22 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/14] isosize: inform if file does not look like iso file system
Date: Sun, 16 Dec 2012 10:43:54 +0000
Message-Id: <1355654642-22106-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
References: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

$ isosize /dev/urandom
isosize: /dev/urandom: might not be iso file system
-67690643227260

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/isosize.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/disk-utils/isosize.c b/disk-utils/isosize.c
index 625dd42..5f1a297 100644
--- a/disk-utils/isosize.c
+++ b/disk-utils/isosize.c
@@ -32,6 +32,14 @@
 
 #define ISODCL(from, to) (to - from + 1)
 
+static int is_iso(int fd)
+{
+	char label[8];
+	if (pread(fd, &label, 8, 0x8000) == -1)
+		return 1;
+	return memcmp(&label, &"\1CD001\1", 8);
+}
+
 static int isonum_721(unsigned char *p)
 {
 	return ((p[0] & 0xff)
@@ -124,6 +132,8 @@ static void isosize(char *filenamep, int xflag, long divisor)
 
 	if ((fd = open(filenamep, O_RDONLY)) < 0)
 		err(EXIT_FAILURE, _("cannot open %s"), filenamep);
+	if (is_iso(fd))
+		warnx(_("%s: might not be iso file system"), filenamep);
 
 	if (lseek(fd, 16 << 11, 0) == (off_t) - 1)
 		err(EXIT_FAILURE, _("seek error on %s"), filenamep);
-- 
1.8.0.2


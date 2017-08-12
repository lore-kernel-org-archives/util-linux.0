Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38493 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbdHLIcN (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 12 Aug 2017 04:32:13 -0400
Received: by mail-wr0-f195.google.com with SMTP id g32so3866584wrd.5
        for <util-linux@vger.kernel.org>; Sat, 12 Aug 2017 01:32:12 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] isosize: iterate over all arguments even when something fails
Date: Sat, 12 Aug 2017 09:32:07 +0100
Message-Id: <20170812083208.1208-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier the command exit too early if one of the arguments failed.  After
this change all arguments are examined, and command return value will have
information what happen during processing.

$ isosize /etc/shadow / ; echo $?
isosize: cannot open /etc/shadow: Permission denied
isosize: /: might not be an ISO filesystem
isosize: read error on /: Is a directory
14

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/isosize.8 | 24 ++++++++++++++++++++++++
 disk-utils/isosize.c | 38 ++++++++++++++++++++++++++------------
 2 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/disk-utils/isosize.8 b/disk-utils/isosize.8
index 44ac124ea..225b0ae46 100644
--- a/disk-utils/isosize.8
+++ b/disk-utils/isosize.8
@@ -32,6 +32,30 @@ filesystem can be marginally larger than the actual size of the
 iso9660 filesystem.  One reason for this is that cd writers
 are allowed to add "run out" sectors at the end of an iso9660
 image.
+.SH "EXIT STATUS"
+Exit values are subject to bitwise inclusive or.  That means a return value
+such as 14 means all of the 2, 4, 8 errors happen to some of the input
+files.
+.PP
+.RS
+.PD 0
+.TP
+.B 0
+Success.
+.TP
+.B 1
+Generic error, such as invalid usage.
+.TP
+.B 2
+Could not open input file.
+.TP
+.B 4
+Invalid ISO header.
+.TP
+.B 8
+Size could not be read.
+.PD
+.RE
 .SH AVAILABILITY
 The isosize command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/disk-utils/isosize.c b/disk-utils/isosize.c
index 5fbbbfc76..dfb2c4ca9 100644
--- a/disk-utils/isosize.c
+++ b/disk-utils/isosize.c
@@ -30,6 +30,12 @@
 #include "strutils.h"
 #include "closestream.h"
 
+enum {
+	EXIT_OPEN = 2,
+	EXIT_HEADER = 4,
+	EXIT_READ = 8
+};
+
 static int is_iso(int fd)
 {
 	char label[8];
@@ -86,22 +92,29 @@ static int isonum_733(unsigned char *p, int xflag)
 	return (le);
 }
 
-static void isosize(int argc, char *filenamep, int xflag, long divisor)
+static int isosize(int argc, char *filenamep, int xflag, long divisor)
 {
-	int fd, nsecs, ssize;
+	int fd, nsecs, ssize, ret = EXIT_SUCCESS;
 	unsigned char volume_space_size[8];
 	unsigned char logical_block_size[4];
 
-	if ((fd = open(filenamep, O_RDONLY)) < 0)
-		err(EXIT_FAILURE, _("cannot open %s"), filenamep);
-	if (is_iso(fd))
+	if ((fd = open(filenamep, O_RDONLY)) < 0) {
+		warn(_("cannot open %s"), filenamep);
+		return EXIT_OPEN;
+	}
+	if (is_iso(fd)) {
 		warnx(_("%s: might not be an ISO filesystem"), filenamep);
+		ret = EXIT_HEADER;
+	}
 
-	if (pread(fd, volume_space_size, sizeof(volume_space_size), 0x8050) <= 0 ||
-	    pread(fd, logical_block_size, sizeof(logical_block_size), 0x8080) <= 0) {
+	if (pread(fd, volume_space_size, sizeof(volume_space_size), 0x8050) != sizeof(volume_space_size) ||
+	    pread(fd, logical_block_size, sizeof(logical_block_size), 0x8080) != sizeof(logical_block_size)) {
 		if (errno)
-			err(EXIT_FAILURE, _("read error on %s"), filenamep);
-		errx(EXIT_FAILURE, _("read error on %s"), filenamep);
+			warn(_("read error on %s"), filenamep);
+		else
+			warnx(_("read error on %s"), filenamep);
+		close(fd);
+		return ret | EXIT_READ;
 	}
 
 	nsecs = isonum_733(volume_space_size, xflag);
@@ -122,8 +135,8 @@ static void isosize(int argc, char *filenamep, int xflag, long divisor)
 		else
 			printf("%lld\n", (product * ssize) / divisor);
 	}
-
 	close(fd);
+	return ret;
 }
 
 static void __attribute__((__noreturn__)) usage(void)
@@ -151,6 +164,7 @@ int main(int argc, char **argv)
 {
 	int j, ct, opt, xflag = 0;
 	long divisor = 0;
+	int ret = 0;
 
 	static const struct option longopts[] = {
 		{"divisor", required_argument, NULL, 'd'},
@@ -192,7 +206,7 @@ int main(int argc, char **argv)
 	}
 
 	for (j = optind; j < argc; j++)
-		isosize(ct, argv[j], xflag, divisor);
+		ret |= isosize(ct, argv[j], xflag, divisor);
 
-	return EXIT_SUCCESS;
+	return ret;
 }
-- 
2.14.1


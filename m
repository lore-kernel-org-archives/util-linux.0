Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:18510 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756996AbaJXPOL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Oct 2014 11:14:11 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s9OFEAs9019819
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <util-linux@vger.kernel.org>; Fri, 24 Oct 2014 11:14:11 -0400
From: Federico Simoncelli <fsimonce@redhat.com>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com, lczerner@redhat.com,
        Federico Simoncelli <fsimonce@redhat.com>
Subject: [PATCH 3/3] blkdiscard: add support for steps and progress
Date: Fri, 24 Oct 2014 15:13:55 +0000
Message-Id: <1414163635-3940-3-git-send-email-fsimonce@redhat.com>
In-Reply-To: <1414163635-3940-1-git-send-email-fsimonce@redhat.com>
References: <1414163635-3940-1-git-send-email-fsimonce@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Federico Simoncelli <fsimonce@redhat.com>
---
 sys-utils/blkdiscard.c            | 57 ++++++++++++++++++++++++++++++---------
 tests/expected/blkdiscard/offsets | 23 ++++++++++++++++
 tests/ts/blkdiscard/offsets       | 27 +++++++++++++++++++
 3 files changed, 94 insertions(+), 13 deletions(-)

diff --git a/sys-utils/blkdiscard.c b/sys-utils/blkdiscard.c
index 1504ee3..14d4b19 100644
--- a/sys-utils/blkdiscard.c
+++ b/sys-utils/blkdiscard.c
@@ -49,6 +49,10 @@
 #define BLKSECDISCARD	_IO(0x12,125)
 #endif
 
+#define print_stats(path, stats) \
+	printf(_("%s: Discarded %" PRIu64 " bytes from the " \
+		 "offset %" PRIu64"\n"), path, stats[1], stats[0]);
+
 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
@@ -57,6 +61,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -o, --offset <num>  offset in bytes to discard from\n"
 		" -l, --length <num>  length of bytes to discard from the offset\n"
+		" -p, --step <num>    size of the discard iterations within the offset\n"
 		" -s, --secure        perform secure discard\n"
 		" -v, --verbose       print aligned length and offset\n"),
 		out);
@@ -71,14 +76,16 @@ int main(int argc, char **argv)
 {
 	char *path;
 	int c, fd, verbose = 0, secure = 0, secsize;
-	uint64_t end, blksize, range[2];
+	uint64_t end, blksize, step, range[2], stats[2];
 	struct stat sb;
+	struct timespec now, last;
 
 	static const struct option longopts[] = {
 	    { "help",      0, 0, 'h' },
 	    { "version",   0, 0, 'V' },
 	    { "offset",    1, 0, 'o' },
 	    { "length",    1, 0, 'l' },
+	    { "step",      1, 0, 'p' },
 	    { "secure",    0, 0, 's' },
 	    { "verbose",   0, 0, 'v' },
 	    { NULL,        0, 0, 0 }
@@ -91,8 +98,9 @@ int main(int argc, char **argv)
 
 	range[0] = 0;
 	range[1] = ULLONG_MAX;
+	step = 0;
 
-	while ((c = getopt_long(argc, argv, "hVsvo:l:", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "hVsvo:l:p:", longopts, NULL)) != -1) {
 		switch(c) {
 		case 'h':
 			usage(stdout);
@@ -108,6 +116,10 @@ int main(int argc, char **argv)
 			range[0] = strtosize_or_err(optarg,
 					_("failed to parse offset"));
 			break;
+		case 'p':
+			step = strtosize_or_err(optarg,
+					_("failed to parse step"));
+			break;
 		case 's':
 			secure = 1;
 			break;
@@ -154,26 +166,45 @@ int main(int argc, char **argv)
 		errx(EXIT_FAILURE, _("%s: offset is greater than device size"), path);
 	end = range[0] + range[1];
 	if (end < range[0] || end > blksize)
-		range[1] = blksize - range[0];
+		end = blksize;
+
+	range[1] = (step > 0) ? step : end - range[0];
 
 	/* check length alignment to the sector size */
 	if (range[1] % secsize)
 		errx(EXIT_FAILURE, _("%s: length %" PRIu64 " is not aligned "
 			 "to sector size %i"), path, range[1], secsize);
 
-	if (secure) {
-		if (ioctl(fd, BLKSECDISCARD, &range))
-			err(EXIT_FAILURE, _("%s: BLKSECDISCARD ioctl failed"), path);
-	} else {
-		if (ioctl(fd, BLKDISCARD, &range))
-			err(EXIT_FAILURE, _("%s: BLKDISCARD ioctl failed"), path);
+	stats[0] = range[0], stats[1] = 0;
+	clock_gettime(CLOCK_MONOTONIC, &last);
+
+	for (range[0] = range[0]; range[0] < end; range[0] += range[1]) {
+		if (range[0] + range[1] > end)
+			range[1] = end - range[0];
+
+		if (secure) {
+			if (ioctl(fd, BLKSECDISCARD, &range))
+				err(EXIT_FAILURE, _("%s: BLKSECDISCARD ioctl failed"), path);
+		} else {
+			if (ioctl(fd, BLKDISCARD, &range))
+				err(EXIT_FAILURE, _("%s: BLKDISCARD ioctl failed"), path);
+		}
+
+		/* reporting progress */
+		if (verbose && step) {
+			clock_gettime(CLOCK_MONOTONIC, &now);
+			if (last.tv_sec < now.tv_sec) {
+				print_stats(path, stats);
+				stats[0] = range[0], stats[1] = 0;
+				last = now;
+			}
+		}
+
+		stats[1] += range[1];
 	}
 
 	if (verbose)
-		/* TRANSLATORS: The standard value here is a very large number. */
-		printf(_("%s: Discarded %" PRIu64 " bytes from the "
-			 "offset %" PRIu64"\n"), path,
-			 (uint64_t) range[1], (uint64_t) range[0]);
+		print_stats(path, stats);
 
 	close(fd);
 	return EXIT_SUCCESS;
diff --git a/tests/expected/blkdiscard/offsets b/tests/expected/blkdiscard/offsets
index 8807878..2596fc6 100644
--- a/tests/expected/blkdiscard/offsets
+++ b/tests/expected/blkdiscard/offsets
@@ -13,4 +13,27 @@ blkdiscard: offset 1 is not aligned to sector size 512
 blkdiscard: offset 511 is not aligned to sector size 512
 Discarded 5242880 bytes from the offset 512
 Discarded 5242880 bytes from the offset 1024
+testing aligned steps full device
+Discarded 10485760 bytes from the offset 0
+Discarded 10485760 bytes from the offset 0
+testing aligned steps with offsets and length
+Discarded 1024 bytes from the offset 0
+blkdiscard: offset 1 is not aligned to sector size 512
+blkdiscard: offset 1 is not aligned to sector size 512
+blkdiscard: offset 511 is not aligned to sector size 512
+Discarded 1536 bytes from the offset 512
+Discarded 1024 bytes from the offset 1024
+testing misaligned steps full device
+blkdiscard: length 1 is not aligned to sector size 512
+blkdiscard: length 256 is not aligned to sector size 512
+blkdiscard: length 511 is not aligned to sector size 512
+blkdiscard: length 513 is not aligned to sector size 512
+blkdiscard: length 768 is not aligned to sector size 512
+testing misaligned steps with offsets and length
+blkdiscard: length 511 is not aligned to sector size 512
+blkdiscard: offset 1 is not aligned to sector size 512
+blkdiscard: offset 511 is not aligned to sector size 512
+blkdiscard: length 511 is not aligned to sector size 512
+blkdiscard: offset 1 is not aligned to sector size 512
+blkdiscard: offset 511 is not aligned to sector size 512
 detach loop device from image
diff --git a/tests/ts/blkdiscard/offsets b/tests/ts/blkdiscard/offsets
index 04bd437..8776c67 100755
--- a/tests/ts/blkdiscard/offsets
+++ b/tests/ts/blkdiscard/offsets
@@ -54,6 +54,33 @@ $TS_CMD_BLKDISCARD -v -o 511 -l 5242880 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OU
 $TS_CMD_BLKDISCARD -v -o 512 -l 5242880 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
 $TS_CMD_BLKDISCARD -v -o 1024 -l 5242880 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
 
+ts_log "testing aligned steps full device"
+$TS_CMD_BLKDISCARD -v -p 5242880 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+$TS_CMD_BLKDISCARD -v -p 1310720 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+
+ts_log "testing aligned steps with offsets and length"
+$TS_CMD_BLKDISCARD -v -p 512 -l 1024 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+$TS_CMD_BLKDISCARD -v -p 512 -o 1 -l 1024 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+$TS_CMD_BLKDISCARD -v -p 512 -o 1 -l 1536 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+$TS_CMD_BLKDISCARD -v -p 512 -o 511 -l 1536 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+$TS_CMD_BLKDISCARD -v -p 512 -o 512 -l 1536 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+$TS_CMD_BLKDISCARD -v -p 512 -o 1024 -l 1024 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+
+ts_log "testing misaligned steps full device"
+$TS_CMD_BLKDISCARD -v -p 1 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+$TS_CMD_BLKDISCARD -v -p 256 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+$TS_CMD_BLKDISCARD -v -p 511 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+$TS_CMD_BLKDISCARD -v -p 513 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+$TS_CMD_BLKDISCARD -v -p 768 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+
+ts_log "testing misaligned steps with offsets and length"
+$TS_CMD_BLKDISCARD -v -p 511 -l 1024 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+$TS_CMD_BLKDISCARD -v -p 511 -o 1 -l 1536 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+$TS_CMD_BLKDISCARD -v -p 511 -o 511 -l 1536 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+$TS_CMD_BLKDISCARD -v -p 511 -l 10240 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+$TS_CMD_BLKDISCARD -v -p 511 -o 1 -l 10240 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+$TS_CMD_BLKDISCARD -v -p 511 -o 511 -l 10240 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+
 ts_log "detach loop device from image"
 $TS_CMD_LOSETUP -d $DEVICE 2>&1 >> $TS_OUTPUT
 
-- 
1.9.3


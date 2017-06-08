Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34739 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751658AbdFHTw2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 8 Jun 2017 15:52:28 -0400
Received: by mail-wm0-f66.google.com with SMTP id 70so8887018wme.1
        for <util-linux@vger.kernel.org>; Thu, 08 Jun 2017 12:52:27 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 06/11] isosize: avoid reading more data than what is needed
Date: Thu,  8 Jun 2017 20:52:10 +0100
Message-Id: <20170608195215.1702-7-kerolasa@iki.fi>
In-Reply-To: <20170608195215.1702-1-kerolasa@iki.fi>
References: <20170608195215.1702-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In same go fix error reporting when input file is not long enough.

$ touch empty
$ isosize empty
isosize: empty: might not be an ISO filesystem
isosize: read error on empty: Success

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/isosize.c | 57 +++++++++-------------------------------------------
 1 file changed, 10 insertions(+), 47 deletions(-)

diff --git a/disk-utils/isosize.c b/disk-utils/isosize.c
index d3d11c921..b5ac56262 100644
--- a/disk-utils/isosize.c
+++ b/disk-utils/isosize.c
@@ -30,8 +30,6 @@
 #include "strutils.h"
 #include "closestream.h"
 
-#define ISODCL(from, to) (to - from + 1)
-
 static int is_iso(int fd)
 {
 	char label[8];
@@ -88,62 +86,27 @@ static int isonum_733(unsigned char *p, int xflag)
 	return (le);
 }
 
-struct iso_primary_descriptor
-{
-	unsigned char type			[ISODCL (   1,	  1)]; /* 711 */
-	unsigned char id			[ISODCL (   2,	  6)];
-	unsigned char version			[ISODCL (   7,	  7)]; /* 711 */
-	unsigned char unused1			[ISODCL (   8,	  8)];
-	unsigned char system_id			[ISODCL (   9,	 40)]; /* auchars */
-	unsigned char volume_id			[ISODCL (  41,	 72)]; /* duchars */
-	unsigned char unused2			[ISODCL (  73,	 80)];
-	unsigned char volume_space_size		[ISODCL (  81,	 88)]; /* 733 */
-	unsigned char unused3			[ISODCL (  89,	120)];
-	unsigned char volume_set_size		[ISODCL ( 121,	124)]; /* 723 */
-	unsigned char volume_sequence_number	[ISODCL ( 125,	128)]; /* 723 */
-	unsigned char logical_block_size	[ISODCL ( 129,	132)]; /* 723 */
-	unsigned char path_table_size		[ISODCL ( 133,	140)]; /* 733 */
-	unsigned char type_l_path_table		[ISODCL ( 141,	144)]; /* 731 */
-	unsigned char opt_type_l_path_table	[ISODCL ( 145,	148)]; /* 731 */
-	unsigned char type_m_path_table		[ISODCL ( 149,	152)]; /* 732 */
-	unsigned char opt_type_m_path_table	[ISODCL ( 153,	156)]; /* 732 */
-	unsigned char root_directory_record	[ISODCL ( 157,	190)]; /* 9.1 */
-	unsigned char volume_set_id		[ISODCL ( 191,	318)]; /* duchars */
-	unsigned char publisher_id		[ISODCL ( 319,	446)]; /* achars */
-	unsigned char preparer_id		[ISODCL ( 447,	574)]; /* achars */
-	unsigned char application_id		[ISODCL ( 575,	702)]; /* achars */
-	unsigned char copyright_file_id		[ISODCL ( 703,	739)]; /* 7.5 dchars */
-	unsigned char abstract_file_id		[ISODCL ( 740,	776)]; /* 7.5 dchars */
-	unsigned char bibliographic_file_id	[ISODCL ( 777,	813)]; /* 7.5 dchars */
-	unsigned char creation_date		[ISODCL ( 814,	830)]; /* 8.4.26.1 */
-	unsigned char modification_date		[ISODCL ( 831,	847)]; /* 8.4.26.1 */
-	unsigned char expiration_date		[ISODCL ( 848,	864)]; /* 8.4.26.1 */
-	unsigned char effective_date		[ISODCL ( 865,	881)]; /* 8.4.26.1 */
-	unsigned char file_structure_version	[ISODCL ( 882,	882)]; /* 711 */
-	unsigned char unused4			[ISODCL ( 883,	883)];
-	unsigned char application_data		[ISODCL ( 884, 1395)];
-	unsigned char unused5			[ISODCL (1396, 2048)];
-};
-
 static void isosize(int argc, char *filenamep, int xflag, long divisor)
 {
 	int fd, nsecs, ssize;
-	struct iso_primary_descriptor ipd;
+	unsigned char volume_space_size[8];
+	unsigned char logical_block_size[4];
 
 	if ((fd = open(filenamep, O_RDONLY)) < 0)
 		err(EXIT_FAILURE, _("cannot open %s"), filenamep);
 	if (is_iso(fd))
 		warnx(_("%s: might not be an ISO filesystem"), filenamep);
 
-	if (lseek(fd, 16 << 11, 0) == (off_t) - 1)
-		err(EXIT_FAILURE, _("seek error on %s"), filenamep);
-
-	if (read(fd, &ipd, sizeof(ipd)) <= 0)
-		err(EXIT_FAILURE, _("read error on %s"), filenamep);
+	if (pread(fd, volume_space_size, sizeof(volume_space_size), 0x8050) <= 0 ||
+	    pread(fd, logical_block_size, sizeof(logical_block_size), 0x8080) <= 0) {
+		if (errno)
+			err(EXIT_FAILURE, _("read error on %s"), filenamep);
+		errx(EXIT_FAILURE, _("read error on %s"), filenamep);
+	}
 
-	nsecs = isonum_733(ipd.volume_space_size, xflag);
+	nsecs = isonum_733(volume_space_size, xflag);
 	/* isonum_723 returns nowadays always 2048 */
-	ssize = isonum_723(ipd.logical_block_size, xflag);
+	ssize = isonum_723(logical_block_size, xflag);
 
 	if (1 < argc)
 		printf("%s: ", filenamep);
-- 
2.13.1


Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:44076 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965929Ab2EPIil (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 May 2012 04:38:41 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 3B83091EDB
	for <util-linux@vger.kernel.org>; Wed, 16 May 2012 10:38:40 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 2/2] blkid: introduce symbolic names for different blkid exit codes
Date: Wed, 16 May 2012 10:38:32 +0200
Message-Id: <1337157512-31920-2-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1337157512-31920-1-git-send-email-petr.uzel@suse.cz>
References: <1337157512-31920-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 misc-utils/blkid.c |   32 ++++++++++++++++++--------------
 1 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 4f7050f..52b2a4b 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -34,11 +34,15 @@ extern int optind;
 #define LOWPROBE_TOPOLOGY	(1 << 1)
 #define LOWPROBE_SUPERBLOCKS	(1 << 2)
 
+#define BLKID_EXIT_NOTFOUND	2	/* token or device not found */
+#define BLKID_EXIT_OTHER	4	/* bad usage or other error */
+#define BLKID_EXIT_AMBIVAL	8	/* ambivalent low-level probing detected */
+
 #include <blkid.h>
 
 #include "ismounted.h"
 
-#define STRTOXX_EXIT_CODE	4		/* strtoxx_or_err() */
+#define STRTOXX_EXIT_CODE	BLKID_EXIT_OTHER	/* strtoxx_or_err() */
 #include "strutils.h"
 #include "closestream.h"
 #include "ttyutils.h"
@@ -484,7 +488,7 @@ static int lowprobe_device(blkid_probe pr, const char *devname,
 	fd = open(devname, O_RDONLY);
 	if (fd < 0) {
 		fprintf(stderr, "error: %s: %m\n", devname);
-		return 2;
+		return BLKID_EXIT_NOTFOUND;
 	}
 	if (blkid_probe_set_device(pr, fd, offset, size))
 		goto done;
@@ -551,9 +555,9 @@ done:
 	close(fd);
 
 	if (rc == -2)
-		return 8;	/* ambivalent probing result */
+		return BLKID_EXIT_AMBIVAL;	/* ambivalent probing result */
 	if (!nvals)
-		return 2;	/* nothing detected */
+		return BLKID_EXIT_NOTFOUND;	/* nothing detected */
 
 	return 0;		/* success */
 }
@@ -591,7 +595,7 @@ err:
 	*flag = 0;
 	fprintf(stderr, "unknown kerword in -u <list> argument: '%s'\n",
 			word ? word : list);
-	exit(4);
+	exit(BLKID_EXIT_OTHER);
 }
 
 /* converts comma separated list to types[] */
@@ -633,7 +637,7 @@ err_mem:
 err:
 	*flag = 0;
 	free(res);
-	exit(4);
+	exit(BLKID_EXIT_OTHER);
 }
 
 static void free_types_list(char *list[])
@@ -659,7 +663,7 @@ int main(int argc, char **argv)
 	int fltr_flag = BLKID_FLTR_ONLYIN;
 	unsigned int numdev = 0, numtag = 0;
 	int version = 0;
-	int err = 4;
+	int err = BLKID_EXIT_OTHER;
 	unsigned int i;
 	int output_format = 0;
 	int lookup = 0, gc = 0, lowprobe = 0, eval = 0;
@@ -688,14 +692,14 @@ int main(int argc, char **argv)
 		case 'n':
 			if (fltr_usage) {
 				fprintf(stderr, "error: -u and -n options are mutually exclusive\n");
-				exit(4);
+				exit(BLKID_EXIT_OTHER);
 			}
 			fltr_type = list_to_types(optarg, &fltr_flag);
 			break;
 		case 'u':
 			if (fltr_type) {
 				fprintf(stderr, "error: -u and -n options are mutually exclusive\n");
-				exit(4);
+				exit(BLKID_EXIT_OTHER);
 			}
 			fltr_usage = list_to_usage(optarg, &fltr_flag);
 			break;
@@ -739,7 +743,7 @@ int main(int argc, char **argv)
 				fprintf(stderr, "Invalid output format %s. "
 					"Choose from value,\n\t"
 					"device, list, udev or full\n", optarg);
-				exit(4);
+				exit(BLKID_EXIT_OTHER);
 			}
 			break;
 		case 'O':
@@ -818,13 +822,13 @@ int main(int argc, char **argv)
 		err = 0;
 		goto exit;
 	}
-	err = 2;
+	err = BLKID_EXIT_NOTFOUND;
 
 	if (eval == 0 && (output_format & OUTPUT_PRETTY_LIST)) {
 		if (lowprobe) {
 			fprintf(stderr, "The low-level probing mode does not "
 					"support 'list' output format\n");
-			exit(4);
+			exit(BLKID_EXIT_OTHER);
 		}
 		pretty_print_dev(NULL);
 	}
@@ -838,7 +842,7 @@ int main(int argc, char **argv)
 		if (!numdev) {
 			fprintf(stderr, "The low-level probing mode "
 					"requires a device\n");
-			exit(4);
+			exit(BLKID_EXIT_OTHER);
 		}
 
 		/* automatically enable 'export' format for I/O Limits */
@@ -888,7 +892,7 @@ int main(int argc, char **argv)
 		if (!search_type) {
 			fprintf(stderr, "The lookup option requires a "
 				"search type specified using -t\n");
-			exit(4);
+			exit(BLKID_EXIT_OTHER);
 		}
 		/* Load any additional devices not in the cache */
 		for (i = 0; i < numdev; i++)
-- 
1.7.7


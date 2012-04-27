Return-Path: util-linux-owner@vger.kernel.org
Received: from damascus.uab.es ([158.109.168.135]:19429 "EHLO damascus.uab.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759923Ab2D0LXd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 27 Apr 2012 07:23:33 -0400
Received: from damascus.uab.es ([127.0.0.1])
 by damascus.uab.es (Sun Java System Messaging Server 6.1 HotFix 0.10 (built
 Jan  6 2005)) with ESMTP id <0M340086TYB8R600@damascus.uab.es> for
 util-linux@vger.kernel.org; Fri, 27 Apr 2012 13:23:32 +0200 (CEST)
Received: from aomail.uab.es ([158.109.65.1])
 by damascus.uab.es (Sun Java	System Messaging Server 6.1 HotFix 0.10 (builtJan
 6 2005)) with ESMTP id	<0M3400FGTYB7NG40@damascus.uab.es>
 forutil-linux@vger.kernel.org; Fri, 27 Apr 2012 13:23:32 +0200 (CEST)
Date: Fri, 27 Apr 2012 13:23:42 +0200
From: Davidlohr Bueso <dave@gnu.org>
Subject: [PATCH 1/4] fdisk: remove stack jumping
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Message-id: <1335525822.11068.4.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

This patch eliminates the long/setjmp code. The current logic does not do anything with stack jumps as it only exits from
print_partition_table_from_option() when a fatal error occurs.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c |   17 ++---------------
 1 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 4054b4d..886f011 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -14,7 +14,6 @@
 #include <string.h>
 #include <fcntl.h>
 #include <ctype.h>
-#include <setjmp.h>
 #include <errno.h>
 #include <getopt.h>
 #include <sys/stat.h>
@@ -245,8 +244,6 @@ int has_topology;
 
 enum labeltype disklabel;	/* Current disklabel */
 
-jmp_buf listingbuf;
-
 static void __attribute__ ((__noreturn__)) usage(FILE *out)
 {
 	fprintf(out, _("Usage:\n"
@@ -266,13 +263,8 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-void fatal(enum failure why) {
-
-	if (listing) {
-		close(fd);
-		longjmp(listingbuf, 1);
-	}
-
+void fatal(enum failure why)
+{
 	switch (why) {
 		case unable_to_open:
 			err(EXIT_FAILURE, _("unable to open %s"), disk_device);
@@ -2708,8 +2700,6 @@ print_partition_table_from_option(char *device)
 	int gb;
 
 	disk_device = device;
-	if (setjmp(listingbuf))
-		return;
 	gpt_warning(device);
 	gb = get_boot(1);
 	if (gb < 0) { /* no DOS signature */
@@ -2950,9 +2940,6 @@ main(int argc, char **argv) {
 		nowarn = 1;
 		if (argc > optind) {
 			int k;
-			/* avoid gcc warning:
-			   variable `k' might be clobbered by `longjmp' */
-			dummy(&k);
 			listing = 1;
 			for (k = optind; k < argc; k++)
 				print_partition_table_from_option(argv[k]);
-- 
1.7.4.1





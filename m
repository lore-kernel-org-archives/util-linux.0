Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:64134 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751866AbdFVChv (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 21 Jun 2017 22:37:51 -0400
Received: from tenfore.ga-group.nl ([92.195.15.151]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MP1PX-1dSYh82mE3-006MHr for
 <util-linux@vger.kernel.org>; Thu, 22 Jun 2017 04:37:49 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 13/13] misc: no more errtryh()
Date: Thu, 22 Jun 2017 04:37:46 +0200
Message-Id: <1498099066-24235-14-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
References: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Nowadays all our regular commands have --help options.
test_uuidd does not use translations anyways.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 include/c.h             |  6 ------
 misc-utils/test_uuidd.c | 25 ++++++++++++++-----------
 2 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/include/c.h b/include/c.h
index 2bcdcea..8cf54cb 100644
--- a/include/c.h
+++ b/include/c.h
@@ -216,12 +216,6 @@ errmsg(char doexit, int excode, char adderr, const char *fmt, ...)
 	exit(eval); \
 })
 
-#define errtryh(eval) __extension__ ({ \
-	fprintf(stderr, _("Try '%s -h' for more information.\n"), \
-			program_invocation_short_name); \
-	exit(eval); \
-})
-
 
 static inline __attribute__((const)) int is_power_of_2(unsigned long num)
 {
diff --git a/misc-utils/test_uuidd.c b/misc-utils/test_uuidd.c
index 26751a4..7bbd3a9 100644
--- a/misc-utils/test_uuidd.c
+++ b/misc-utils/test_uuidd.c
@@ -73,17 +73,17 @@ static int shmem_id;
 static object_t *objects;
 
 
-static void __attribute__((__noreturn__)) usage(FILE *out)
+static void __attribute__((__noreturn__)) usage(void)
 {
-	fprintf(out, "\n %s [options]\n", program_invocation_short_name);
+	printf("\n %s [options]\n", program_invocation_short_name);
 
-	fprintf(out, "  -p <num>     number of nprocesses (default:%zu)\n", nprocesses);
-	fprintf(out, "  -t <num>     number of nthreads (default:%zu)\n", nthreads);
-	fprintf(out, "  -o <num>     number of nobjects (default:%zu)\n", nobjects);
-	fprintf(out, "  -l <level>   log level (default:%zu)\n", loglev);
-	fprintf(out, "  -h           display help\n");
+	printf("  -p <num>     number of nprocesses (default:%zu)\n", nprocesses);
+	printf("  -t <num>     number of nthreads (default:%zu)\n", nthreads);
+	printf("  -o <num>     number of nobjects (default:%zu)\n", nobjects);
+	printf("  -l <level>   log level (default:%zu)\n", loglev);
+	printf("  -h           display help\n");
 
-	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
+	exit(EXIT_SUCCESS);
 }
 
 static void allocate_segment(int *id, void **address, size_t number, size_t size)
@@ -260,6 +260,8 @@ static void object_dump(size_t idx, object_t *obj)
 	fprintf(stderr, "}\n");
 }
 
+#define MSG_TRY_HELP "Try '-h' for help."
+
 int main(int argc, char *argv[])
 {
 	size_t i, nfailed = 0, nignored = 0;
@@ -280,15 +282,16 @@ int main(int argc, char *argv[])
 			loglev = strtou32_or_err(optarg, "invalid log level argument");
 			break;
 		case 'h':
-			usage(stdout);
+			usage();
 			break;
 		default:
-			errtryh(EXIT_FAILURE);
+			fprintf(stderr, MSG_TRY_HELP);
+			exit(EXIT_FAILURE);
 		}
 	}
 
 	if (optind != argc)
-		usage(stderr);
+		errx(EXIT_FAILURE, "bad usage\n" MSG_TRY_HELP);
 
 	if (loglev == 1)
 		fprintf(stderr, "requested: %zu processes, %zu threads, %zu objects per thread (%zu objects = %zu bytes)\n",
-- 
1.8.5.6


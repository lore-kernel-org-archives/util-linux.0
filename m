Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34868 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932074AbdBKOK6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 11 Feb 2017 09:10:58 -0500
Received: by mail-wr0-f196.google.com with SMTP id o16so17997644wra.2
        for <util-linux@vger.kernel.org>; Sat, 11 Feb 2017 06:10:58 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/3] blkreport, blkreset: small code clean ups
Date: Sat, 11 Feb 2017 14:10:50 +0000
Message-Id: <20170211141052.26154-2-kerolasa@iki.fi>
In-Reply-To: <20170211141052.26154-1-kerolasa@iki.fi>
References: <20170211141052.26154-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Set variables read-only where possible.  Fix few code style issues, mostly
with spacing.  Avoid initializing variables if they are never read before
next update.  Remove "ERR: %d -> %s" message that repeated system error
three times, twice in that message and once at end of main that is the only
of these three left in place.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/blkreport.c | 43 +++++++++++++++++--------------------------
 sys-utils/blkreset.c  | 17 ++++++++---------
 2 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/sys-utils/blkreport.c b/sys-utils/blkreport.c
index f3b8ebbda..c8d0a63ac 100644
--- a/sys-utils/blkreport.c
+++ b/sys-utils/blkreport.c
@@ -47,16 +47,14 @@
 #include "closestream.h"
 #include "blkdev.h"
 
-static const char * type_text[] = {
+static const char *type_text[] = {
 	"RESERVED",
 	"CONVENTIONAL",
 	"SEQ_WRITE_REQUIRED",
 	"SEQ_WRITE_PREFERRED",
 };
 
-#define ARRAY_COUNT(x) (sizeof((x))/sizeof((*x)))
-
-const char * condition_str[] = {
+static const char *condition_str[] = {
 	"cv", /* conventional zone */
 	"e0", /* empty */
 	"Oi", /* open implicit */
@@ -66,22 +64,17 @@ const char * condition_str[] = {
 	"ro", /* read only */
 	"fu", /* full */
 	"OL"  /* offline */
-	};
-
-static const char * zone_condition_str(uint8_t cond)
-{
-	return condition_str[cond & 0x0f];
-}
+};
 
-static void print_zones(struct blk_zone *info, uint32_t count)
+static void print_zones(const struct blk_zone *info, const uint32_t count)
 {
 	uint32_t iter;
 
 	printf(_("Zones returned: %u\n"), count);
 
-	for (iter = 0; iter < count; iter++ ) {
-		struct blk_zone * entry = &info[iter];
-		unsigned int type  = entry->type;
+	for (iter = 0; iter < count; iter++) {
+		const struct blk_zone *entry = &info[iter];
+		unsigned int type = entry->type;
 		uint64_t start = entry->start;
 		uint64_t wp = entry->wp;
 		uint8_t cond = entry->cond;
@@ -94,14 +87,14 @@ static void print_zones(struct blk_zone *info, uint32_t count)
 			 " reset:%u non-seq:%u, zcond:%2u(%s) [type: %u(%s)]\n"),
 			start, len, wp - start,
 			entry->reset, entry->non_seq,
-			cond, zone_condition_str(cond),
+			cond, condition_str[cond & ARRAY_SIZE(condition_str)],
 			type, type_text[type]);
 	}
 }
 
-static int do_report(int fd, uint64_t lba, uint32_t len, int verbose)
+static int do_report(const int fd, const uint64_t lba, uint32_t len, const int verbose)
 {
-	int rc = -4;
+	int rc;
 	struct blk_zone_report *zi;
 
 	zi = xmalloc(sizeof(struct blk_zone_report) + (len * sizeof(struct blk_zone)));
@@ -112,8 +105,6 @@ static int do_report(int fd, uint64_t lba, uint32_t len, int verbose)
 		if (verbose)
 			printf(_("Found %d zones\n"), zi->nr_zones);
 		print_zones(zi->zones, zi->nr_zones);
-	} else {
-		warn(_("ERR: %d -> %s"), errno, strerror(errno));
 	}
 	free(zi);
 
@@ -155,12 +146,12 @@ int main(int argc, char **argv)
 	uint64_t offset = 0ul;
 	uint32_t length = DEF_REPORT_LEN;
 	static const struct option longopts[] = {
-	    { "help",      0, 0, 'h' },
-	    { "version",   0, 0, 'V' },
-	    { "zone",      1, 0, 'z' }, /* starting LBA */
-	    { "count",     1, 0, 'c' }, /* max #of zones (entries) for result */
-	    { "verbose",   0, 0, 'v' },
-	    { NULL,        0, 0, 0 }
+	    { "help",    no_argument,       NULL, 'h' },
+	    { "version", no_argument,       NULL, 'V' },
+	    { "zone",    required_argument, NULL, 'z' }, /* starting LBA */
+	    { "count",   required_argument, NULL, 'c' }, /* max #of zones (entries) for result */
+	    { "verbose", no_argument,       NULL, 'v' },
+	    { NULL, 0, NULL, 0 }
 	};
 
 	setlocale(LC_ALL, "");
@@ -169,7 +160,7 @@ int main(int argc, char **argv)
 	atexit(close_stdout);
 
 	while ((c = getopt_long(argc, argv, "hc:z:vV", longopts, NULL)) != -1) {
-		switch(c) {
+		switch (c) {
 		case 'h':
 			usage(stdout);
 			break;
diff --git a/sys-utils/blkreset.c b/sys-utils/blkreset.c
index 76df5f6a5..9a19c33c7 100644
--- a/sys-utils/blkreset.c
+++ b/sys-utils/blkreset.c
@@ -94,7 +94,6 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-
 int main(int argc, char **argv)
 {
 	char *path;
@@ -103,17 +102,17 @@ int main(int argc, char **argv)
 	struct stat sb;
 	struct blk_zone_range za;
 	uint64_t zsector = 0;
-	uint64_t zlen = 0;
+	uint64_t zlen;
 	uint64_t zcount = 1;
 	unsigned long zsize;
-	int rc = 0;
+	int rc;
 
 	static const struct option longopts[] = {
-	    { "help",      0, 0, 'h' },
-	    { "version",   0, 0, 'V' },
-	    { "zone",      1, 0, 'z' },
-	    { "count",     1, 0, 'c' },
-	    { NULL,        0, 0, 0 }
+	    { "help",    no_argument,       NULL, 'h' },
+	    { "version", no_argument,       NULL, 'V' },
+	    { "zone",    required_argument, NULL, 'z' },
+	    { "count",   required_argument, NULL, 'c' },
+	    { NULL, 0, NULL, 0 }
 	};
 
 	setlocale(LC_ALL, "");
@@ -122,7 +121,7 @@ int main(int argc, char **argv)
 	atexit(close_stdout);
 
 	while ((c = getopt_long(argc, argv, "hVz:c:", longopts, NULL)) != -1) {
-		switch(c) {
+		switch (c) {
 		case 'h':
 			usage(stdout);
 			break;
-- 
2.11.1


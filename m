Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37189 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbbJYQFM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 25 Oct 2015 12:05:12 -0400
Received: by wicfv8 with SMTP id fv8so86044894wic.0
        for <util-linux@vger.kernel.org>; Sun, 25 Oct 2015 09:05:11 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/4] tests: make test_uuid_parser to read files
Date: Sun, 25 Oct 2015 16:04:58 +0000
Message-Id: <1445789100-1781-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1445789100-1781-1-git-send-email-kerolasa@iki.fi>
References: <1445789100-1781-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This allows using the command to check uuidgen and uuidd are generating
valid outputs.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libuuid/src/test_uuid.c | 156 ++++++++++++++----------------------------------
 1 file changed, 45 insertions(+), 111 deletions(-)

diff --git a/libuuid/src/test_uuid.c b/libuuid/src/test_uuid.c
index e8f0703..4d155b5 100644
--- a/libuuid/src/test_uuid.c
+++ b/libuuid/src/test_uuid.c
@@ -38,9 +38,13 @@
 #define UUID MYUUID
 #endif
 
+#include <ctype.h>
+#include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <sys/stat.h>
 
+#include "c.h"
 #include "uuid.h"
 
 static int test_uuid(const char * uuid, int isValid)
@@ -60,124 +64,54 @@ static int test_uuid(const char * uuid, int isValid)
 	return 0;
 }
 
-#ifdef __GNUC__
-#define ATTR(x) __attribute__(x)
-#else
-#define ATTR(x)
-#endif
-
-int
-main(int argc ATTR((unused)) , char **argv ATTR((unused)))
+static int check_uuids_in_file(const char *file)
 {
-	int failed = 0;
-/* Code commented out will print random uuid's that are unsuitable output
- * for test suite.
-	uuid_t		buf, tst;
-	char		str[100];
-	struct timeval	tv;
-	time_t		time_reg;
-	unsigned char	*cp;
-	int i;
-	int type, variant;
+	int fd, ret = 0;
+	size_t sz;
+	char str[sizeof("01234567-89ab-cdef-0134-567890abcedf")];
+	uuid_t uuidBits;
 
-	uuid_generate(buf);
-	uuid_unparse(buf, str);
-	printf("UUID generate = %s\n", str);
-	printf("UUID: ");
-	for (i=0, cp = (unsigned char *) &buf; i < 16; i++) {
-		printf("%02x", *cp++);
+	if ((fd = open(file, O_RDONLY)) < 0) {
+		warn("%s", file);
+		return 1;
 	}
-	printf("\n");
-	type = uuid_type(buf); 	variant = uuid_variant(buf);
-	printf("UUID type = %d, UUID variant = %d\n", type, variant);
-	if (variant != UUID_VARIANT_DCE) {
-		printf("Incorrect UUID Variant; was expecting DCE!\n");
-		failed++;
+	while ((sz = read(fd, str, sizeof(str))) != 0) {
+		if (isspace(str[sizeof(str) - 1]))
+			str[sizeof(str) - 1] = '\0';
+		if (uuid_parse(str, uuidBits)) {
+			warnx("%s: %s", file, str);
+			ret++;
+		}
 	}
-	printf("\n");
+	return ret;
+}
 
-	uuid_generate_random(buf);
-	uuid_unparse(buf, str);
-	printf("UUID random string = %s\n", str);
-	printf("UUID: ");
-	for (i=0, cp = (unsigned char *) &buf; i < 16; i++) {
-		printf("%02x", *cp++);
-	}
-	printf("\n");
-	type = uuid_type(buf); 	variant = uuid_variant(buf);
-	printf("UUID type = %d, UUID variant = %d\n", type, variant);
-	if (variant != UUID_VARIANT_DCE) {
-		printf("Incorrect UUID Variant; was expecting DCE!\n");
-		failed++;
-	}
-	if (type != 4) {
-		printf("Incorrect UUID type; was expecting "
-		       "4 (random type)!\n");
-		failed++;
-	}
-	printf("\n");
+int
+main(int argc, char **argv)
+{
+	int failed = 0;
 
-	uuid_generate_time(buf);
-	uuid_unparse(buf, str);
-	printf("UUID string = %s\n", str);
-	printf("UUID time: ");
-	for (i=0, cp = (unsigned char *) &buf; i < 16; i++) {
-		printf("%02x", *cp++);
-	}
-	printf("\n");
-	type = uuid_type(buf); 	variant = uuid_variant(buf);
-	printf("UUID type = %d, UUID variant = %d\n", type, variant);
-	if (variant != UUID_VARIANT_DCE) {
-		printf("Incorrect UUID Variant; was expecting DCE!\n");
-		failed++;
-	}
-	if (type != 1) {
-		printf("Incorrect UUID type; was expecting "
-		       "1 (time-based type)!\\n");
-		failed++;
-	}
-	tv.tv_sec = 0;
-	tv.tv_usec = 0;
-	time_reg = uuid_time(buf, &tv);
-	printf("UUID time is: (%ld, %ld): %s\n", tv.tv_sec, tv.tv_usec,
-	       ctime(&time_reg));
-	uuid_parse(str, tst);
-	if (!uuid_compare(buf, tst))
-		printf("UUID parse and compare succeeded.\n");
-	else {
-		printf("UUID parse and compare failed!\n");
-		failed++;
-	}
-	uuid_clear(tst);
-	if (uuid_is_null(tst))
-		printf("UUID clear and is null succeeded.\n");
-	else {
-		printf("UUID clear and is null failed!\n");
-		failed++;
-	}
-	uuid_copy(buf, tst);
-	if (!uuid_compare(buf, tst))
-		printf("UUID copy and compare succeeded.\n");
-	else {
-		printf("UUID copy and compare failed!\n");
-		failed++;
-	}
-*/
-	failed += test_uuid("84949cc5-4701-4a84-895b-354c584a981b", 1);
-	failed += test_uuid("84949CC5-4701-4A84-895B-354C584A981B", 1);
-	failed += test_uuid("84949cc5-4701-4a84-895b-354c584a981bc", 0);
-	failed += test_uuid("84949cc5-4701-4a84-895b-354c584a981", 0);
-	failed += test_uuid("84949cc5x4701-4a84-895b-354c584a981b", 0);
-	failed += test_uuid("84949cc504701-4a84-895b-354c584a981b", 0);
-	failed += test_uuid("84949cc5-470104a84-895b-354c584a981b", 0);
-	failed += test_uuid("84949cc5-4701-4a840895b-354c584a981b", 0);
-	failed += test_uuid("84949cc5-4701-4a84-895b0354c584a981b", 0);
-	failed += test_uuid("g4949cc5-4701-4a84-895b-354c584a981b", 0);
-	failed += test_uuid("84949cc5-4701-4a84-895b-354c584a981g", 0);
-	failed += test_uuid("00000000-0000-0000-0000-000000000000", 1);
-	failed += test_uuid("01234567-89ab-cdef-0134-567890abcedf", 1);
-	failed += test_uuid("ffffffff-ffff-ffff-ffff-ffffffffffff", 1);
+	if (argc < 2) {
+		failed += test_uuid("84949cc5-4701-4a84-895b-354c584a981b", 1);
+		failed += test_uuid("84949CC5-4701-4A84-895B-354C584A981B", 1);
+		failed += test_uuid("84949cc5-4701-4a84-895b-354c584a981bc", 0);
+		failed += test_uuid("84949cc5-4701-4a84-895b-354c584a981", 0);
+		failed += test_uuid("84949cc5x4701-4a84-895b-354c584a981b", 0);
+		failed += test_uuid("84949cc504701-4a84-895b-354c584a981b", 0);
+		failed += test_uuid("84949cc5-470104a84-895b-354c584a981b", 0);
+		failed += test_uuid("84949cc5-4701-4a840895b-354c584a981b", 0);
+		failed += test_uuid("84949cc5-4701-4a84-895b0354c584a981b", 0);
+		failed += test_uuid("g4949cc5-4701-4a84-895b-354c584a981b", 0);
+		failed += test_uuid("84949cc5-4701-4a84-895b-354c584a981g", 0);
+		failed += test_uuid("00000000-0000-0000-0000-000000000000", 1);
+		failed += test_uuid("01234567-89ab-cdef-0134-567890abcedf", 1);
+		failed += test_uuid("ffffffff-ffff-ffff-ffff-ffffffffffff", 1);
+	} else {
+		int i;
 
+		for (i = 1; i < argc; i++)
+			failed += check_uuids_in_file(argv[i]);
+	}
 	if (failed) {
 		printf("%d failures.\n", failed);
 		exit(1);
-- 
2.6.2


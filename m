Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:45672 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502Ab1FPN7n (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 16 Jun 2011 09:59:43 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id D290A8AC33
	for <util-linux@vger.kernel.org>; Thu, 16 Jun 2011 15:59:41 +0200 (CEST)
From: Ludwig Nussel <ludwig.nussel@suse.de>
To: util-linux@vger.kernel.org
Cc: Ludwig Nussel <ludwig.nussel@suse.de>
Subject: [PATCH 3/4] uuid: use new functions by default
Date: Thu, 16 Jun 2011 15:59:38 +0200
Message-Id: <1308232779-21018-3-git-send-email-ludwig.nussel@suse.de>
In-Reply-To: <1308232779-21018-1-git-send-email-ludwig.nussel@suse.de>
References: <1308232779-21018-1-git-send-email-ludwig.nussel@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

---
 libuuid/src/gen_uuid.c |    2 ++
 libuuid/src/uuid.h     |   12 +++++++++---
 misc-utils/uuidgen.c   |    6 +++---
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index 0c81a5c..e6f8b74 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -38,6 +38,8 @@
  */
 #define _SVID_SOURCE
 
+#define LIBUUID_UNSAFE_LEGACY_PROTOTYPES
+
 #ifdef _WIN32
 #define _WIN32_WINNT 0x0500
 #include <windows.h>
diff --git a/libuuid/src/uuid.h b/libuuid/src/uuid.h
index 2771255..fec4f8c 100644
--- a/libuuid/src/uuid.h
+++ b/libuuid/src/uuid.h
@@ -76,12 +76,18 @@ int uuid_compare(const uuid_t uu1, const uuid_t uu2);
 void uuid_copy(uuid_t dst, const uuid_t src);
 
 /* gen_uuid.c */
-void uuid_generate(uuid_t out);
-void uuid_generate_random(uuid_t out);
-void uuid_generate_time(uuid_t out);
 int uuid_generate_time_safe(uuid_t out) __attribute__((warn_unused_result));
 int uuid_generate_random_safe(uuid_t out) __attribute__((warn_unused_result));
 int uuid_generate_safe(uuid_t out) __attribute__((warn_unused_result));
+#ifdef LIBUUID_UNSAFE_LEGACY_PROTOTYPES
+void uuid_generate(uuid_t out) __attribute__((deprecated));
+void uuid_generate_random(uuid_t out) __attribute__((deprecated));
+void uuid_generate_time(uuid_t out) __attribute__((deprecated));
+#else
+static inline int uuid_generate_time(uuid_t out) { return uuid_generate_time_safe(out); }
+static inline int uuid_generate_random(uuid_t out) { return uuid_generate_random_safe(out); }
+static inline int uuid_generate(uuid_t out) { return uuid_generate_safe(out); }
+#endif
 
 /* isnull.c */
 int uuid_is_null(const uuid_t uu);
diff --git a/misc-utils/uuidgen.c b/misc-utils/uuidgen.c
index e81e065..094f953 100644
--- a/misc-utils/uuidgen.c
+++ b/misc-utils/uuidgen.c
@@ -75,19 +75,19 @@ main (int argc, char *argv[])
 
 	switch (do_type) {
 	case DO_TYPE_TIME:
-		if (uuid_generate_time_safe(uu) && !force) {
+		if (uuid_generate_time(uu) && !force) {
 			fprintf(stderr, _("uuidd not running or not operational.\n"));
 			exit(1);
 		}
 		break;
 	case DO_TYPE_RANDOM:
-		if (uuid_generate_random_safe(uu) && !force) {
+		if (uuid_generate_random(uu) && !force) {
 			fprintf(stderr, _("/dev/[u]random unavailable.\n"));
 			exit(1);
 		}
 		break;
 	default:
-		if (uuid_generate_safe(uu) && !force) {
+		if (uuid_generate(uu) && !force) {
 			fprintf(stderr, _("/dev/[u]random unavailable and uuidd not running.\n"));
 			exit(1);
 		}
-- 
1.7.3.4


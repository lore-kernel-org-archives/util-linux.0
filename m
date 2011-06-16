Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor.suse.de ([195.135.220.2]:54843 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751550Ab1FPN7m (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 16 Jun 2011 09:59:42 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id AF90794430
	for <util-linux@vger.kernel.org>; Thu, 16 Jun 2011 15:59:41 +0200 (CEST)
From: Ludwig Nussel <ludwig.nussel@suse.de>
To: util-linux@vger.kernel.org
Cc: Ludwig Nussel <ludwig.nussel@suse.de>
Subject: [PATCH 2/4] uuid: implement uuid_generate_random_safe
Date: Thu, 16 Jun 2011 15:59:37 +0200
Message-Id: <1308232779-21018-2-git-send-email-ludwig.nussel@suse.de>
In-Reply-To: <1308232779-21018-1-git-send-email-ludwig.nussel@suse.de>
References: <1308232779-21018-1-git-send-email-ludwig.nussel@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

uuid_generate_random_safe() cannot really fail but it may use a weak
random number generator as fallback.
---
 libuuid/src/gen_uuid.c |   32 +++++++++++++++++++++++++++++---
 libuuid/src/uuid.h     |    4 +++-
 libuuid/src/uuid.sym   |    2 ++
 misc-utils/uuidgen.c   |   10 ++++++++--
 4 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index f4c8997..0c81a5c 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -693,6 +693,18 @@ void uuid_generate_random(uuid_t out)
 	__uuid_generate_random(out, &num);
 }
 
+int uuid_generate_random_safe(uuid_t out)
+{
+	int	num = 1;
+	/* No real reason to use the daemon for random uuid's -- yet */
+
+	if (get_random_fd() < 0)
+		return -1;
+
+	__uuid_generate_random(out, &num);
+	return 0;
+}
+
 
 /*
  * This is the generic front-end to uuid_generate_random and
@@ -700,10 +712,24 @@ void uuid_generate_random(uuid_t out)
  * /dev/urandom is available, since otherwise we won't have
  * high-quality randomness.
  */
-void uuid_generate(uuid_t out)
+static int _uuid_generate(uuid_t out)
 {
 	if (get_random_fd() >= 0)
-		uuid_generate_random(out);
+	{
+		int num = 1;
+		__uuid_generate_random(out, &num);
+		return 0;
+	}
 	else
-		uuid_generate_time(out);
+		return uuid_generate_time_generic(out);
+}
+
+void uuid_generate(uuid_t out)
+{
+	(void)_uuid_generate(out);
+}
+
+int uuid_generate_safe(uuid_t out)
+{
+	return _uuid_generate(out);
 }
diff --git a/libuuid/src/uuid.h b/libuuid/src/uuid.h
index 874d65a..2771255 100644
--- a/libuuid/src/uuid.h
+++ b/libuuid/src/uuid.h
@@ -79,7 +79,9 @@ void uuid_copy(uuid_t dst, const uuid_t src);
 void uuid_generate(uuid_t out);
 void uuid_generate_random(uuid_t out);
 void uuid_generate_time(uuid_t out);
-int uuid_generate_time_safe(uuid_t out);
+int uuid_generate_time_safe(uuid_t out) __attribute__((warn_unused_result));
+int uuid_generate_random_safe(uuid_t out) __attribute__((warn_unused_result));
+int uuid_generate_safe(uuid_t out) __attribute__((warn_unused_result));
 
 /* isnull.c */
 int uuid_is_null(const uuid_t uu);
diff --git a/libuuid/src/uuid.sym b/libuuid/src/uuid.sym
index 2cad51b..aec79e7 100644
--- a/libuuid/src/uuid.sym
+++ b/libuuid/src/uuid.sym
@@ -30,6 +30,8 @@ global:
 UUID_2.20 {
 global:
 	uuid_generate_time_safe;
+	uuid_generate_random_safe;
+	uuid_generate_safe;
 } UUID_1.0;
 
 
diff --git a/misc-utils/uuidgen.c b/misc-utils/uuidgen.c
index b83b124..e81e065 100644
--- a/misc-utils/uuidgen.c
+++ b/misc-utils/uuidgen.c
@@ -81,10 +81,16 @@ main (int argc, char *argv[])
 		}
 		break;
 	case DO_TYPE_RANDOM:
-		uuid_generate_random(uu);
+		if (uuid_generate_random_safe(uu) && !force) {
+			fprintf(stderr, _("/dev/[u]random unavailable.\n"));
+			exit(1);
+		}
 		break;
 	default:
-		uuid_generate(uu);
+		if (uuid_generate_safe(uu) && !force) {
+			fprintf(stderr, _("/dev/[u]random unavailable and uuidd not running.\n"));
+			exit(1);
+		}
 		break;
 	}
 
-- 
1.7.3.4


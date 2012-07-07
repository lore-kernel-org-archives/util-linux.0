Return-Path: util-linux-owner@vger.kernel.org
Received: from vps.qemfd.net ([173.230.130.29]:51661 "EHLO vps.qemfd.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360Ab2GGQCu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 7 Jul 2012 12:02:50 -0400
From: Nick Black <nick.black@sprezzatech.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, nick black <nick.black@sprezzatech.com>
Subject: [PATCH 1/4] use GCC format __attribute__ on sprinf
Date: Sat,  7 Jul 2012 11:51:40 -0400
Message-Id: <1341676300-27932-1-git-send-email-nick.black@sprezzatech.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: nick black <nick.black@sprezzatech.com>

---
 libblkid/src/blkidP.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libblkid/src/blkidP.h b/libblkid/src/blkidP.h
index 604de3d..bceda33 100644
--- a/libblkid/src/blkidP.h
+++ b/libblkid/src/blkidP.h
@@ -435,8 +435,10 @@ extern int blkid_probe_set_value(blkid_probe pr, const char *name,
                 unsigned char *data, size_t len);
 extern int blkid_probe_vsprintf_value(blkid_probe pr, const char *name,
                 const char *fmt, va_list ap);
+	;
 extern int blkid_probe_sprintf_value(blkid_probe pr, const char *name,
-                const char *fmt, ...);
+                const char *fmt, ...) __attribute__ ((format (printf,3,4)));
+
 extern int blkid_probe_set_magic(blkid_probe pr, blkid_loff_t offset,
 		size_t len, unsigned char *magic);
 
-- 
1.7.10.4


>From d8a5b55012c2e01bff78a9c1237f4f2a93bd9c3a Mon Sep 17 00:00:00 2001
From: nick black <nick.black@sprezzatech.com>
Date: Sat, 7 Jul 2012 11:41:15 -0400
Subject: [PATCH 2/4] properly check for ansi c99 vsnprint truncation

---
 libblkid/src/probe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index ce14526..33220df 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -1219,7 +1219,7 @@ int blkid_probe_vsprintf_value(blkid_probe pr, const char *name,
 
 	len = vsnprintf((char *) v->data, sizeof(v->data), fmt, ap);
 
-	if (len <= 0) {
+	if (len <= 0 || len >= sizeof(v->data)) {
 		blkid_probe_reset_last_value(pr);
 		return -1;
 	}
-- 
1.7.10.4


>From 330ff7edc480b4e897f946c30a2afa38c916b9d0 Mon Sep 17 00:00:00 2001
From: nick black <nick.black@sprezzatech.com>
Date: Sat, 7 Jul 2012 11:42:17 -0400
Subject: [PATCH 3/4] use memcpy() to cope with possible misalignment

---
 libblkid/src/topology/topology.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/libblkid/src/topology/topology.c b/libblkid/src/topology/topology.c
index 5cde187..02476e5 100644
--- a/libblkid/src/topology/topology.c
+++ b/libblkid/src/topology/topology.c
@@ -222,14 +222,13 @@ static int topology_set_value(blkid_probe pr, const char *name,
 		return 0;	/* ignore zeros */
 
 	if (chn->binary) {
-		unsigned long *v =
-			(unsigned long *) (chn->data + structoff);
-		*v = data;
+		memcpy(chn->data + structoff, &data, sizeof(data));
 		return 0;
 	}
 	return blkid_probe_sprintf_value(pr, name, "%llu", data);
 }
 
+
 /* the topology info is complete when we have at least "minimum_io_size" which
  * is provided by all blkid topology drivers */
 static int topology_is_complete(blkid_probe pr)
-- 
1.7.10.4


>From ffab21e12846dd9b9403c881721e415493805bd1 Mon Sep 17 00:00:00 2001
From: nick black <nick.black@sprezzatech.com>
Date: Sat, 7 Jul 2012 11:42:35 -0400
Subject: [PATCH 4/4] use proper printf format spec %lu

---
 libblkid/src/topology/topology.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libblkid/src/topology/topology.c b/libblkid/src/topology/topology.c
index 02476e5..73a397a 100644
--- a/libblkid/src/topology/topology.c
+++ b/libblkid/src/topology/topology.c
@@ -225,7 +225,7 @@ static int topology_set_value(blkid_probe pr, const char *name,
 		memcpy(chn->data + structoff, &data, sizeof(data));
 		return 0;
 	}
-	return blkid_probe_sprintf_value(pr, name, "%llu", data);
+	return blkid_probe_sprintf_value(pr, name, "%lu", data);
 }
 
 
-- 
1.7.10.4


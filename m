Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:54058 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751785AbdF1QlA (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 28 Jun 2017 12:41:00 -0400
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Lpgew-1dvRu82kKM-00fQpa for <util-linux@vger.kernel.org>; Wed, 28 Jun 2017
 18:40:58 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/8] lib/path: fix crash, pathbuf overflow
Date: Wed, 28 Jun 2017 18:40:50 +0200
Message-Id: <1498668057-8256-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498668057-8256-1-git-send-email-sweet_f_a@gmx.de>
References: <1498668057-8256-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Before:

$ lscpu -s "$(tr '\0' 'x' < /dev/zero | head -c 10000)"
Segmentation fault (core dumped)

After:

$ lscpu -s "$(tr '\0' 'x' < /dev/zero | head -c 10000)"
lscpu: invalid argument to --sysroot: File name too long

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 include/path.h    |  6 +++++-
 lib/path.c        | 14 ++++++++++----
 sys-utils/lscpu.c |  3 ++-
 sys-utils/lsmem.c |  3 ++-
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/path.h b/include/path.h
index 45da692..11c3367 100644
--- a/include/path.h
+++ b/include/path.h
@@ -27,7 +27,11 @@ extern cpu_set_t *path_read_cpuset(int, const char *path, ...)
 			      __attribute__ ((__format__ (__printf__, 2, 3)));
 extern cpu_set_t *path_read_cpulist(int, const char *path, ...)
 			       __attribute__ ((__format__ (__printf__, 2, 3)));
-extern void path_set_prefix(const char *);
+
+/* Returns: 0 on success, sets errno on error. */
+extern int path_set_prefix(const char *)
+			__attribute__((warn_unused_result));
+
 #endif /* HAVE_CPU_SET_T */
 
 #endif /* UTIL_LINUX_PATH_H */
diff --git a/lib/path.c b/lib/path.c
index 1a623bc..eaa6d88 100644
--- a/lib/path.c
+++ b/lib/path.c
@@ -244,12 +244,18 @@ path_read_cpulist(int maxcpus, const char *path, ...)
 	return set;
 }
 
-void
+int
 path_set_prefix(const char *prefix)
 {
-	prefixlen = strlen(prefix);
-	strncpy(pathbuf, prefix, sizeof(pathbuf));
-	pathbuf[sizeof(pathbuf) - 1] = '\0';
+	size_t len = strlen(prefix);
+
+	if (len >= sizeof(pathbuf) - 1) {
+		errno = ENAMETOOLONG;
+		return -1;
+	}
+	prefixlen = len;
+	strcpy(pathbuf, prefix);
+	return 0;
 }
 
 #endif /* HAVE_CPU_SET_T */
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 424b9de..f6e4727 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -2148,7 +2148,8 @@ int main(int argc, char *argv[])
 			mod->mode = c == 'p' ? OUTPUT_PARSABLE : OUTPUT_READABLE;
 			break;
 		case 's':
-			path_set_prefix(optarg);
+			if(path_set_prefix(optarg))
+				err(EXIT_FAILURE, _("invalid argument to %s"), "--sysroot");
 			mod->system = SYSTEM_SNAPSHOT;
 			break;
 		case 'x':
diff --git a/sys-utils/lsmem.c b/sys-utils/lsmem.c
index 04e7d20..e1ee5a5 100644
--- a/sys-utils/lsmem.c
+++ b/sys-utils/lsmem.c
@@ -470,7 +470,8 @@ int main(int argc, char **argv)
 			lsmem->want_summary = 0;
 			break;
 		case 's':
-			path_set_prefix(optarg);
+			if(path_set_prefix(optarg))
+				err(EXIT_FAILURE, _("invalid argument to %s"), "--sysroot");
 			break;
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
-- 
1.8.5.6


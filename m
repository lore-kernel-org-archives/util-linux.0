Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35365 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbdCSKRx (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 19 Mar 2017 06:17:53 -0400
Received: by mail-wm0-f66.google.com with SMTP id z133so9796156wmb.2
        for <util-linux@vger.kernel.org>; Sun, 19 Mar 2017 03:17:52 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/5] tests: add static keyword where needed [smatch scan]
Date: Sun, 19 Mar 2017 10:10:43 +0000
Message-Id: <20170319101045.3018-4-kerolasa@iki.fi>
In-Reply-To: <20170319101045.3018-1-kerolasa@iki.fi>
References: <20170319101045.3018-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libmount/src/context.c         | 2 +-
 libmount/src/lock.c            | 2 +-
 misc-utils/test_uuidd.c        | 8 ++++----
 tests/helpers/test_byteswap.c  | 6 +++---
 tests/helpers/test_pathnames.c | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/libmount/src/context.c b/libmount/src/context.c
index 44282c07b..e731749b4 100644
--- a/libmount/src/context.c
+++ b/libmount/src/context.c
@@ -2414,7 +2414,7 @@ int mnt_context_wait_for_children(struct libmnt_context *cxt,
 
 #ifdef TEST_PROGRAM
 
-struct libmnt_lock *lock;
+static struct libmnt_lock *lock;
 
 static void lock_fallback(void)
 {
diff --git a/libmount/src/lock.c b/libmount/src/lock.c
index c3cd226f4..06eff1344 100644
--- a/libmount/src/lock.c
+++ b/libmount/src/lock.c
@@ -560,7 +560,7 @@ void mnt_unlock_file(struct libmnt_lock *ml)
 
 #ifdef TEST_PROGRAM
 
-struct libmnt_lock *lock;
+static struct libmnt_lock *lock;
 
 /*
  * read number from @filename, increment the number and
diff --git a/misc-utils/test_uuidd.c b/misc-utils/test_uuidd.c
index d590f9632..66a9f2d3b 100644
--- a/misc-utils/test_uuidd.c
+++ b/misc-utils/test_uuidd.c
@@ -41,10 +41,10 @@
 
 #define LOG(level,args) if (loglev >= level) { fprintf args; }
 
-size_t nprocesses = 4;
-size_t nthreads = 4;
-size_t nobjects = 4096;
-size_t loglev = 1;
+static size_t nprocesses = 4;
+static size_t nthreads = 4;
+static size_t nobjects = 4096;
+static size_t loglev = 1;
 
 struct processentry {
 	pid_t		pid;
diff --git a/tests/helpers/test_byteswap.c b/tests/helpers/test_byteswap.c
index 0b996e09b..1b98f7697 100644
--- a/tests/helpers/test_byteswap.c
+++ b/tests/helpers/test_byteswap.c
@@ -19,7 +19,7 @@
 
 #include "bitops.h"
 
-uint16_t ary16[] = {
+static uint16_t ary16[] = {
 	0x0001, 0x0100,
 	0x1234, 0x3412,
 	0xff00, 0x00ff,
@@ -28,7 +28,7 @@ uint16_t ary16[] = {
 	0x0000, 0x0000
 	};
 
-uint32_t ary32[] = {
+static uint32_t ary32[] = {
 	0x00000001, 0x01000000,
 	0x80000000, 0x00000080,
 	0x12345678, 0x78563412,
@@ -38,7 +38,7 @@ uint32_t ary32[] = {
 	0x00000000, 0x00000000
 	};
 
-uint64_t ary64[] = {
+static uint64_t ary64[] = {
 	0x0000000000000001, 0x0100000000000000,
 	0x8000000000000000, 0x0000000000000080,
 	0x1234567812345678, 0x7856341278563412,
diff --git a/tests/helpers/test_pathnames.c b/tests/helpers/test_pathnames.c
index d5cdad829..2368641f1 100644
--- a/tests/helpers/test_pathnames.c
+++ b/tests/helpers/test_pathnames.c
@@ -29,7 +29,7 @@ struct hlpPath
 
 #define DEF_HLPPATH(_p)		{ #_p, _p }
 
-struct hlpPath paths[] =
+static struct hlpPath paths[] =
 {
 	DEF_HLPPATH(_PATH_DEFPATH),
 	DEF_HLPPATH(_PATH_DEFPATH_ROOT),
-- 
2.12.0


Return-Path: util-linux-owner@vger.kernel.org
Received: from vostochny.stro.at ([78.47.22.85]:33753 "EHLO vostochny.stro.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754322Ab1H2RCk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 29 Aug 2011 13:02:40 -0400
From: maximilian attems <max@stro.at>
To: util-linux@vger.kernel.org
Cc: maximilian attems <max@stro.at>
Subject: [PATCH] raw: fix shadowing of minor function
Date: Mon, 29 Aug 2011 18:59:35 +0200
Message-Id: <1314637175-30646-1-git-send-email-max@stro.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Noticed while compiling against klibc:
raw.c: In function ‘query’:
raw.c:219:16: error: called object ‘minor’ is not a function

Rename variable from minor to minor_raw.
While at it mark the functions as static and small whitespace fixes
as asked by checkpatch.

Signed-off-by: maximilian attems <max@stro.at>
---
 disk-utils/raw.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/disk-utils/raw.c b/disk-utils/raw.c
index c2c1a3e..88f2211 100644
--- a/disk-utils/raw.c
+++ b/disk-utils/raw.c
@@ -40,8 +40,8 @@ int	master_fd;
 int	raw_minor;
 
 void open_raw_ctl(void);
-int  query(int minor, const char *raw_name, int quiet);
-int  bind (int minor, int block_major, int block_minor);
+static int query(int minor_raw, const char *raw_name, int quiet);
+static int bind(int minor_raw, int block_major, int block_minor);
 
 
 static void usage(int err)
@@ -190,7 +190,7 @@ void open_raw_ctl(void)
 	}
 }
 
-int query(int minor, const char *raw_name, int quiet)
+static int query(int minor_raw, const char *raw_name, int quiet)
 {
 	struct raw_config_request rq;
 	static int has_worked = 0;
@@ -216,10 +216,10 @@ int query(int minor, const char *raw_name, int quiet)
 				 raw_name);
 			exit(2);
 		}
-		minor = minor(statbuf.st_rdev);
+		minor_raw = minor(statbuf.st_rdev);
 	}
 
-	rq.raw_minor = minor;
+	rq.raw_minor = minor_raw;
 	err = ioctl(master_fd, RAW_GETBIND, &rq);
 	if (err < 0) {
 		if (quiet && errno == ENODEV)
@@ -242,12 +242,12 @@ int query(int minor, const char *raw_name, int quiet)
 	return 0;
 }
 
-int bind(int minor, int block_major, int block_minor)
+static int bind(int minor_raw, int block_major, int block_minor)
 {
 	struct raw_config_request rq;
 	int err;
 
-	rq.raw_minor   = minor;
+	rq.raw_minor   = minor_raw;
 	rq.block_major = block_major;
 	rq.block_minor = block_minor;
 	err = ioctl(master_fd, RAW_SETBIND, &rq);
-- 
1.7.5.4


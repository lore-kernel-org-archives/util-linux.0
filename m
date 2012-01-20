Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35382 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750864Ab2ATEAg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 19 Jan 2012 23:00:36 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q0K40atn018549
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Thu, 19 Jan 2012 23:00:36 -0500
Received: from localhost (beach.nrt.redhat.com [10.64.200.71])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q0K40Zqq026852
	for <util-linux@vger.kernel.org>; Thu, 19 Jan 2012 23:00:35 -0500
Date: Fri, 20 Jan 2012 13:00:34 +0900 (JST)
Message-Id: <20120120.130034.1018682633157048125.yamato@redhat.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] Fix a potential memory leak at mnt_table_parse_dir
From: Masatake YAMATO <yamato@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

mnt_table_parse_dir in libmount/src/tab_parse.c calls
scandir, and then opendir. When the latter one, opendir is failed, 
buffers allocated in scandir are not released.

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 libmount/src/tab_parse.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/libmount/src/tab_parse.c b/libmount/src/tab_parse.c
index 6cd66af..33aa7ef 100644
--- a/libmount/src/tab_parse.c
+++ b/libmount/src/tab_parse.c
@@ -431,7 +431,7 @@ int mnt_table_parse_file(struct libmnt_table *tb, const char *filename)
 
 static int mnt_table_parse_dir(struct libmnt_table *tb, const char *dirname)
 {
-	int n = 0, i;
+	int n = 0, i, r = 0;
 	DIR *dir = NULL;
 	struct dirent **namelist = NULL;
 
@@ -443,8 +443,10 @@ static int mnt_table_parse_dir(struct libmnt_table *tb, const char *dirname)
 
 	/* let use "at" functions rather than play crazy games with paths... */
 	dir = opendir(dirname);
-	if (!dir)
-		return -errno;
+	if (!dir) {
+		r = -errno;
+		goto out;
+	}
 
 	for (i = 0; i < n; i++) {
 		struct dirent *d = namelist[i];
@@ -480,12 +482,13 @@ static int mnt_table_parse_dir(struct libmnt_table *tb, const char *dirname)
 		}
 	}
 
+out:
 	for (i = 0; i < n; i++)
 		free(namelist[i]);
 	free(namelist);
 	if (dir)
 		closedir(dir);
-	return 0;
+	return r;
 }
 
 struct libmnt_table *__mnt_new_table_from_file(const char *filename, int fmt)
-- 
1.7.7.5


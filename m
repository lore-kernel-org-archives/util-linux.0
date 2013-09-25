Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f47.google.com ([209.85.220.47]:60811 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754681Ab3IYPcc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Sep 2013 11:32:32 -0400
Received: by mail-pa0-f47.google.com with SMTP id kp14so5363064pab.34
        for <util-linux@vger.kernel.org>; Wed, 25 Sep 2013 08:32:32 -0700 (PDT)
From: Namhyung Kim <namhyung@gmail.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/4] libmount: Set each optstr's to NULL if failed
Date: Thu, 26 Sep 2013 00:32:05 +0900
Message-Id: <1380123126-3030-3-git-send-email-namhyung@gmail.com>
In-Reply-To: <1380123126-3030-1-git-send-email-namhyung@gmail.com>
References: <1380123126-3030-1-git-send-email-namhyung@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When mnt_split_optstr() failed in the middle, vfs, fs, user optstr's
are freed but not reset.  It can lead to double frees at the end of
mnt_fs_{ap,pre}pend_options().

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 libmount/src/optstr.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/libmount/src/optstr.c b/libmount/src/optstr.c
index 5e9e708..17b129d 100644
--- a/libmount/src/optstr.c
+++ b/libmount/src/optstr.c
@@ -567,12 +567,18 @@ int mnt_split_optstr(const char *optstr, char **user, char **vfs,
 			rc = __mnt_optstr_append_option(fs, name, namesz,
 								val, valsz);
 		if (rc) {
-			if (vfs)
+			if (vfs) {
 				free(*vfs);
-			if (fs)
+				*vfs = NULL;
+			}
+			if (fs) {
 				free(*fs);
-			if (user)
+				*fs = NULL;
+			}
+			if (user) {
 				free(*user);
+				*user = NULL;
+			}
 			return rc;
 		}
 	}
-- 
1.7.9.2


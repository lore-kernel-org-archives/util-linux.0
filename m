Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:51807 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932254Ab3AITnS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Jan 2013 14:43:18 -0500
Received: by mail-wi0-f174.google.com with SMTP id hq4so769848wib.13
        for <util-linux@vger.kernel.org>; Wed, 09 Jan 2013 11:43:17 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/4] ipcmk: remove unnecessary create_key() function
Date: Wed,  9 Jan 2013 19:36:54 +0000
Message-Id: <1357760216-4068-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1357760216-4068-1-git-send-email-kerolasa@iki.fi>
References: <1357760216-4068-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use seed_random() from randutils instead, and stop generating new seed
when it does not have to happen

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/ipcmk.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/sys-utils/ipcmk.c b/sys-utils/ipcmk.c
index a862ba1..9b943b7 100644
--- a/sys-utils/ipcmk.c
+++ b/sys-utils/ipcmk.c
@@ -34,30 +34,23 @@
 #include "nls.h"
 #include "strutils.h"
 #include "closestream.h"
-
-static key_t create_key(void)
-{
-	struct timeval now;
-	gettimeofday(&now, NULL);
-	srandom(now.tv_usec);
-	return random();
-}
+#include "randutils.h"
 
 static int create_shm(size_t size, int permission)
 {
-	key_t key = create_key();
+	key_t key = random();
 	return shmget(key, size, permission | IPC_CREAT);
 }
 
 static int create_msg(int permission)
 {
-	key_t key = create_key();
+	key_t key = random();
 	return msgget(key, permission | IPC_CREAT);
 }
 
 static int create_sem(int nsems, int permission)
 {
-	key_t key = create_key();
+	key_t key = random();
 	return semget(key, nsems, permission | IPC_CREAT);
 }
 
@@ -100,6 +93,7 @@ int main(int argc, char **argv)
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 	atexit(close_stdout);
+	seed_random();
 
 	while((opt = getopt_long(argc, argv, "hM:QS:p:Vh", longopts, NULL)) != -1) {
 		switch(opt) {
-- 
1.8.1


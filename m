Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34461 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110AbbJML3Y (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 13 Oct 2015 07:29:24 -0400
Received: by wicgb1 with SMTP id gb1so85150850wic.1
        for <util-linux@vger.kernel.org>; Tue, 13 Oct 2015 04:29:23 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/8] nologin: require /etc/nologin.txt to be file
Date: Tue, 13 Oct 2015 12:29:08 +0100
Message-Id: <1444735754-18976-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1444735754-18976-1-git-send-email-kerolasa@iki.fi>
References: <1444735754-18976-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This makes silly practical jokes impossible, like for example symlinking
/dev/null or dev/random to /etc/nologin.txt

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/nologin.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/login-utils/nologin.c b/login-utils/nologin.c
index 3be50ca..0a06ef8 100644
--- a/login-utils/nologin.c
+++ b/login-utils/nologin.c
@@ -3,6 +3,7 @@
  */
 
 #include <stdio.h>
+#include <sys/stat.h>
 #include <sys/types.h>
 #include <fcntl.h>
 #include <string.h>
@@ -38,6 +39,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 int main(int argc, char *argv[])
 {
 	int c, fd;
+	struct stat st;
 	static const struct option longopts[] = {
 		{ "help",    0, 0, 'h' },
 		{ "version", 0, 0, 'V' },
@@ -63,7 +65,8 @@ int main(int argc, char *argv[])
 	}
 
 	fd = open(_PATH_NOLOGIN_TXT, O_RDONLY);
-	if (fd >= 0) {
+	c = fstat(fd, &st);
+	if (fd >= 0 && !c && S_ISREG(st.st_mode)) {
 		char buf[BUFSIZ];
 		ssize_t rd;
 
-- 
2.6.1


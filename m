Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:49279 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244Ab2JNUV0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:21:26 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so1315606wib.1
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:21:25 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/19] sd-daemon: fix cppcheck warnings
Date: Sun, 14 Oct 2012 21:20:58 +0100
Message-Id: <1350246070-10544-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[misc-utils/sd-daemon.c:91]: (style) Checking if unsigned variable 'l' is \
less than zero.
[misc-utils/sd-daemon.c:254]: (warning) Comparison of a boolean \
expression with an integer.
[misc-utils/sd-daemon.c:363]: (style) Checking if unsigned variable \
'length' is less than zero.
[misc-utils/sd-daemon.c:366]: (style) Checking if unsigned variable \
'length' is less than zero.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/sd-daemon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/misc-utils/sd-daemon.c b/misc-utils/sd-daemon.c
index 763e079..21399e2 100644
--- a/misc-utils/sd-daemon.c
+++ b/misc-utils/sd-daemon.c
@@ -88,7 +88,7 @@ _sd_export_ int sd_listen_fds(int unset_environment) {
                 goto finish;
         }
 
-        if (!p || *p || l <= 0) {
+	if (!p || *p || l == 0) {
                 r = -EINVAL;
                 goto finish;
         }
@@ -251,7 +251,7 @@ static int sd_is_socket_internal(int fd, int type, int listening) {
                 if (l != sizeof(accepting))
                         return -EINVAL;
 
-                if (!accepting != !listening)
+		if ((!accepting) != (!listening))
                         return 0;
         }
 
@@ -360,10 +360,10 @@ _sd_export_ int sd_is_socket_unix(int fd, int type, int listening, const char *p
                 return 0;
 
         if (path) {
-                if (length <= 0)
+		if (length == 0)
                         length = strlen(path);
 
-                if (length <= 0)
+		if (length == 0)
                         /* Unnamed socket */
                         return l == offsetof(struct sockaddr_un, sun_path);
 
-- 
1.7.12.2


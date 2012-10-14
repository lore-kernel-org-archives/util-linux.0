Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:39673 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381Ab2JNUVm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:21:42 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so2680278wey.19
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:21:41 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 18/19] build-sys: remove gethostbyname() check
Date: Sun, 14 Oct 2012 21:21:09 +0100
Message-Id: <1350246070-10544-19-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Removed as unnecessary, there are no references to gethostbyname() in
code.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index d94f271..075bfba 100644
--- a/configure.ac
+++ b/configure.ac
@@ -340,10 +340,6 @@ AC_CHECK_MEMBER(struct sockaddr.sa_len,
 	 #include <sys/socket.h>])
 
 SOCKET_LIBS=
-AC_SEARCH_LIBS([gethostbyname], [nsl],
-	[if test x"$ac_cv_search_gethostbyname" != x"none required"; then
-		SOCKET_LIBS="$SOCKET_LIBS -lnsl";
-	 fi])
 AC_SEARCH_LIBS([socket], [socket],
 	[if test x"$ac_cv_search_socket" != x"none required"; then
 		SOCKET_LIBS="$SOCKET_LIBS -lsocket";
-- 
1.7.12.2


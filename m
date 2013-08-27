Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f52.google.com ([74.125.83.52]:51038 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab3H0SGj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 27 Aug 2013 14:06:39 -0400
Received: by mail-ee0-f52.google.com with SMTP id c41so2465955eek.11
        for <util-linux@vger.kernel.org>; Tue, 27 Aug 2013 11:06:37 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 02/17] wall: send message also to sessions opened by user 'sleeper'
Date: Tue, 27 Aug 2013 19:06:04 +0100
Message-Id: <1377626779-26030-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
References: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Ignoring an user by name, and not telling about it in manual page, is
unexpected.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/wall.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/term-utils/wall.c b/term-utils/wall.c
index 2d87e47..98dc5c7 100644
--- a/term-utils/wall.c
+++ b/term-utils/wall.c
@@ -69,7 +69,6 @@
 #include "fileutils.h"
 #include "closestream.h"
 
-#define	IGNOREUSER	"sleeper"
 #define WRITE_TIME_OUT	300		/* in seconds */
 
 /* Function prototypes */
@@ -157,9 +156,7 @@ int main(int argc, char **argv)
 	iov.iov_base = mbuf;
 	iov.iov_len = mbufsize;
 	while((utmpptr = getutent())) {
-		if (!utmpptr->ut_name[0] ||
-		    !strncmp(utmpptr->ut_name, IGNOREUSER,
-			     sizeof(utmpptr->ut_name)))
+		if (!utmpptr->ut_name[0])
 			continue;
 #ifdef USER_PROCESS
 		if (utmpptr->ut_type != USER_PROCESS)
-- 
1.8.4


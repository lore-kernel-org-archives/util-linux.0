Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:65347 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080Ab2DEUkz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 5 Apr 2012 16:40:55 -0400
Received: by mail-ee0-f46.google.com with SMTP id c41so559672eek.19
        for <util-linux@vger.kernel.org>; Thu, 05 Apr 2012 13:40:55 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/3] eject: close open file [cppcheck]
Date: Thu,  5 Apr 2012 22:40:48 +0200
Message-Id: <1333658449-20112-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1333658449-20112-1-git-send-email-kerolasa@iki.fi>
References: <1333658449-20112-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[eject.c:498]: (error) Resource leak: f

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/eject.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index 790ab3a..2056bf8 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -495,6 +495,7 @@ static int read_speed(const char *devname)
 					errx(EXIT_FAILURE,
 						_("%s: failed to read speed"),
 						_PATH_PROC_CDROMINFO);
+				fclose(f);
 				return atoi(str);
 			}
 		}
-- 
1.7.9.6


Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:64919 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244Ab2JNUVZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:21:25 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so1296035wib.1
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:21:24 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/19] docs: add line breaks to whereis.1
Date: Sun, 14 Oct 2012 21:20:57 +0100
Message-Id: <1350246070-10544-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Fix to tools script checkmans.sh warning.

testing: /home/src/util-linux/misc-utils/whereis.1
:120: warning [p 1, 10.8i, div `an-div', 0.0i]: can't break line

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/whereis.1 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc-utils/whereis.1 b/misc-utils/whereis.1
index 988462f..f7f7d29 100644
--- a/misc-utils/whereis.1
+++ b/misc-utils/whereis.1
@@ -117,9 +117,9 @@ environment variable (since version 2.21).
 .TP 20
 /{bin,sbin,etc}
 .TP
-/usr/{lib,bin,old,new,local,games,include,etc,src,man,sbin,X386,TeX,g++-include}
+/usr/{lib,\:bin,\:old,\:new,\:local,\:games,\:include,\:etc,\:src,\:man,\:sbin,\:X386,\:TeX,\:g++-include}
 .TP
-/usr/local/{X386,TeX,X11,include,lib,man,etc,bin,games,emacs}
+/usr/local/{X386,\:TeX,\:X11,\:include,\:lib,\:man,\:etc,\:bin,\:games,\:emacs}
 .SH "SEE ALSO"
 .BR chdir (2V)
 .SH BUGS
-- 
1.7.12.2


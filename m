Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:59392 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751550AbaEBCiI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 1 May 2014 22:38:08 -0400
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Cc: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Subject: [PATCH 16/16] libuuid/man/uuid.3: Improve the typesetting of the manual
Date: Fri,  2 May 2014 02:37:41 +0000
Message-Id: <1398998261-17569-9-git-send-email-bjarniig@rhi.hi.is>
In-Reply-To: <1398998261-17569-1-git-send-email-bjarniig@rhi.hi.is>
References: <1398998261-17569-1-git-send-email-bjarniig@rhi.hi.is>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  Protect a full stop (.), that begins or ends a string, with \&

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---

Notes (default):
    I am checking the man pages in alphabetic order (<dir>/<name>) with a script

 libuuid/man/uuid.3 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libuuid/man/uuid.3 b/libuuid/man/uuid.3
index 62b99eb..37b0499 100644
--- a/libuuid/man/uuid.3
+++ b/libuuid/man/uuid.3
@@ -49,7 +49,7 @@ of a name clash.
 .SH "CONFORMING TO"
 OSF DCE 1.1
 .SH AUTHOR
-Theodore Y. Ts'o
+Theodore Y.\& Ts'o
 .SH AVAILABILITY
 .B libuuid
 is part of the util-linux package since version 2.15.1 and is available from
-- 
1.9.0


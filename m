Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:59374 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312AbaEBCiI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 1 May 2014 22:38:08 -0400
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Cc: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Subject: [PATCH 10/16] libuuid/man/uuid_copy.3: Improve the typesetting of the manual
Date: Fri,  2 May 2014 02:37:35 +0000
Message-Id: <1398998261-17569-3-git-send-email-bjarniig@rhi.hi.is>
In-Reply-To: <1398998261-17569-1-git-send-email-bjarniig@rhi.hi.is>
References: <1398998261-17569-1-git-send-email-bjarniig@rhi.hi.is>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  Protect a full stop (.), that begins or ends a string, with \&

  Inhibit right adjusting for the section "SEE ALSO" with ".na/.ad", or
use '.ad l' for the entire manual

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 libuuid/man/uuid_copy.3 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libuuid/man/uuid_copy.3 b/libuuid/man/uuid_copy.3
index f31d94e..5159fa6 100644
--- a/libuuid/man/uuid_copy.3
+++ b/libuuid/man/uuid_copy.3
@@ -47,11 +47,12 @@ function copies the UUID variable
 The copied UUID is returned in the location pointed to by
 .IR dst .
 .SH AUTHOR
-Theodore Y. Ts'o
+Theodore Y.\& Ts'o
 .SH AVAILABILITY
 .B libuuid
 is part of the util-linux package since version 2.15.1 and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
+.na
 .SH "SEE ALSO"
 .BR uuid (3),
 .BR uuid_clear (3),
@@ -60,3 +61,4 @@ ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
 .BR uuid_is_null (3),
 .BR uuid_parse (3),
 .BR uuid_unparse (3)
+.ad
-- 
1.9.0


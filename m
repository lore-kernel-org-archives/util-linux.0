Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:59383 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbaEBCiI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 1 May 2014 22:38:08 -0400
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Cc: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Subject: [PATCH 13/16] libuuid/man/uuid_parse.3: Improve the typesetting of the manual
Date: Fri,  2 May 2014 02:37:38 +0000
Message-Id: <1398998261-17569-6-git-send-email-bjarniig@rhi.hi.is>
In-Reply-To: <1398998261-17569-1-git-send-email-bjarniig@rhi.hi.is>
References: <1398998261-17569-1-git-send-email-bjarniig@rhi.hi.is>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  Use \e for the printable escape character instead of \\

  Protect a full stop (.), that begins or ends a string, with \&

  Inhibit right adjusting for the section "SEE ALSO" with ".na/.ad", or
use '.ad l' for the entire manual

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 libuuid/man/uuid_parse.3 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/libuuid/man/uuid_parse.3 b/libuuid/man/uuid_parse.3
index 9030345..31a5926 100644
--- a/libuuid/man/uuid_parse.3
+++ b/libuuid/man/uuid_parse.3
@@ -46,7 +46,7 @@ function converts the UUID string given by
 into the binary representation.  The input UUID is a string of the form
 1b4e28ba\-2fa1\-11d2\-883f\-b9a761bde3fb (in
 .BR printf (3)
-format "%08x\-%04x\-%04x\-%04x\-%012x", 36 bytes plus the trailing '\\0').
+format "%08x\-%04x\-%04x\-%04x\-%012x", 36 bytes plus the trailing '\e0').
 .SH RETURN VALUE
 Upon successfully parsing the input string, 0 is returned, and the UUID is
 stored in the location pointed to by
@@ -55,11 +55,12 @@ otherwise \-1 is returned.
 .SH "CONFORMING TO"
 OSF DCE 1.1
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
@@ -69,3 +70,4 @@ ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
 .BR uuid_is_null (3),
 .BR uuid_time (3),
 .BR uuid_unparse (3)
+.ad
-- 
1.9.0


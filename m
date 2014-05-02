Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:59391 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751540AbaEBCiI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 1 May 2014 22:38:08 -0400
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Cc: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Subject: [PATCH 15/16] libuuid/man/uuid_unparse.3: Improve the typesetting of the manual
Date: Fri,  2 May 2014 02:37:40 +0000
Message-Id: <1398998261-17569-8-git-send-email-bjarniig@rhi.hi.is>
In-Reply-To: <1398998261-17569-1-git-send-email-bjarniig@rhi.hi.is>
References: <1398998261-17569-1-git-send-email-bjarniig@rhi.hi.is>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  Change '\-' (minus) to '-' (code "hyphen-minus", rendered with the
glyph 'hyphen' in troff), if it is a part of a compound word.

  Use \e to print the escape character, instead of \\, as \e is not
interpreted in copy mode

  Protect a full stop (.), that begins or ends a string, with \&

  Inhibit right adjusting for the section "SEE ALSO" with ".na/.ad", or
use '.ad l' for the entire manual

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 libuuid/man/uuid_unparse.3 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/libuuid/man/uuid_unparse.3 b/libuuid/man/uuid_unparse.3
index a7ab5d8..1e0116d 100644
--- a/libuuid/man/uuid_unparse.3
+++ b/libuuid/man/uuid_unparse.3
@@ -45,7 +45,7 @@ The
 .B uuid_unparse
 function converts the supplied UUID
 .I uu
-from the binary representation into a 36\-byte string (plus tailing '\\0')
+from the binary representation into a 36-byte string (plus tailing '\e0')
 of the form 1b4e28ba\-2fa1\-11d2\-883f\-0016d3cca427 and stores this
 value in the character string pointed to by
 .IR out .
@@ -63,11 +63,12 @@ may be used.
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
@@ -77,3 +78,4 @@ ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
 .BR uuid_time (3),
 .BR uuid_is_null (3),
 .BR uuid_parse (3)
+.ad
-- 
1.9.0


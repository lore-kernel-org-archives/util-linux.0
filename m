Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:59375 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447AbaEBCiI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 1 May 2014 22:38:08 -0400
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Cc: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Subject: [PATCH 11/16] libuuid/man/uuid_generate.3: Improve the typesetting of the manual
Date: Fri,  2 May 2014 02:37:36 +0000
Message-Id: <1398998261-17569-4-git-send-email-bjarniig@rhi.hi.is>
In-Reply-To: <1398998261-17569-1-git-send-email-bjarniig@rhi.hi.is>
References: <1398998261-17569-1-git-send-email-bjarniig@rhi.hi.is>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  Change '-' to '\-', if it means a minus

  Protect a full stop (.), that begins or ends a string, with \&

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 libuuid/man/uuid_generate.3 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libuuid/man/uuid_generate.3 b/libuuid/man/uuid_generate.3
index 3bb789c..19904d7 100644
--- a/libuuid/man/uuid_generate.3
+++ b/libuuid/man/uuid_generate.3
@@ -104,11 +104,11 @@ and in the future.
 The newly created UUID is returned in the memory location pointed to by
 .IR out .
 .B uuid_generate_time_safe
-returns zero if the UUID has been generated in a safe manner, -1 otherwise.
+returns zero if the UUID has been generated in a safe manner, \-1 otherwise.
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


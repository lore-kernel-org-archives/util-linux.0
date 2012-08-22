Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcahe.dreamhost.com ([208.97.132.74]:35372 "EHLO
	homiemail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753195Ab2HVI5N (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 22 Aug 2012 04:57:13 -0400
Subject: [PATCH] fdisk: document FDISK_DEBUG
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 22 Aug 2012 10:57:09 +0200
Message-ID: <1345625829.2623.0.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Add the corresponding entry in the manpage.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisks/fdisk.8 |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/fdisks/fdisk.8 b/fdisks/fdisk.8
index 5233f0f..3c53473 100644
--- a/fdisks/fdisk.8
+++ b/fdisks/fdisk.8
@@ -271,6 +271,11 @@ The option `dump partition table to file' is missing.
 .\" Jakub Jelinek (jj@sunsite.mff.cuni.cz)
 .\" Andreas Neuper (ANeuper@GUUG.de)
 .\" and many others.
+
+.SH ENVIRONMENT
+.IP FDISK_DEBUG=0xffff
+enables debug output
+
 .SH "SEE ALSO"
 .BR cfdisk (8),
 .BR sfdisk (8),
-- 
1.7.4.1




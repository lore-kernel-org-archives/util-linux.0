Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:35076 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbcGNN2r (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Jul 2016 09:28:47 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 24304AC8D
	for <util-linux@vger.kernel.org>; Thu, 14 Jul 2016 13:28:46 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 2/7] libmount: Introduce new error: MNT_ERR_LOOPOVERLAP
Message-ID: <bb9d560a-fe5a-dff6-babc-dc5b65362db9@suse.cz>
Date: Thu, 14 Jul 2016 15:28:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This error code is intended for situations where overlapping loop device exists
and cannot be reused.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 libmount/src/libmount.h.in | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/libmount/src/libmount.h.in b/libmount/src/libmount.h.in
index cadf4a7..83f05ef 100644
--- a/libmount/src/libmount.h.in
+++ b/libmount/src/libmount.h.in
@@ -159,7 +159,7 @@ enum {
  *
  * loopdev setup failed, errno set by libc
  */
-#define MNT_ERR_LOOPDEV	     5003
+#define MNT_ERR_LOOPDEV      5003
 /**
  * MNT_ERR_MOUNTOPT:
  *
@@ -178,6 +178,12 @@ enum {
  * libblkid detected more filesystems on the device
  */
 #define MNT_ERR_AMBIFS       5006
+/**
+ * MNT_ERR_LOOPOVERLAP:
+ *
+ * detected overlapping loop device that cannot be re-used
+ */
+#define MNT_ERR_LOOPOVERLAP 5007
 
 #ifndef __GNUC_PREREQ
 # if defined __GNUC__ && defined __GNUC_MINOR__
-- 
2.9.0

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

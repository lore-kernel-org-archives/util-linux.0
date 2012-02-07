Return-Path: util-linux-owner@vger.kernel.org
Received: from mailbigip.dreamhost.com ([208.97.132.5]:60129 "EHLO
	homiemail-a62.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755661Ab2BGWmA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 Feb 2012 17:42:00 -0500
Subject: [PATCH 1/4] include: add /proc/locks path to pathnames
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 07 Feb 2012 23:41:55 +0100
Message-ID: <1328654515.3500.10.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 include/pathnames.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/pathnames.h b/include/pathnames.h
index e6e3d19..3547e8e 1006447
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -88,6 +88,7 @@
 #define _PATH_PROC_PARTITIONS	"/proc/partitions"
 #define _PATH_PROC_DEVICES	"/proc/devices"
 #define _PATH_PROC_MOUNTINFO	"/proc/self/mountinfo"
+#define _PATH_PROC_LOCKS        "/proc/locks"
 
 #define _PATH_SYS_BLOCK		"/sys/block"
 #define _PATH_SYS_DEVBLOCK	"/sys/dev/block"
-- 
1.7.4.1





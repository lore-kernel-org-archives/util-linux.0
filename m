Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:60088 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754135AbaHLUPe (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Aug 2014 16:15:34 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/3] textual: make the license of chrt and taskset slightly more explicit
Date: Tue, 12 Aug 2014 22:15:17 +0200
Message-Id: <1407874518-12776-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1407874518-12776-1-git-send-email-bensberg@justemail.net>
References: <1407874518-12776-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This makes it match the license of the man pages.
While there, also tweak some other comment lines.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 schedutils/chrt.c    |   10 ++++------
 schedutils/taskset.c |    5 ++---
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index e9af427..fec26fd 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -1,13 +1,11 @@
 /*
- * chrt.c - chrt
- * Command-line utility for manipulating a task's real-time attributes 
+ * chrt.c - manipulate a task's real-time attributes
  *
- * Robert Love <rml@tech9.net>
- * 27-Apr-2002: initial version
- * 04-May-2011: make thread aware - Davidlohr Bueso <dave@gnu.org>
+ * 27-Apr-2002: initial version - Robert Love <rml@tech9.net>
+ * 04-May-2011: make it thread-aware - Davidlohr Bueso <dave@gnu.org>
  *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, v2, as
+ * it under the terms of the GNU General Public License, version 2, as
  * published by the Free Software Foundation
  *
  * This program is distributed in the hope that it will be useful,
diff --git a/schedutils/taskset.c b/schedutils/taskset.c
index c2b9ab6..6ebca06 100644
--- a/schedutils/taskset.c
+++ b/schedutils/taskset.c
@@ -1,9 +1,8 @@
 /*
- * taskset.c - command-line utility for setting and retrieving
- *             a task's CPU affinity
+ * taskset.c - set or retrieve a task's CPU affinity
  *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, v2, as
+ * it under the terms of the GNU General Public License, version 2, as
  * published by the Free Software Foundation
  *
  * This program is distributed in the hope that it will be useful,
-- 
1.7.0.4


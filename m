Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-b32.telenor.se ([213.150.131.21]:33541 "EHLO
	smtprelay-b32.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbaGKNJV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 11 Jul 2014 09:09:21 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b32.telenor.se (Postfix) with ESMTP id 74DD084E3D
	for <util-linux@vger.kernel.org>; Fri, 11 Jul 2014 15:08:46 +0200 (CEST)
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH 2/2] uuidd.rc: Requires remote_fs
Date: Fri, 11 Jul 2014 15:08:41 +0200
Message-Id: <1405084121-21915-2-git-send-email-andreas@fatal.se>
In-Reply-To: <1405084121-21915-1-git-send-email-andreas@fatal.se>
References: <1405084121-21915-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The Debian package checking tool lintian thinks that the script is
missing Requires on $remote_fs because it pokes at stuff under /usr
and it's probably right.

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 misc-utils/uuidd.rc.in | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc-utils/uuidd.rc.in b/misc-utils/uuidd.rc.in
index 3c5528a..cebe228 100644
--- a/misc-utils/uuidd.rc.in
+++ b/misc-utils/uuidd.rc.in
@@ -1,8 +1,8 @@
 #! /bin/sh -e
 ### BEGIN INIT INFO
 # Provides:          uuidd
-# Required-Start:    $time $local_fs
-# Required-Stop:     $time $local_fs
+# Required-Start:    $time $local_fs $remote_fs
+# Required-Stop:     $time $local_fs $remote_fs
 # Default-Start:     2 3 4 5
 # Default-Stop:      0 1 6
 # Short-Description: uuidd daemon
-- 
2.0.0


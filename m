Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-b32.telenor.se ([213.150.131.21]:33539 "EHLO
	smtprelay-b32.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123AbaGKNJV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 11 Jul 2014 09:09:21 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b32.telenor.se (Postfix) with ESMTP id 7304184C09
	for <util-linux@vger.kernel.org>; Fri, 11 Jul 2014 15:08:46 +0200 (CEST)
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH 1/2] uuidd.rc: drop on-demand mode from script
Date: Fri, 11 Jul 2014 15:08:40 +0200
Message-Id: <1405084121-21915-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The on-demand mode was dropped from libuuid in
commit ea4f8845f0241c7 "libuuid: don't exec uuidd"

You now need systemd (socket activation) to use
uuidd on demand.

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 misc-utils/uuidd.rc.in | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/misc-utils/uuidd.rc.in b/misc-utils/uuidd.rc.in
index 27b75c6..3c5528a 100644
--- a/misc-utils/uuidd.rc.in
+++ b/misc-utils/uuidd.rc.in
@@ -13,11 +13,6 @@
 #
 set -e
 
-# libuuid is able to execute the uuid daemon on-demand -- in such a case
-# the daemon binary must be setuid to an unprivileged user (e.g. uuidd:uuidd).
-#                                                    [-- kzak Jun 2009]
-UUIDD_ON_DEMAND_ONLY="no"
-
 PATH=/bin:/usr/bin:/sbin:/usr/sbin
 DAEMON=/usr/sbin/uuidd
 UUIDD_USER=uuidd
@@ -36,11 +31,7 @@ case "$1" in
 		mkdir -p $UUIDD_DIR
 		chown -R $UUIDD_USER:$UUIDD_GROUP $UUIDD_DIR
 	fi
-	if test "$UUIDD_ON_DEMAND_ONLY" = yes; then
-		echo -n "(on demand only)"
-	else
-		start_daemon -p $PIDFILE $DAEMON
-	fi
+	start_daemon -p $PIDFILE $DAEMON
 	log_end_msg $?
     ;;
   stop)
-- 
2.0.0


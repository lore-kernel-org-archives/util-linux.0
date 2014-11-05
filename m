Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.codeweavers.com ([216.251.189.131]:33931 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbaKECCx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 4 Nov 2014 21:02:53 -0500
Received: from ppp83-237-204-188.pppoe.mtu-net.ru ([83.237.204.188] helo=[192.168.10.200])
	by mail.codeweavers.com with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <nsivov@codeweavers.com>)
	id 1Xlpgi-0002P6-MT
	for util-linux@vger.kernel.org; Tue, 04 Nov 2014 19:47:09 -0600
Message-ID: <5459819A.8030601@codeweavers.com>
Date: Wed, 05 Nov 2014 04:47:06 +0300
From: Nikolay Sivov <nsivov@codeweavers.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH] misc-utils: Fixed a typo in daemon logging message
Content-Type: multipart/mixed;
 boundary="------------070308080201090005080202"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.
--------------070308080201090005080202
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

---

--------------070308080201090005080202
Content-Type: text/x-patch;
 name="0001-misc-utils-Fixed-a-typo-in-daemon-logging-message.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-misc-utils-Fixed-a-typo-in-daemon-logging-message.patch"

>From 72c992e6b1e6b404c27fcab4f38cf9933cb1a560 Mon Sep 17 00:00:00 2001
From: Nikolay Sivov <nsivov@codeweavers.com>
Date: Wed, 5 Nov 2014 04:41:48 +0300
Subject: [PATCH] misc-utils: Fixed a typo in daemon logging message

Signed-off-by: Nikolay Sivov <nsivov@codeweavers.com>
---
 misc-utils/uuidd.rc.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/uuidd.rc.in b/misc-utils/uuidd.rc.in
index cebe228..26273e5 100644
--- a/misc-utils/uuidd.rc.in
+++ b/misc-utils/uuidd.rc.in
@@ -35,7 +35,7 @@ case "$1" in
 	log_end_msg $?
     ;;
   stop)
-	log_daemon_msg "Stopping uuidd generator" "uuidd"
+	log_daemon_msg "Stopping uuid generator" "uuidd"
 	killproc -p $PIDFILE $DAEMON
 	log_end_msg $?
     ;;
-- 
2.1.1


--------------070308080201090005080202--

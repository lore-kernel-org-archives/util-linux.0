Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:65084 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752143AbdFPOsn (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 16 Jun 2017 10:48:43 -0400
To: Karel Zak <kzak@redhat.com>
Subject: Identical commits?
Cc: util-linux <util-linux@vger.kernel.org>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <594546ee-275e-bce4-6578-4676009c2922@gmx.com>
Date: Fri, 16 Jun 2017 10:48:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


This seems unusual, two identical commits:

--- patch.1	2017-06-15 14:07:08.316861600 -0400
+++ patch.2	2017-06-15 14:07:25.964305209 -0400
@@ -1,4 +1,4 @@
-commit b1557fe98120132e6671924af4ed69f4e21d3de4
+commit 3a5ce6e7efe62e1f583c090f907bf8518ce2f4ba
 Author: Sami Kerola <kerolasa@iki.fi>
 Date:   Tue May 16 09:18:24 2017 +0100
 
@@ -35,7 +35,7 @@
  	FILE *stream = status ? stderr : stdout;
  
 diff --git a/login-utils/last.c b/login-utils/last.c
-index c90b574..50451b2 100644
+index f93ec7f..d230deb 100644
 --- a/login-utils/last.c
 +++ b/login-utils/last.c
 @@ -830,7 +830,7 @@ static void process_wtmp_file(const struct last_control *ctl,
@@ -142,7 +142,7 @@
  			/* Other errors */
  			if (filename)
 diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
-index cfb6bcd..55f54f5 100644
+index 6031460..c76f25d 100644
 --- a/sys-utils/hwclock.c
 +++ b/sys-utils/hwclock.c
 @@ -1209,7 +1209,8 @@ static void out_version(void)

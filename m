Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f179.google.com ([209.85.212.179]:63479 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbaBPXyp (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Feb 2014 18:54:45 -0500
Received: by mail-wi0-f179.google.com with SMTP id hn9so1871442wib.12
        for <util-linux@vger.kernel.org>; Sun, 16 Feb 2014 15:54:44 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 5/9] tests: align last.1 with recent phantom detection
Date: Sun, 16 Feb 2014 23:54:18 +0000
Message-Id: <1392594862-15807-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1392594862-15807-1-git-send-email-kerolasa@iki.fi>
References: <1392594862-15807-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

None existing account is not still-logged-in but gone mysteriously,
assuming wtmp logout markup is missing.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/last/last | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/expected/last/last b/tests/expected/last/last
index 2ff5cc1..dfb140b 100644
--- a/tests/expected/last/last
+++ b/tests/expected/last/last
@@ -1,6 +1,6 @@
 ~~~ basic output ~~~
 rick     long         never-gonna-logo Thu Jan  1 00:00 - 03:14 (24855+03:14)
-torvalds linux        hobby            Mon Aug 26 00:57   still logged in
+torvalds linux        hobby            Mon Aug 26 00:57    gone - no logout
 reboot   system boot  system-name      Wed Aug 28 18:00   still running
 reboot   system boot  system-name      Wed Aug 28 16:00 - 17:00  (01:00)
 IPv4     root         dns-server       Wed Aug 28 13:00 - 14:00  (01:00)
@@ -17,7 +17,7 @@ accounti foo          nine             Wed Aug 28 03:00 - 04:00  (01:00)
 wtmp begins Wed Aug 28 03:00:00 2013
 ~~~ include system ~~~
 rick     long         never-gonna-logo Thu Jan  1 00:00 - 03:14 (24855+03:14)
-torvalds linux        hobby            Mon Aug 26 00:57   still logged in
+torvalds linux        hobby            Mon Aug 26 00:57    gone - no logout
 reboot   system boot  system-name      Wed Aug 28 18:00   still running
 shutdown system down  system-name      Wed Aug 28 17:00 - 18:00  (01:00)
 reboot   system boot  system-name      Wed Aug 28 16:00 - 17:00  (01:00)
@@ -47,16 +47,16 @@ IPv4     root         Wed Aug 28 13:00 - 14:00  (01:00)     a.root-servers.net
 
 wtmp begins Wed Aug 28 03:00:00 2013
 ~~~ show ip ~~~
-torvalds linux        128.214.205.14   Mon Aug 26 00:57   still logged in
+torvalds linux        128.214.205.14   Mon Aug 26 00:57    gone - no logout
 
 wtmp begins Wed Aug 28 03:00:00 2013
 ~~~ no host ~~~
-torvalds linux        Mon Aug 26 00:57   still logged in
+torvalds linux        Mon Aug 26 00:57    gone - no logout
 
 wtmp begins Wed Aug 28 03:00:00 2013
 ~~~ full times ~~~
 rick     long         never-gonna-logo Thu Jan  1 00:00:00 1970 - Tue Jan 19 03:14:07 2038 (24855+03:14)
-torvalds linux        hobby            Mon Aug 26 00:57:08 1991   still logged in
+torvalds linux        hobby            Mon Aug 26 00:57:08 1991   gone - no logout
 reboot   system boot  system-name      Wed Aug 28 18:00:00 2013   still running
 reboot   system boot  system-name      Wed Aug 28 16:00:00 2013 - Wed Aug 28 17:00:00 2013  (01:00)
 IPv4     root         dns-server       Wed Aug 28 13:00:00 2013 - Wed Aug 28 14:00:00 2013  (01:00)
@@ -73,7 +73,7 @@ accounti foo          nine             Wed Aug 28 03:00:00 2013 - Wed Aug 28 04:
 wtmp begins Wed Aug 28 03:00:00 2013
 ~~~ no time ~~~
 rick     long         never-gonna-logo   (24855+03:14)
-torvalds linux        hobby              logged in
+torvalds linux        hobby              - no logout
 reboot   system boot  system-name        running
 reboot   system boot  system-name         (01:00)
 IPv4     root         dns-server          (01:00)
@@ -90,7 +90,7 @@ accounti foo          nine                (01:00)
 wtmp begins Wed Aug 28 03:00:00 2013
 ~~~ iso-8601 time ~~~
 rick     long         never-gonna-logout 1970-01-01T00:00:00+0000 - 2038-01-19T03:14:07+0000 (24855+03:14)
-torvalds linux        hobby            1991-08-26T00:57:08+0000   still logged in
+torvalds linux        hobby            1991-08-26T00:57:08+0000   gone - no logout
 reboot   system boot  system-name      2013-08-28T18:00:00+0000   still running
 reboot   system boot  system-name      2013-08-28T16:00:00+0000 - 2013-08-28T17:00:00+0000  (01:00)
 IPv4     root         dns-server       2013-08-28T13:00:00+0000 - 2013-08-28T14:00:00+0000  (01:00)
@@ -115,7 +115,7 @@ accounti foo          nine             Wed Aug 28 03:00 - 04:00  (01:00)
 wtmp begins Wed Aug 28 03:00:00 2013
 ~~~ present ~~~
 rick     long         never-gonna-logo Thu Jan  1 00:00 - 03:14 (24855+03:14)
-torvalds linux        hobby            Mon Aug 26 00:57   still logged in
+torvalds linux        hobby            Mon Aug 26 00:57    gone - no logout
 runlevel foo          one              Wed Aug 28 11:00 - 12:00  (01:00)
 
 wtmp begins Wed Aug 28 03:00:00 2013
-- 
1.9.0


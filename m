Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:44645 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbaBHQoD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 8 Feb 2014 11:44:03 -0500
From: Phillip Susi <psusi@ubuntu.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] Remove obsolete and confusing statement from mount.8
Date: Sat,  8 Feb 2014 11:44:02 -0500
Message-Id: <1391877842-11247-1-git-send-email-psusi@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The wording was confusing and suidperl has gone the way
of the dodo, and really didn't need mentionting in mount.8.

Signed-off-by: Phillip Susi <psusi@ubuntu.com>
---
 sys-utils/mount.8 | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index fd68f18..5ac5ea5 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -1078,8 +1078,7 @@ effect.
 .TP
 .B nosuid
 Do not allow set-user-identifier or set-group-identifier bits to take
-effect. (This seems safe, but is in fact rather unsafe if you have
-suidperl(1) installed.)
+effect.
 .TP
 .B silent
 Turn on the silent flag.
-- 
1.8.3.2


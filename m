Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:48317 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751319Ab3EDEt3 (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Sat, 4 May 2013 00:49:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id BED4B33DB6E
	for <util-linux-ng@vger.kernel.org>; Sat,  4 May 2013 04:49:28 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux-ng@vger.kernel.org
Subject: [PATCH] docs: note ddate removal
Date: Sat,  4 May 2013 00:49:34 -0400
Message-Id: <1367642974-2425-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 Documentation/releases/v2.23-ReleaseNotes | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/releases/v2.23-ReleaseNotes b/Documentation/releases/v2.23-ReleaseNotes
index 1da0007..7e9ed88 100644
--- a/Documentation/releases/v2.23-ReleaseNotes
+++ b/Documentation/releases/v2.23-ReleaseNotes
@@ -10,6 +10,9 @@ version.
 
 The command chkdupexe has been REMOVED from util-linux.
 
+The command ddate has been REMOVED from util-linux.  You can find it here:
+https://github.com/bo0ts/ddate
+
 The library libblkid supports LIBBLKID_DEBUG=<mask> environment variable to
 print debug messages on stderr. The old BLKID_DEBUG= is no more supported.
 
-- 
1.8.2.1


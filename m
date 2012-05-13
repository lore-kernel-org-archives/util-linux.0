Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50968 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752721Ab2EML5w (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 13 May 2012 07:57:52 -0400
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Cc: "James R. Van Zandt\"" <jrv@debian.org>
Subject: [PATCH] rev.1: mention tac(1) in 'SEE ALSO' section
Date: Sun, 13 May 2012 13:57:46 +0200
Message-Id: <1336910266-13854-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Cc: James R. Van Zandt" <jrv@debian.org>
From: James R. Van Zandt" <jrv@debian.org>
Addresses: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=568709

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 text-utils/rev.1 |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/text-utils/rev.1 b/text-utils/rev.1
index 5917747..b9b5f48 100644
--- a/text-utils/rev.1
+++ b/text-utils/rev.1
@@ -56,3 +56,5 @@ The rev command is part of the util-linux package and is available from
 .UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
 Linux Kernel Archive
 .UE .
+.SH SEE ALSO
+.BR tac (1)
-- 
1.7.7


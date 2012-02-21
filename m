Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:44990 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851Ab2BUPVW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 21 Feb 2012 10:21:22 -0500
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id A61288FA97
	for <util-linux@vger.kernel.org>; Tue, 21 Feb 2012 16:21:21 +0100 (CET)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] cytune.8: fix formatting
Date: Tue, 21 Feb 2012 16:21:21 +0100
Message-Id: <1329837681-16901-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

W: manual-page-warning /usr/share/man/man8/cytune.8.gz 178: warning:
macro `chars',' not defined (possibly missing space after `ch')

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 sys-utils/cytune.8 |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/cytune.8 b/sys-utils/cytune.8
index 1c4de3e..fd82391 100644
--- a/sys-utils/cytune.8
+++ b/sys-utils/cytune.8
@@ -174,8 +174,8 @@ seconds.
 .SH BUGS
 If you run two copies of
 .B cytune
-at the same time to report statistics about the same port, the 'ints',
-'chars', and 'max' value will be reset and not reported correctly.
+at the same time to report statistics about the same port, the 'ints', 'chars',
+and 'max' value will be reset and not reported correctly.
 .B cytune
 should prevent this, but does not.
 .\" .SH AUTHOR
-- 
1.7.7


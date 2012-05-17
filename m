Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:38544 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759523Ab2EQHlT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 17 May 2012 03:41:19 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id AC6ED8FA98
	for <util-linux@vger.kernel.org>; Thu, 17 May 2012 09:41:18 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 2/4] mkfs.cramfs: remove unused 'MIN' macro definition
Date: Thu, 17 May 2012 09:41:07 +0200
Message-Id: <1337240469-24539-2-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1337240469-24539-1-git-send-email-petr.uzel@suse.cz>
References: <1337240469-24539-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 disk-utils/mkfs.cramfs.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/disk-utils/mkfs.cramfs.c b/disk-utils/mkfs.cramfs.c
index 919f1ef..9e8f77f 100644
--- a/disk-utils/mkfs.cramfs.c
+++ b/disk-utils/mkfs.cramfs.c
@@ -80,10 +80,6 @@ static int warn_skip = 0;
 static int warn_size = 0;
 static int warn_uid = 0;
 
-#ifndef MIN
-# define MIN(_a,_b) ((_a) < (_b) ? (_a) : (_b))
-#endif
-
 /* entry.flags */
 #define CRAMFS_EFLAG_MD5	1
 #define CRAMFS_EFLAG_INVALID	2
-- 
1.7.7


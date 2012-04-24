Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:39126 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756001Ab2DXIVF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Apr 2012 04:21:05 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id DB88C8FFEB
	for <util-linux@vger.kernel.org>; Tue, 24 Apr 2012 10:21:04 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 9/9] findmnt: fix compiler warnings [-Wuninitialized]
Date: Tue, 24 Apr 2012 10:21:01 +0200
Message-Id: <1335255661-10611-9-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1335255661-10611-1-git-send-email-petr.uzel@suse.cz>
References: <1335255661-10611-1-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

findmnt.c:333:29: error: ‘vfs_attr’ may be used uninitialized in this function [-Werror=uninitialized]
findmnt.c:307:11: note: ‘vfs_attr’ was declared here

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 misc-utils/findmnt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index cf69c42..a709824 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -304,7 +304,7 @@ static const char *get_tag(struct libmnt_fs *fs, const char *tagname)
 static const char *get_vfs_attr(struct libmnt_fs *fs, int sizetype)
 {
 	struct statvfs buf;
-	uint64_t vfs_attr;
+	uint64_t vfs_attr = 0;
 	char *sizestr;
 
 	if (statvfs(mnt_fs_get_target(fs), &buf) != 0)
-- 
1.7.7


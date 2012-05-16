Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:44075 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965868Ab2EPIii (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 May 2012 04:38:38 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id BE22791EDB
	for <util-linux@vger.kernel.org>; Wed, 16 May 2012 10:38:37 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 1/2] blkid: use symbolic exit code
Date: Wed, 16 May 2012 10:38:31 +0200
Message-Id: <1337157512-31920-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 misc-utils/blkid.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 8007840..4f7050f 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -720,7 +720,7 @@ int main(int argc, char **argv)
 
 			while (blkid_superblocks_get_name(idx++, &name, NULL) == 0)
 				printf("%s\n", name);
-			exit(0);
+			exit(EXIT_SUCCESS);
 		}
 		case 'o':
 			if (!strcmp(optarg, "value"))
-- 
1.7.7


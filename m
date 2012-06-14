Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:40929 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756038Ab2FNONO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Jun 2012 10:13:14 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 0F46193182
	for <util-linux@vger.kernel.org>; Thu, 14 Jun 2012 16:13:13 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 1/3] libmount: plug a memory leak in exec_helper()
Date: Thu, 14 Jun 2012 16:13:01 +0200
Message-Id: <1339683183-21804-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

valgrind --leak-check=full ./sys-utils/mount -t cifs //127.0.0.1/users /mnt/smb -o user=root,password=linux
....
==21359== 28 bytes in 1 blocks are definitely lost in loss record 1 of 1
==21359==    at 0x4C298B2: realloc (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
==21359==    by 0x415780: __mnt_optstr_append_option (optstr.c:188)
==21359==    by 0x415CB5: mnt_optstr_set_option (optstr.c:387)
==21359==    by 0x40D778: do_mount (context_mount.c:192)
==21359==    by 0x40E6A9: mnt_context_do_mount (context_mount.c:685)
==21359==    by 0x40EB7B: mnt_context_mount (context_mount.c:786)
==21359==    by 0x4058B0: main (mount.c:918)

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 libmount/src/context_mount.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
index 69b5bfc..e00fbe9 100644
--- a/libmount/src/context_mount.c
+++ b/libmount/src/context_mount.c
@@ -458,6 +458,7 @@ static int exec_helper(struct libmnt_context *cxt)
 		break;
 	}
 
+	free(o);
 	return rc;
 }
 
-- 
1.7.7


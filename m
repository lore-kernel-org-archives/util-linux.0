Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:40930 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756038Ab2FNONP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Jun 2012 10:13:15 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id C818493182
	for <util-linux@vger.kernel.org>; Thu, 14 Jun 2012 16:13:14 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 2/3] libmount: fix read before allocated buffer
Date: Thu, 14 Jun 2012 16:13:02 +0200
Message-Id: <1339683183-21804-2-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1339683183-21804-1-git-send-email-petr.uzel@suse.cz>
References: <1339683183-21804-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

valgrind --leak-check=full ./sys-utils/mount -t cifs //127.0.0.1/users /mnt/smb -o user=root,password=linux
....
==21359== Invalid read of size 1
==21359==    at 0x415AC6: mnt_optstr_remove_option_at (optstr.c:310)
==21359==    by 0x416358: mnt_optstr_apply_flags (optstr.c:716)
==21359==    by 0x40DFBF: mnt_context_prepare_mount (context_mount.c:86)
==21359==    by 0x40EB5A: mnt_context_mount (context_mount.c:782)
==21359==    by 0x4058B0: main (mount.c:918)
==21359==  Address 0x51cd5bf is 1 bytes before a block of size 10 alloc'd
==21359==    at 0x4C297CD: malloc (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
==21359==    by 0x4C29957: realloc (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
==21359==    by 0x415780: __mnt_optstr_append_option (optstr.c:188)
==21359==    by 0x412822: mnt_fs_append_options (fs.c:764)
==21359==    by 0x409288: mnt_context_append_options (context.c:733)
==21359==    by 0x4053F0: main (mount.c:776)

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 libmount/src/optstr.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/libmount/src/optstr.c b/libmount/src/optstr.c
index c8beada..2c9dd5e 100644
--- a/libmount/src/optstr.c
+++ b/libmount/src/optstr.c
@@ -307,7 +307,7 @@ int mnt_optstr_remove_option_at(char **optstr, char *begin, char *end)
 	sz = strlen(end);
 
 	memmove(begin, end, sz + 1);
-	if (!*begin && *(begin - 1) == ',')
+	if (!*begin && (begin > *optstr) && *(begin - 1) == ',')
 		*(begin - 1) = '\0';
 
 	return 0;
-- 
1.7.7


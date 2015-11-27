Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:46683 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753894AbbK0RPn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 27 Nov 2015 12:15:43 -0500
Subject: [PATCH] fix mount -a on btrfs bind mount
To: util-linux <util-linux@vger.kernel.org>
References: <56573D53.1020406@suse.cz>
Cc: David Sterba <dsterba@suse.cz>, =?UTF-8?Q?S=c3=b8ren_Holm?= <sgh@sgh.dk>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56588FBD.9000502@suse.cz>
Date: Fri, 27 Nov 2015 18:15:41 +0100
MIME-Version: 1.0
In-Reply-To: <56573D53.1020406@suse.cz>
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Do not prepend src_root to root for bind mounts on btrfs.

root has to be literally the same as src_root, which is already the path
prefixed by /{subvolume}. Otherwise it will not match in
mnt_fs_streq_target(fs, xtgt) inside mnt_table_is_fs_mounted() and
repeated "mount -a" will mount it again and again.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 libmount/src/tab.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/libmount/src/tab.c b/libmount/src/tab.c
index 0df8d49..eeb9c57 100644
--- a/libmount/src/tab.c
+++ b/libmount/src/tab.c
@@ -1247,12 +1247,9 @@ struct libmnt_fs *mnt_table_get_fs_root(struct libmnt_table *tb,
 		 */
 		src_root = mnt_fs_get_root(src_fs);
 		if (src_root && !startswith(root, src_root)) {
-			size_t sz = strlen(root) + strlen(src_root) + 1;
-			char *tmp = malloc(sz);
-
+			char *tmp = strdup (src_root);
 			if (!tmp)
 				goto err;
-			snprintf(tmp, sz, "%s%s", src_root, root);
 			free(root);
 			root = tmp;
 		}
-- 
2.6.3

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

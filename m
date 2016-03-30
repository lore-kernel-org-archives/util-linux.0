Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:41556 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778AbcC3Utq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 30 Mar 2016 16:49:46 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id CCA56AD22
	for <util-linux@vger.kernel.org>; Wed, 30 Mar 2016 20:49:43 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] Fix possible NULL dereference in get_btrfs_fs_root()
Message-ID: <56FC3BE7.7040001@suse.cz>
Date: Wed, 30 Mar 2016 22:49:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Be on safe side and always initialize mountinfo in set_fs_root().

I got a crash report in get_btrfs_fs_root() caused by tb being zero while
referring tb->cache in

target = mnt_resolve_target(mnt_fs_get_target(fs), tb->cache);

Triggered by command:

mount -t btrfs -o user /dev/sdh1 /media/sdh1

However I was not able to reproduce the crash, the reason was apparent.

NULL tb was passed to mnt_table_get_fs_root() from set_fs_root().

set_fs_root() got it as upd->mountinfo being NULL from utab_new_entry(). That
got it from mnt_update_set_fs(), that from mnt_context_prepare_update() (where
it is cxt->update->mountinfo).

At least the constructor mnt_new_update() can create context with cxt->update
being not NULL and cxt->update->mountinfo being NULL.

It is also possible to pass to mnt_context_prepare_update() with cxt->update not
being NULL but cxt->update->mountinfo being NULL created by mnt_new_context(),
e. g. from mnt_context_mount().

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 libmount/src/tab_update.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/libmount/src/tab_update.c b/libmount/src/tab_update.c
index 40adba9..9e775df 100644
--- a/libmount/src/tab_update.c
+++ b/libmount/src/tab_update.c
@@ -366,9 +366,10 @@ static int set_fs_root(struct libmnt_update *upd, struct libmnt_fs *fs,
 	assert(upd->fs);
 	assert(fs);
 
+	if (!upd->mountinfo)
+		upd->mountinfo = mnt_new_table_from_file(_PATH_PROC_MOUNTINFO);
+
 	if (mountflags & MS_BIND) {
-		if (!upd->mountinfo)
-			upd->mountinfo = mnt_new_table_from_file(_PATH_PROC_MOUNTINFO);
 
 		src = mnt_fs_get_srcpath(fs);
 		if (src) {
-- 
2.7.3

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

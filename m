Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:40027 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933551AbcCITws (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Mar 2016 14:52:48 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 58F65AD30
	for <util-linux@vger.kernel.org>; Wed,  9 Mar 2016 19:52:46 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] libmount: Typo fix
Message-ID: <56E07F0E.8090901@suse.cz>
Date: Wed, 9 Mar 2016 20:52:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

---
 libmount/src/tab.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libmount/src/tab.c b/libmount/src/tab.c
index 102ed25..0570044 100644
--- a/libmount/src/tab.c
+++ b/libmount/src/tab.c
@@ -1247,7 +1247,7 @@ static int get_btrfs_fs_root(struct libmnt_table *tb, struct libmnt_fs *fs, char
 		if (!target)
 			goto err;
 
-		DBG(BTRFS, ul_debug(" tring target=%s subvolid=%s", target, subvolidstr));
+		DBG(BTRFS, ul_debug(" trying target=%s subvolid=%s", target, subvolidstr));
 		f = mnt_table_find_target_with_option(tb, target,
 					"subvolid", subvolidstr,
 					MNT_ITER_BACKWARD);
@@ -1292,7 +1292,7 @@ static int get_btrfs_fs_root(struct libmnt_table *tb, struct libmnt_fs *fs, char
 		snprintf(default_id_str, sizeof(default_id_str), "%llu",
 				(unsigned long long int) default_id);
 
-		DBG(BTRFS, ul_debug(" tring target=%s default subvolid=%s",
+		DBG(BTRFS, ul_debug(" trying target=%s default subvolid=%s",
 					target, default_id_str));
 
 		f = mnt_table_find_target_with_option(tb, target,
-- 
2.7.2

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

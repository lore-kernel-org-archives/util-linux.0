Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:48703 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753837AbcHAQpV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 1 Aug 2016 12:45:21 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 9EC19ABBB
	for <util-linux@vger.kernel.org>; Mon,  1 Aug 2016 16:25:01 +0000 (UTC)
To: util-linux <util-linux@vger.kernel.org>
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] libmount: Skip root comparison for cifs in
 mnt_table_is_fs_mounted()
Message-ID: <91d465d3-4f5b-6270-a6c5-38bd94695731@suse.cz>
Date: Mon, 1 Aug 2016 18:25:01 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In mountinfo of cifs filesystem, root is filled with a relative path to the root
of the exported volume. There is no reasonable way to compare it without making
a network look-up.

This causes false negative result in some cases.

Skipping root comparison in mnt_table_is_fs_mounted() makes things better,
however it still does not cover all possible setups.

How to reproduce:
1) Create and export a cifs volume (with guest allowed).
2) Make a subdirectory in this volume.
3) Mount this subdirectory using fstab:
   //server/volume/subdir /mnt cifs guest 0 0
4) Call mount -a twice.
   Depending on a system running, you either get:
     mount error(16): Device or resource busy
     Refer to the mount.cifs(8) manual page (e.g. man mount.cifs)
   or you get a volume mounted twice.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 libmount/src/tab.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/libmount/src/tab.c b/libmount/src/tab.c
index 155c65e..aa9185a 100644
--- a/libmount/src/tab.c
+++ b/libmount/src/tab.c
@@ -1562,7 +1562,10 @@ int mnt_table_is_fs_mounted(struct libmnt_table *tb, struct libmnt_fs *fstab_fs)
 #endif
 		}
 
-		if (root) {
+		/* For cifs, root contains a relative path to the exported volume,
+		 * i. e. something we cannot compare.
+		 */
+		if (root && strcmp(mnt_fs_get_fstype(fs), "cifs")) {
 			const char *r = mnt_fs_get_root(fs);
 			if (!r || strcmp(r, root) != 0)
 				continue;
-- 
2.9.2

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

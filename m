Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:33185 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751955AbdAYRa2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 25 Jan 2017 12:30:28 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B3E40AB5D
        for <util-linux@vger.kernel.org>; Wed, 25 Jan 2017 17:30:26 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 1/1] fstrim: de-duplicate btrfs sub-volumes
Message-ID: <37b25dd8-c5fa-cb30-09c4-7e817660725c@suse.cz>
Date: Wed, 25 Jan 2017 18:30:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

There was a comparison of roots in uniq_fs_source_cmp(). As we care only on
device names, comparing roots makes only a little sense, and it breaks on btrfs.
As a result, FITRIM ioctl() is called for each subvolume. But by design, only
one TRIM is needed for the whole btrfs volume.

Remove it to be able to de-duplicate btrfs subvolumes.

Fixes opensuse #1020077.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 sys-utils/fstrim.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/sys-utils/fstrim.c b/sys-utils/fstrim.c
index e92a822f0..f252edba0 100644
--- a/sys-utils/fstrim.c
+++ b/sys-utils/fstrim.c
@@ -158,23 +158,11 @@ static int uniq_fs_source_cmp(
 		struct libmnt_fs *a,
 		struct libmnt_fs *b)
 {
-	int eq;
-
 	if (mnt_fs_is_pseudofs(a) || mnt_fs_is_netfs(a) ||
 	    mnt_fs_is_pseudofs(b) || mnt_fs_is_netfs(b))
 		return 1;
 
-	eq = mnt_fs_streq_srcpath(a, mnt_fs_get_srcpath(b));
-	if (eq) {
-		const char *aroot = mnt_fs_get_root(a),
-			   *broot = mnt_fs_get_root(b);
-		if (!aroot || !broot)
-			eq = 0;
-		else if (strcmp(aroot, broot) != 0)
-			eq = 0;
-	}
-
-	return !eq;
+	return !mnt_fs_streq_srcpath(a, mnt_fs_get_srcpath(b));
 }
 
 /*
-- 
2.11.0

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

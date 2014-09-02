Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:49144 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754581AbaIBTJk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Sep 2014 15:09:40 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 079D1AAF1
	for <util-linux@vger.kernel.org>; Tue,  2 Sep 2014 19:09:39 +0000 (UTC)
Message-ID: <1409684978.14709.15.camel@oct.suse.cz>
Subject: umount of unreachable NFS without -f [maybe PATCH]
From: Stanislav Brabec <sbrabec@suse.cz>
To: util-linux@vger.kernel.org
Date: Tue, 02 Sep 2014 21:09:38 +0200
Content-Type: text/plain; charset="ISO-8859-2"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I just analyzed causes of hang while calling umount without -f on an
unreachable NFS.

The first hang happens on in lookup_umount_fs():

stat(tgt, &st) == 0 && S_ISDIR(st.st_mode)

I don't exactly know, what its removal causes, but I tried it.

I entered into next hang in mnt_resolve_path() inside has_utab_entry().
We cannot prevent this hang in all cases, but preventing it in a
standard situation is pretty straightforward: Try to match provided
target name before trying to canonicalize.

Now my umount without -f works well at least in the case, when the mount
point is recorded in the utab.

If it is not recorded in utab, it still hangs later in
lookup_umount_fs() on:

if (statfs(tgt, &vfs) == 0)

Well, we can prevent even this hang, but it would be at cost of parsing
mtab. I read your git comments and I see, that the whole purpose of the
code is preventing of parsing of the generated mtab/mountinfo.

Would be parsing of fstab a safe way without paying this cost?

Here is my patch, which prevented at least part of these hangs. What do
you think about it?

Index: util-linux-2.25/libmount/src/context_umount.c
===================================================================
--- util-linux-2.25.orig/libmount/src/context_umount.c
+++ util-linux-2.25/libmount/src/context_umount.c
@@ -216,6 +255,14 @@ static int has_utab_entry(struct libmnt_
 
 	/* paths in utab are canonicalized */
 	cache = mnt_context_get_cache(cxt);
+
+	/* first search for target as it is - mnt_resolve_path() can fail on unreachable NFS */
+	mnt_reset_iter(&itr, MNT_ITER_BACKWARD);
+
+	while (mnt_table_next_fs(cxt->utab, &itr, &fs) == 0) {
+		if (mnt_fs_streq_target(fs, target))
+			return 1;
+	}
 	cn = mnt_resolve_path(target, cache);
 	mnt_reset_iter(&itr, MNT_ITER_BACKWARD);
 
@@ -232,7 +279,6 @@ static int has_utab_entry(struct libmnt_
 static int lookup_umount_fs(struct libmnt_context *cxt)
 {
 	const char *tgt;
-	struct stat st;
 	struct libmnt_fs *fs = NULL;
 	int rc = 0;
 
@@ -262,7 +308,6 @@ static int lookup_umount_fs(struct libmn
 	    && !mnt_context_mtab_writable(cxt)
 	    && !mnt_context_is_force(cxt)
 	    && !mnt_context_is_lazy(cxt)
-	    && stat(tgt, &st) == 0 && S_ISDIR(st.st_mode)
 	    && !has_utab_entry(cxt, tgt)) {
 
 		const char *type = mnt_fs_get_fstype(cxt->fs);


-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76


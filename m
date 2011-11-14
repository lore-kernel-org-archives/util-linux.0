Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40187 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750836Ab1KNNrz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Nov 2011 08:47:55 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pAEDltkY004752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Mon, 14 Nov 2011 08:47:55 -0500
Received: from localhost (beach.nrt.redhat.com [10.64.200.71])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id pAEDlror026385
	for <util-linux@vger.kernel.org>; Mon, 14 Nov 2011 08:47:54 -0500
Date: Mon, 14 Nov 2011 22:47:53 +0900 (JST)
Message-Id: <20111114.224753.785892012923334635.yamato@redhat.com>
To: util-linux@vger.kernel.org
Subject: [patch] Enable fstab.d in mount -a
From: Masatake YAMATO <yamato@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This patch makes mount command read fstab.d/*.fstab if the command
is built with --enable-libmount-mount.  

Signed-off-by: Masatake YAMATO <yamato@redhat.com>

diff --git a/mount/fstab.c b/mount/fstab.c
index a1bae90..3621d3a 100644
--- a/mount/fstab.c
+++ b/mount/fstab.c
@@ -153,20 +153,23 @@ read_mntentchn(mntFILE *mfp, const char *fnam, struct mntentchn *mc0) {
 
 #define USE_UNSTABLE_LIBMOUNT_API
 #include <libmount.h>			/* libmount */
-
-static void read_mounttable()
+static void read_tab_common(struct mntentchn *mc0,
+			    int    *got_p,
+			    int (* reader)(struct libmnt_table *tb, 
+					   const char *filename),
+	                    const char *name_in_errmsg)
 {
-	struct mntentchn *mc0 = &mounttable, *mc = mc0;
+  	struct mntentchn *mc = mc0;
 	struct libmnt_table *tb = mnt_new_table();
 	struct libmnt_iter *itr = mnt_new_iter(MNT_ITER_FORWARD);
 	struct libmnt_fs *fs;
 
-	got_mtab = 1;
+	*got_p = 1;
 	mc->nxt = mc->prev = NULL;
 
 	if (!tb || !itr)
 		goto err;
-	if (mnt_table_parse_mtab(tb, NULL))
+	if (reader(tb, NULL))
 		goto err;
 
 	while(mnt_table_next_fs(tb, itr, &fs) == 0) {
@@ -187,12 +190,28 @@ static void read_mounttable()
 	mc0->prev = mc;
 	return;
 err:
-	error(_("warning: failed to read mtab"));
+	error(_("warning: failed to %s"),
+		name_in_errmsg);
 	mnt_free_table(tb);
 	mnt_free_iter(itr);
 	mc->nxt = mc->prev = NULL;
 }
 
+static void read_mounttable()
+{
+	read_tab_common(&mounttable,
+			&got_mtab,
+			mnt_table_parse_mtab,
+			"mtab");
+}
+
+static void read_fstab() 
+{
+	read_tab_common(&fstab,
+			&got_fstab,
+			mnt_table_parse_fstab,
+			"fstab/fstab.d");
+}
 #else /* !HAVE_LIBMOUNT_MOUNT */
 
 /*
@@ -226,7 +245,6 @@ read_mounttable() {
 	}
 	read_mntentchn(mfp, fnam, mc);
 }
-#endif /* HAVE_LIBMOUNT_MOUNT */
 
 static void
 read_fstab() {
@@ -247,6 +265,7 @@ read_fstab() {
 	}
 	read_mntentchn(mfp, fnam, mc);
 }
+#endif /* HAVE_LIBMOUNT_MOUNT */
 
 
 /* Given the name NAME, try to find it in mtab.  */

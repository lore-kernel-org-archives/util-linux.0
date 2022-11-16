Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B69C43217
	for <util-linux@archiver.kernel.org>; Wed, 16 Nov 2022 02:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiKPCAy (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 15 Nov 2022 21:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiKPCAw (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 15 Nov 2022 21:00:52 -0500
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [121.200.0.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB97D2A72B
        for <util-linux@vger.kernel.org>; Tue, 15 Nov 2022 18:00:48 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 6850610030D
        for <util-linux@vger.kernel.org>; Wed, 16 Nov 2022 13:00:46 +1100 (AEDT)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 611ebdQkY6Dm for <util-linux@vger.kernel.org>;
        Wed, 16 Nov 2022 13:00:46 +1100 (AEDT)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 5D23E1003C0; Wed, 16 Nov 2022 13:00:46 +1100 (AEDT)
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id E185A100266;
        Wed, 16 Nov 2022 13:00:45 +1100 (AEDT)
Subject: [PATCH 1/2] libmount: use autofs mount hint to ignore autofs mount
 entries
From:   Ian Kent <raven@themaw.net>
To:     util-linux <util-linux@vger.kernel.org>
Cc:     Karel Zak <kzak@redhat.com>, John Westerdale <jwesterd@redhat.com>,
        fhirtz@redhat.com
Date:   Wed, 16 Nov 2022 10:00:45 +0800
Message-ID: <166856404555.472741.8761384857533986022.stgit@donald.themaw.net>
In-Reply-To: <166856374641.472741.1779154765995171105.stgit@donald.themaw.net>
References: <166856374641.472741.1779154765995171105.stgit@donald.themaw.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Historically autofs mounts were not included in mount table listings.
This is the case in other SysV autofs implementations and was also
the case with Linux autofs.

But now that /etc/mtab is a symlink to the proc filesystem mount
table the autofs mount entries appear in the mount table on Linux.

Prior to the symlinking of /etc/mtab mount table it was sufficient
to call mount(2) and simply not update /etc/mtab to exclude autofs
mounts from mount listings.

Also, with this symlinking of /etc/mtab we have seen a shift in usage
toward using the proc mount tables directly.

But the autofs mount entries need to be retained when coming from the
proc file system for applications that need them (such as systemd) so
filtering out these entries within the kernel itself can't be done,
it needs be done in user space.

There are three reasons to omit the autofs mount entries.

One is that certain types of auto-mounts have an autofs mount for every
entry in their autofs mount map (autofs direct mounts) and these maps
can be quite large. This leads to mount table listings containing a lot
of unnecessary entries.

Also, this difference in behaviour between autofs implementations can
cause problems for applications that need to use the mount table and
expect autofs entries aren't present.

Lastly, there's very little that user space can do with autofs mount
entries since this must be left to the autofs mount owner, typically
the automount daemon. And it can also lead to attempts to access
automount managed paths resulting in mounts being triggered when they
aren't needed or mounts staying mounted for much longer thay they
need to be.

So the Linux autofs file system has been modified to accept a pseudo
mount option of "ignore" (as is used in other OS implementations) so
that user space utilities can use this as a hint to skip these autofs
entries on reading the mount table.

The Linux autofs automount daemon used getmntent(3) itself and has been
modified to use the proc file system directly so that it isn't affected
by the presence of the "ignore" mount option.

The use of the "ignore" mount option is opt-in by autofs users and a
configuration option has been added which defaults to not use the option
so if there are applications that need these entries, other than autofs
itself, they can be retained. Also, since this filtering is based on an
added mount option earlier versions of Linux autofs and other autofs file
system users will not use the option and so won't be affected by the change.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 libmount/src/context.c     |   19 +++++++++++++++++++
 libmount/src/libmount.h.in |    2 ++
 libmount/src/libmount.sym  |    3 +++
 libmount/src/mountP.h      |    7 ++++++-
 libmount/src/tab_parse.c   |   33 +++++++++++++++++++++++++++++++++
 5 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/libmount/src/context.c b/libmount/src/context.c
index d325ce430..3c9448d91 100644
--- a/libmount/src/context.c
+++ b/libmount/src/context.c
@@ -171,6 +171,7 @@ int mnt_reset_context(struct libmnt_context *cxt)
 	cxt->mountdata = NULL;
 	cxt->subdir = NULL;
 	cxt->flags = MNT_FL_DEFAULT;
+	cxt->ignore_autofs = 0;
 
 	/* free additional mounts list */
 	while (!list_empty(&cxt->addmounts)) {
@@ -311,6 +312,8 @@ struct libmnt_context *mnt_copy_context(struct libmnt_context *o)
 	n->table_fltrcb = o->table_fltrcb;
 	n->table_fltrcb_data = o->table_fltrcb_data;
 
+	n->ignore_autofs = o->ignore_autofs;
+
 	return n;
 failed:
 	mnt_free_context(n);
@@ -1299,6 +1302,9 @@ int mnt_context_get_mountinfo(struct libmnt_context *cxt, struct libmnt_table **
 			goto end;
 		}
 
+		if (cxt->ignore_autofs)
+			mnt_table_enable_ignore_autofs(cxt->mountinfo);
+
 		if (cxt->table_errcb)
 			mnt_table_set_parser_errcb(cxt->mountinfo, cxt->table_errcb);
 		if (cxt->table_fltrcb)
@@ -2778,6 +2784,19 @@ int mnt_context_strerror(struct libmnt_context *cxt __attribute__((__unused__)),
 	return 0;
 }
 
+/**
+ * mnt_context_enable_ignore_autofs:
+ * @cxt: context
+ *
+ * Set to ignore all autofs mount table entries when reading
+ * the mount table.
+ */
+int mnt_context_enable_ignore_autofs(struct libmnt_context *cxt)
+{
+	if (!cxt)
+		return -EINVAL;
+	cxt->ignore_autofs = 1;
+}
 
 int mnt_context_get_generic_excode(int rc, char *buf, size_t bufsz, const char *fmt, ...)
 {
diff --git a/libmount/src/libmount.h.in b/libmount/src/libmount.h.in
index 2fb641d03..1a7b6ba3e 100644
--- a/libmount/src/libmount.h.in
+++ b/libmount/src/libmount.h.in
@@ -863,6 +863,8 @@ extern int mnt_context_strerror(struct libmnt_context *cxt, char *buf,
 				size_t bufsiz)
 				__ul_attribute__((deprecated));
 
+extern int mnt_context_enable_ignore_autofs(struct libmnt_context *cxt);
+
 extern int mnt_context_get_excode(struct libmnt_context *cxt,
                         int rc, char *buf, size_t bufsz);
 
diff --git a/libmount/src/libmount.sym b/libmount/src/libmount.sym
index b99fc4cc2..7eb77c1bb 100644
--- a/libmount/src/libmount.sym
+++ b/libmount/src/libmount.sym
@@ -371,4 +371,7 @@ MOUNT_2_39 {
 	mnt_context_enable_onlyonce;
 	mnt_context_is_lazy;
 	mnt_context_get_mountinfo_userdata;
+	mnt_context_enable_ignore_autofs;
+	mnt_table_enable_ignore_autofs;
+	mnt_table_ignore_autofs;
 } MOUNT_2_38;
diff --git a/libmount/src/mountP.h b/libmount/src/mountP.h
index ffd9ba4fe..faf47fecb 100644
--- a/libmount/src/mountP.h
+++ b/libmount/src/mountP.h
@@ -148,6 +148,9 @@ extern int __mnt_table_is_fs_mounted(	struct libmnt_table *tb,
 					struct libmnt_fs *fstab_fs,
 					const char *tgt_prefix);
 
+extern int mnt_table_enable_ignore_autofs(struct libmnt_table *tb);
+extern int mnt_table_ignore_autofs(struct libmnt_table *tb);
+
 /*
  * Generic iterator
  */
@@ -251,6 +254,7 @@ struct libmnt_table {
 	int		(*fltrcb)(struct libmnt_fs *fs, void *data);
 	void		*fltrcb_data;
 
+	int		ignore_autofs;	/* ignore autofs mounts */
 
 	struct list_head	ents;	/* list of entries (libmnt_fs) */
 	void		*userdata;
@@ -357,7 +361,8 @@ struct libmnt_context
 	struct libmnt_ns	ns_tgt;		/* target namespace */
 	struct libmnt_ns	*ns_cur;	/* pointer to current namespace */
 
-	unsigned int	enabled_textdomain : 1;		/* bindtextdomain() called */
+	unsigned int	enabled_textdomain : 1;	/* bindtextdomain() called */
+	unsigned int 	ignore_autofs : 1;	/* ignore autofs mounts */
 };
 
 /* flags */
diff --git a/libmount/src/tab_parse.c b/libmount/src/tab_parse.c
index 75f8e406b..293f0a8ed 100644
--- a/libmount/src/tab_parse.c
+++ b/libmount/src/tab_parse.c
@@ -762,6 +762,14 @@ int mnt_table_parse_stream(struct libmnt_table *tb, FILE *f, const char *filenam
 		if (rc == 0 && tb->fltrcb && tb->fltrcb(fs, tb->fltrcb_data))
 			rc = 1;	/* filtered out by callback... */
 
+		if (mnt_table_ignore_autofs(tb)) {
+			const char *fstype = mnt_fs_get_fstype(fs);
+
+			if (fstype && strcmp(fstype, "autofs") == 0 &&
+			    mnt_fs_get_option(fs, "ignore", NULL, NULL) == 0)
+				rc = 1; /* Skip "ignore" autofs entry */
+		}
+
 		/* add to the table */
 		if (rc == 0) {
 			rc = mnt_table_add_fs(tb, fs);
@@ -1059,6 +1067,31 @@ int mnt_table_set_parser_fltrcb(struct libmnt_table *tb,
 	return 0;
 }
 
+/*
+ * mnt_table_enable_ignore_autofs:
+ * @tb: table
+ *
+ * Enable ignore autofs mount table entries on reading.
+ */
+int mnt_table_enable_ignore_autofs(struct libmnt_table *tb)
+{
+	if (!tb)
+		return -EINVAL;
+	tb->ignore_autofs = 1;
+	return 0;
+}
+
+/*
+ * mnt_table_ignore_autofs:
+ * @tb: table
+ *
+ * Return the the enabled status of ignore autofs mount table entries.
+ */
+int mnt_table_ignore_autofs(struct libmnt_table *tb)
+{
+	return tb ? tb->ignore_autofs : 0;
+}
+
 /**
  * mnt_table_parse_swaps:
  * @tb: table



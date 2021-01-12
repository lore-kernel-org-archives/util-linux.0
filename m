Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47376C433DB
	for <util-linux@archiver.kernel.org>; Tue, 12 Jan 2021 11:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E08B72310C
	for <util-linux@archiver.kernel.org>; Tue, 12 Jan 2021 11:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbhALLAZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 12 Jan 2021 06:00:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41747 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725922AbhALLAY (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 12 Jan 2021 06:00:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610449137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MGYyndyppUqeK/GrpP3C+6ucI0IKXmA7xNbcz7Xiv1s=;
        b=PStxK1WjUSb3voZWSZ8V/tSk7qRfQg/sZ5gYYf+falLCYcE0L1Z9+PHSb4LV4lULjCoHmf
        k/UPfylanzB1oPEJyIwsU91f2eiE45d/MaKrAdtEM3hYJiIuiJCPv9ot0t/IrPdLeblBCZ
        L9Niuq3aBebv92wON+6dicf0+SRNBaY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-MOxA9B1qOkO1LEsH5IJ9yA-1; Tue, 12 Jan 2021 05:58:55 -0500
X-MC-Unique: MOxA9B1qOkO1LEsH5IJ9yA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0851186E708
        for <util-linux@vger.kernel.org>; Tue, 12 Jan 2021 10:58:54 +0000 (UTC)
Received: from idlethread.redhat.com (unknown [10.33.36.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B4AE5D9CD
        for <util-linux@vger.kernel.org>; Tue, 12 Jan 2021 10:58:54 +0000 (UTC)
From:   Roberto Bergantinos Corpas <rbergant@redhat.com>
To:     util-linux@vger.kernel.org
Subject: [PATCH] findmnt: add option to list all fs-independent flags
Date:   Tue, 12 Jan 2021 11:58:53 +0100
Message-Id: <20210112105853.9387-1-rbergant@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

It might be useful for security auditing purposes list all possible
mount flags/options including default set which are normally not listed.

This patch adds "--vfs-all" option to list all fs-independent flags
on VFS-OPTIONS column, as well as libmount funcionality to accomplish
it.

i.e.:

$ findmnt -o VFS-OPTIONS
VFS-OPTIONS
rw,relatime
rw,nosuid,nodev,noexec,relatime
rw,nosuid,nodev,noexec,relatime
ro,nosuid,nodev,noexec
...

$ findmnt --vfs-all -o VFS-OPTIONS
VFS-OPTIONS
rw,exec,suid,dev,async,loud,nomand,atime,noiversion,diratime,relatime,nostrictatime,nolazytime,symfollow
rw,noexec,nosuid,nodev,async,loud,nomand,atime,noiversion,diratime,relatime,nostrictatime,nolazytime,symfollow
rw,noexec,nosuid,nodev,async,loud,nomand,atime,noiversion,diratime,relatime,nostrictatime,nolazytime,symfollow
ro,noexec,nosuid,nodev,async,loud,nomand,atime,noiversion,diratime,norelatime,nostrictatime,nolazytime,symfollow
...

Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
---
 libmount/docs/libmount-sections.txt |  1 +
 libmount/src/fs.c                   | 31 +++++++++++++++++++++++++++++
 libmount/src/libmount.h.in          |  1 +
 libmount/src/libmount.sym           |  1 +
 misc-utils/findmnt.8                |  5 +++++
 misc-utils/findmnt.c                | 12 +++++++++--
 misc-utils/findmnt.h                |  1 +
 7 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/libmount/docs/libmount-sections.txt b/libmount/docs/libmount-sections.txt
index da96b75b3..911dc0a0f 100644
--- a/libmount/docs/libmount-sections.txt
+++ b/libmount/docs/libmount-sections.txt
@@ -245,6 +245,7 @@ mnt_fs_get_usedsize
 mnt_fs_get_userdata
 mnt_fs_get_user_options
 mnt_fs_get_vfs_options
+mnt_fs_get_vfs_options_all
 mnt_fs_is_kernel
 mnt_fs_is_netfs
 mnt_fs_is_pseudofs
diff --git a/libmount/src/fs.c b/libmount/src/fs.c
index d669b6167..6ceff821f 100644
--- a/libmount/src/fs.c
+++ b/libmount/src/fs.c
@@ -951,6 +951,37 @@ const char *mnt_fs_get_vfs_options(struct libmnt_fs *fs)
 	return fs ? fs->vfs_optstr : NULL;
 }
 
+/**
+ * mnt_fs_get_vfs_options_all:
+ * @fs: fstab/mtab entry pointer
+ *
+ * Returns: pointer to all (including defaults) fs-independent (VFS) mount
+ * option string or NULL.
+ */
+char *mnt_fs_get_vfs_options_all(struct libmnt_fs *fs)
+{
+       const struct libmnt_optmap *map = mnt_get_builtin_optmap(MNT_LINUX_MAP);
+       const struct libmnt_optmap *ent;
+       const char *opts = mnt_fs_get_options(fs);
+       char *result = NULL;
+       unsigned long flags = 0;
+
+       if (!opts || mnt_optstr_get_flags(opts, &flags, map))
+              return NULL;
+
+       for (ent = map ; ent && ent->name ; ent++){
+               if (ent->id & flags) /* non-default value */
+                      if (!(ent->mask & MNT_INVERT))
+                              mnt_optstr_append_option(&result, ent->name, NULL);
+                      else
+                              continue;
+               else if (ent->mask & MNT_INVERT)
+                       mnt_optstr_append_option(&result, ent->name, NULL);
+       }
+
+       return result;
+}
+
 /**
  * mnt_fs_get_user_options:
  * @fs: fstab/mtab entry pointer
diff --git a/libmount/src/libmount.h.in b/libmount/src/libmount.h.in
index e6710ae01..b7b278d0e 100644
--- a/libmount/src/libmount.h.in
+++ b/libmount/src/libmount.h.in
@@ -471,6 +471,7 @@ extern int mnt_fs_get_option(struct libmnt_fs *fs, const char *name,
 extern const char *mnt_fs_get_fs_options(struct libmnt_fs *fs);
 extern const char *mnt_fs_get_vfs_options(struct libmnt_fs *fs);
 extern const char *mnt_fs_get_user_options(struct libmnt_fs *fs);
+extern char *mnt_fs_get_vfs_options_all(struct libmnt_fs *fs);
 
 extern const char *mnt_fs_get_attributes(struct libmnt_fs *fs);
 extern int mnt_fs_set_attributes(struct libmnt_fs *fs, const char *optstr);
diff --git a/libmount/src/libmount.sym b/libmount/src/libmount.sym
index 792d11753..c03e1a5e0 100644
--- a/libmount/src/libmount.sym
+++ b/libmount/src/libmount.sym
@@ -355,4 +355,5 @@ MOUNT_2_35 {
 	mnt_context_force_unrestricted;
 	mnt_context_get_target_prefix;
 	mnt_context_set_target_prefix;
+	mnt_fs_get_vfs_options_all;
 } MOUNT_2.34;
diff --git a/misc-utils/findmnt.8 b/misc-utils/findmnt.8
index 86ab6ff93..388295d76 100644
--- a/misc-utils/findmnt.8
+++ b/misc-utils/findmnt.8
@@ -262,6 +262,11 @@ It's possible to specify source (device) or target (mountpoint) to filter mount
 .TP
 .B \-\-verbose
 Force findmnt to print more information (\fB\-\-verify\fP only for now).
+.TP
+.B \-\-vfs-all
+When used with
+.BR VFS-OPTIONS
+column, print all VFS (fs-independent) flags
 .SH ENVIRONMENT
 .IP LIBMOUNT_FSTAB=<path>
 overrides the default location of the fstab file
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 43b4dc7d6..294e853eb 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -545,7 +545,9 @@ static char *get_data(struct libmnt_fs *fs, int num)
 			str = xstrdup(mnt_fs_get_options(fs));
 		break;
 	case COL_VFS_OPTIONS:
-		if (mnt_fs_get_vfs_options(fs))
+		if (flags & FL_VFS_ALL)
+			str = mnt_fs_get_vfs_options_all(fs);
+		else if (mnt_fs_get_vfs_options(fs))
 			str = xstrdup(mnt_fs_get_vfs_options(fs));
 		break;
 	case COL_FS_OPTIONS:
@@ -1262,6 +1264,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputc('\n', out);
 	fputs(_(" -x, --verify           verify mount table content (default is fstab)\n"), out);
 	fputs(_("     --verbose          print more details\n"), out);
+	fputs(_("     --vfs-all          print all VFS options\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	printf(USAGE_HELP_OPTIONS(24));
@@ -1294,7 +1297,8 @@ int main(int argc, char *argv[])
 		FINDMNT_OPT_TREE,
 		FINDMNT_OPT_OUTPUT_ALL,
 		FINDMNT_OPT_PSEUDO,
-		FINDMNT_OPT_REAL
+		FINDMNT_OPT_REAL,
+		FINDMNT_OPT_VFS_ALL
 	};
 
 	static const struct option longopts[] = {
@@ -1338,6 +1342,7 @@ int main(int argc, char *argv[])
 		{ "tree",	    no_argument,       NULL, FINDMNT_OPT_TREE	 },
 		{ "real",	    no_argument,       NULL, FINDMNT_OPT_REAL	 },
 		{ "pseudo",	    no_argument,       NULL, FINDMNT_OPT_PSEUDO	 },
+		{ "vfs-all",	    no_argument,       NULL, FINDMNT_OPT_VFS_ALL },
 		{ NULL, 0, NULL, 0 }
 	};
 
@@ -1512,6 +1517,9 @@ int main(int argc, char *argv[])
 		case FINDMNT_OPT_REAL:
 			flags |= FL_REAL;
 			break;
+		case FINDMNT_OPT_VFS_ALL:
+			flags |= FL_VFS_ALL;
+			break;
 
 		case 'h':
 			usage();
diff --git a/misc-utils/findmnt.h b/misc-utils/findmnt.h
index 6388837a0..92d1119ae 100644
--- a/misc-utils/findmnt.h
+++ b/misc-utils/findmnt.h
@@ -20,6 +20,7 @@ enum {
 	FL_VERBOSE	= (1 << 16),
 	FL_PSEUDO	= (1 << 17),
 	FL_REAL		= (1 << 18),
+	FL_VFS_ALL	= (1 << 19),
 
 	/* basic table settings */
 	FL_ASCII	= (1 << 20),
-- 
2.21.0


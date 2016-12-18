Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wj0-f195.google.com ([209.85.210.195]:35202 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753423AbcLRScr (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 18 Dec 2016 13:32:47 -0500
Received: by mail-wj0-f195.google.com with SMTP id he10so20967055wjc.2
        for <util-linux@vger.kernel.org>; Sun, 18 Dec 2016 10:32:46 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/2] fsfreeze: move filesystem support info to manual page
Date: Sun, 18 Dec 2016 18:32:41 +0000
Message-Id: <20161218183241.1826-2-kerolasa@iki.fi>
In-Reply-To: <20161218183241.1826-1-kerolasa@iki.fi>
References: <20161218183241.1826-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Include btrfs, f2fs, and nilfs to list of supported filesystems, with note
the list can be incomplete.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/fsfreeze.8 | 14 ++++++++++++++
 sys-utils/fsfreeze.c |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/sys-utils/fsfreeze.8 b/sys-utils/fsfreeze.8
index c5bac7334..c5d812dff 100644
--- a/sys-utils/fsfreeze.8
+++ b/sys-utils/fsfreeze.8
@@ -61,6 +61,20 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
+.SH FILESYSTEM SUPPORT
+This command will work only if filesystem supports has support for freezing.
+List of these filesystems include (2016-12-18)
+.BR btrfs ,
+.BR ext2/3/4 ,
+.BR f2fs ,
+.BR jfs ,
+.BR nilfs2 ,
+.BR reiserfs ,
+and
+.BR xfs .
+Previous list may be incomplete, as more filesystems get support.  If in
+doubt easiest way to know if a filesystem has support is create a small
+loopback mount and test freezing it.
 .SH AUTHOR
 .PP
 Written by Hajime Taira.
diff --git a/sys-utils/fsfreeze.c b/sys-utils/fsfreeze.c
index a9b32aa66..41a33659e 100644
--- a/sys-utils/fsfreeze.c
+++ b/sys-utils/fsfreeze.c
@@ -40,7 +40,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	      _(" %s [options] <mountpoint>\n"), program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, out);
-	fputs(_("Suspend access to a filesystem (ext3/4, ReiserFS, JFS, XFS).\n"), out);
+	fputs(_("Suspend access to a filesystem.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -f, --freeze      freeze the filesystem\n"), out);
-- 
2.11.0


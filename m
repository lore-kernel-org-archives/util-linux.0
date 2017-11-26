Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37025 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbdKZR10 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 26 Nov 2017 12:27:26 -0500
Received: by mail-wr0-f193.google.com with SMTP id k61so24283987wrc.4
        for <util-linux@vger.kernel.org>; Sun, 26 Nov 2017 09:27:26 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/2] misc: fix typos
Date: Sun, 26 Nov 2017 17:27:20 +0000
Message-Id: <20171126172721.9504-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libfdisk/src/context.c  | 2 +-
 libsmartcols/src/line.c | 2 +-
 login-utils/su-common.c | 2 +-
 misc-utils/wipefs.8     | 2 +-
 text-utils/column.1     | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/libfdisk/src/context.c b/libfdisk/src/context.c
index fb7ad4b44..95d17acde 100644
--- a/libfdisk/src/context.c
+++ b/libfdisk/src/context.c
@@ -433,7 +433,7 @@ const char *fdisk_get_collision(struct fdisk_context *cxt)
  * fdisk_is_ptcollision:
  * @cxt: fdisk context
  *
- * The collision detected by libblkid (usally another partition table). Note
+ * The collision detected by libblkid (usually another partition table). Note
  * that libfdisk does not support all partitions tables, so fdisk_has_label()
  * may return false, but fdisk_is_ptcollision() may return true.
  *
diff --git a/libsmartcols/src/line.c b/libsmartcols/src/line.c
index 6c64e7f62..ace6239ae 100644
--- a/libsmartcols/src/line.c
+++ b/libsmartcols/src/line.c
@@ -160,7 +160,7 @@ int scols_line_move_cells(struct libscols_line *ln, size_t newn, size_t oldn)
 	/* remember data from old position */
 	memcpy(&ce, &ln->cells[oldn], sizeof(struct libscols_cell));
 
-	/* remove old possition (move data behind oldn to oldn) */
+	/* remove old position (move data behind oldn to oldn) */
 	if (oldn + 1 < ln->ncells)
 		memmove(ln->cells + oldn, ln->cells + oldn + 1,
 			(ln->ncells - oldn - 1) * sizeof(struct libscols_cell));
diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index b9deeeab1..0ba6d1953 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -130,7 +130,7 @@ struct su_context {
 	const char	*tty_number;		/* end of the tty_path */
 
 	char		*new_user;		/* wanted user */
-	char		*old_user;		/* orginal user */
+	char		*old_user;		/* original user */
 
 	pid_t		child;			/* fork() baby */
 	int		childstatus;		/* wait() status */
diff --git a/misc-utils/wipefs.8 b/misc-utils/wipefs.8
index 5d768f2f9..0685c1ac9 100644
--- a/misc-utils/wipefs.8
+++ b/misc-utils/wipefs.8
@@ -114,7 +114,7 @@ Display version information and exit.
 .SH EXAMPLES
 .TP
 .BR "wipefs /dev/sda*"
-Prints infomation about sda and all partitions on sda.
+Prints information about sda and all partitions on sda.
 .TP
 .BR "wipefs --all --backup /dev/sdb"
 Erases all signatures from the device /dev/sdb and creates a signature backup
diff --git a/text-utils/column.1 b/text-utils/column.1
index b22468049..3e6aa3b32 100644
--- a/text-utils/column.1
+++ b/text-utils/column.1
@@ -81,7 +81,7 @@ supplied using the \fB\-\-output\-separator\fP option.
 Table output is useful for pretty-printing.
 .IP "\fB\-N, \-\-table-columns\fP \fInames\fP"
 Specify the columns names by comma separated list of names. The names are used
-for the table header or to addres column in option arguments.
+for the table header or to address column in option arguments.
 .IP "\fB\-R, \-\-table-right\fP \fIcolumns\fP"
 Right align text in the specified columns.
 .IP "\fB\-T, \-\-table-truncate\fP \fIcolumns\fP"
-- 
2.15.0


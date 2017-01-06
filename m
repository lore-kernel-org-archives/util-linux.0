Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wj0-f196.google.com ([209.85.210.196]:36213 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968462AbdAFXyk (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 6 Jan 2017 18:54:40 -0500
Received: by mail-wj0-f196.google.com with SMTP id dh1so473516wjb.3
        for <util-linux@vger.kernel.org>; Fri, 06 Jan 2017 15:54:39 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] man: fix couple tools/checkmans.sh warnings
Date: Fri,  6 Jan 2017 23:54:34 +0000
Message-Id: <20170106235434.10975-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

<standard input>:407: warning: macro `fi.' not defined (possibly missing space after `fi')
From: cat ./disk-utils/fsck.8 | troff -mandoc -ww -z

<standard input>:71: warning: escape character ignored before `1'
From: cat ./disk-utils/partx.8 | troff -mandoc -ww -z

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/fsck.8  | 2 +-
 disk-utils/partx.8 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/disk-utils/fsck.8 b/disk-utils/fsck.8
index 8ae636a77..3148e4284 100644
--- a/disk-utils/fsck.8
+++ b/disk-utils/fsck.8
@@ -404,7 +404,7 @@ or
 .nf
 Theodore Ts'o <tytso@mit.edu>
 Karel Zak <kzak@redhat.com>
-.fi.
+.fi
 .SH AVAILABILITY
 The fsck command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/disk-utils/partx.8 b/disk-utils/partx.8
index 4c32a4f11..7ff9b27f3 100644
--- a/disk-utils/partx.8
+++ b/disk-utils/partx.8
@@ -68,7 +68,7 @@ Do not use it in newly written scripts.
 Specify the range of partitions.  For backward compatibility also the
 format \fIM\fB\-\fIN\fR is supported.
 The range may contain negative numbers, for example
-.B \-\-nr -\1:\-1
+.B \-\-nr \-1:\-1
 means the last partition, and
 .B \-\-nr \-2:\-1
 means the last two partitions.  Supported range specifications are:
-- 
2.11.0


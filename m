Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-ch2-03v.sys.comcast.net ([69.252.207.35]:58864 "EHLO
        resqmta-ch2-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754493AbdFWVhQ (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Jun 2017 17:37:16 -0400
From: "W. Trevor King" <wking@tremily.us>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 1/8] sys-utils/fstab.5: Remove basic filesystem-independent options
Date: Fri, 23 Jun 2017 14:30:19 -0700
Message-Id: <c04b40fb8c6e7d06806b060ff7bc74f65ded9aee.1498252231.git.wking@tremily.us>
In-Reply-To: <cover.1498252231.git.wking@tremily.us>
References: <cover.1498252231.git.wking@tremily.us>
In-Reply-To: <cover.1498252231.git.wking@tremily.us>
References: <cover.1498252231.git.wking@tremily.us>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

These options are covered in mount(8), so there's no need to repeat
them here.

Also update mount(8):

* Add the text linking (no)auto to boot time, which was previously
  documented only in fstab(5).
* Document comment=, previously documented only in fstab(5), borrowing
  language from the current mount(8) X-* entry.
* Use bold (instead of quotes) for X- in the X-* entry.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 sys-utils/fstab.5 | 31 ++-----------------------------
 sys-utils/mount.8 | 17 ++++++++++++++---
 2 files changed, 16 insertions(+), 32 deletions(-)

diff --git a/sys-utils/fstab.5 b/sys-utils/fstab.5
index 07d0287..d292f1f 100644
--- a/sys-utils/fstab.5
+++ b/sys-utils/fstab.5
@@ -155,39 +155,12 @@ deprecated).
 .RS
 This field describes the mount options associated with the filesystem.
 
-It is formatted as a comma-separated list of options.
-It contains at least the type of mount
-.RB ( ro
-or
-.BR rw ),
-plus any additional options appropriate to the filesystem
-type (including performance-tuning options).
+It is formatted as a comma-separated list of options, which may depend
+on the filesystem type (including performance-tuning options).
 For details, see
 .BR mount (8)
 or
 .BR swapon (8).
-
-Basic filesystem-independent options are:
-.TP
-.B defaults
-use default options: rw, suid, dev, exec, auto, nouser, and async.
-.TP
-.B noauto
-do not mount when "mount -a" is given (e.g., at boot time)
-.TP
-.B user
-allow a user to mount
-.TP
-.B owner
-allow device owner to mount
-.TP
-.B comment
-or
-.B x-<name>
-for use by fstab-maintaining programs
-.TP
-.B nofail
-do not report errors for this device if it does not exist.
 .RE
 
 .B The fifth field
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 3bd278e..7800734 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -870,13 +870,22 @@ inode types (directories too), so it implies \fB\%nodiratime\fR.
 .B auto
 Can be mounted with the
 .B \-a
-option.
+option (e.g., at boot time).
 .TP
 .B noauto
 Can only be mounted explicitly (i.e., the
 .B \-a
 option will not cause the filesystem to be mounted).
 .TP
+.B comment=*
+All options prefixed with
+.BR comment=
+are interpreted as comments or as userspace application-specific options.
+These options are not stored in the user space (e.g. mtab file),
+nor sent to the mount.\fItype\fR helpers nor to the
+.BR mount (2)
+system call.  The suggested format is \fBcomment=\fIappname\fR.\fIoption\fR.
+.TP
 .na
 .BR context=\fIcontext ", " fscontext=\fIcontext ", " defcontext=\fIcontext ", and " \%rootcontext=\fIcontext
 .ad
@@ -1165,8 +1174,10 @@ This option implies the options
 .BR users,exec,dev,suid ).
 .TP
 .B X-*
-All options prefixed with "X-" are interpreted as comments or as userspace
-application-specific options.  These options are not stored in the user space (e.g. mtab file),
+All options prefixed with
+.BR X-
+are interpreted as comments or as userspace application-specific options.
+These options are not stored in the user space (e.g. mtab file),
 nor sent to the mount.\fItype\fR helpers nor to the
 .BR mount (2)
 system call.  The suggested format is \fBX-\fIappname\fR.\fIoption\fR.
-- 
2.1.0.60.g85f0837


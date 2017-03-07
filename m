Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754339AbdCGDQD (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 6 Mar 2017 22:16:03 -0500
From: Masatake YAMATO <yamato@redhat.com>
To: util-linux@vger.kernel.org
Cc: yamato@redhat.com
Subject: [PATCH 2/4] man: add a page for fincore command
Date: Tue,  7 Mar 2017 11:33:50 +0900
Message-Id: <20170307023352.7340-3-yamato@redhat.com>
In-Reply-To: <20170307023352.7340-1-yamato@redhat.com>
References: <20170307023352.7340-1-yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 misc-utils/Makemodule.am |  1 +
 misc-utils/fincore.1     | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 misc-utils/fincore.1

diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
index 6c7fab6..8cad4d6 100644
--- a/misc-utils/Makemodule.am
+++ b/misc-utils/Makemodule.am
@@ -183,5 +183,6 @@ endif
 
 if BUILD_FINCORE
 usrbin_exec_PROGRAMS += fincore
+dist_man_MANS += misc-utils/fincore.1
 fincore_SOURCES = misc-utils/fincore.c
 endif
diff --git a/misc-utils/fincore.1 b/misc-utils/fincore.1
new file mode 100644
index 0000000..7b9b799
--- /dev/null
+++ b/misc-utils/fincore.1
@@ -0,0 +1,76 @@
+.\" Copyright 2017 Red Hat, Inc.
+.\"
+.\" This file may be copied under the terms of the GNU Public License.
+.TH FINCORE 1 "March 2017" "util-linux" "User Commands"
+.SH NAME
+fincore \- count pages of file contents in core
+.SH SYNOPSIS
+.B fincore
+[options]
+.I file ...
+.SH DESCRIPTION
+.B fincore
+counts pages of file contents being resident in memory(in core), and
+reports the numbers.  An output line has 3 columns: the number of
+pages in core, a file size in bytes, and a file name.  If an error
+occurs during counting, failing to open a file for example,
+.B failed
+is printed at the column of the number of pages in core.  Even if
+errors occur,
+.B fincore
+continues processing the rest of files listed in a command line.
+.SH OPTIONS
+.TP
+\fB\-V\fR, \fB\-\-version\fR
+Display version information and exit.
+.TP
+\fB\-h\fR, \fB\-\-help\fR
+Display help text and exit.
+.SH EXAMPLES
+.PP
+An example of successfully executed case:
+.PP
+.RS
+.PD 0
+.TP
+.B fincore /etc/fstab /bin/emacs
+.TP
+1          1544       /etc/fstab
+.TP
+4156       17163144   /bin/emacs
+.TP
+.B echo $?
+.TP
+0
+.PD
+.RE
+.PP
+An example of failure case:
+.PP
+.RS
+.PD 0
+.TP
+.B fincore /etc/passwd
+.TP
+.I fincore: failed to open: /var/log/messages: Permission denied
+.TP
+failed     -1         /var/log/messages
+.TP
+.B echo $?
+.TP
+1
+.PD
+.RE
+.SH AUTHORS
+.MT yamato@\:redhat.com
+Masatake YAMATO
+.ME
+.SH "SEE ALSO"
+.BR mincore (2),
+.BR getpagesize (2),
+.BR getconf (1)
+.SH AVAILABILITY
+The example command is part of the util-linux package and is available from
+.UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
+Linux Kernel Archive
+.UE .
-- 
2.9.3


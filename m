Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdccah.dreamhost.com ([208.97.132.207]:41452 "EHLO
	homiemail-a61.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751291Ab2DBOgD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 2 Apr 2012 10:36:03 -0400
Subject: [PATCH 3/3] fibmap: add manpage
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Apr 2012 16:35:52 +0200
Message-ID: <1333377352.2552.21.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 sys-utils/fibmap.8 |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)
 create mode 100644 sys-utils/fibmap.8

diff --git a/sys-utils/fibmap.8 b/sys-utils/fibmap.8
new file mode 100644
index 0000000..5a85dbc
--- /dev/null
+++ b/sys-utils/fibmap.8
@@ -0,0 +1,60 @@
+.\" fibmap.8 --
+.\" Copyright 2012 Davidlohr Bueso <dave@gnu.org>
+.\" May be distributed under the GNU General Public License
+
+.TH FIBMAP 8 "April 2012" "util-linux" "System Administration"
+.SH NAME
+fibmap \-
+get a file/filesystem block layout and fragmentation information.
+.SH SYNOPSIS
+.B fibmap
+.RB [options]
+.RB file/directory
+
+.SH DESCRIPTION
+The \fBfibmap\fP command displays a given file or filesystem fragmentation and block layout information.
+It does not depend on a specific filesystem or block size.
+
+.SH OPTIONS
+.IP "\fB\-f, \-\-fragonly\fP"
+Show only fragmented files.
+.IP "\fB\-m, \-\-map\fP"
+Show block map for a given file.
+.IP "\fB\-s, \-\-stat\fP"
+Show fragmentation statistics, mostly for directories and not individual files.
+.IP "\fB\-h, \-\-help\fP"
+Print a help text and exit.
+.IP "\fB\-o, \-\-output \fIlist\fP"
+Specify which output columns to print. Use
+.B "--help"
+to get a list of all supported columns.
+.IP "\fB\-n, \-\-noheadings\fP"
+Do not print a header line.
+.IP "\fB\-r, \-\-raw\fP"
+Use the raw output format.
+
+.RE
+.SH EXAMPLES
+.IP "\fBfibmap \-\-stat /home\fP"
+Display fragmentation statistics for /home partition.
+.IP "\fBfibmap \-\-fragonly .\fP"
+Display only fragmented files in the current directory.
+.IP "\fBfibmap \-\-map test.img bsd.img\fP"
+Display block map for test.img and bsd.img image files.
+
+.SH "SEE ALSO"
+.BR hdparam (8)
+.BR filefrag (8)
+
+.SH NOTES
+.nf
+The fibmap ioctl, and thus this command, requires root superuser permission.
+.fi
+
+.SH AUTHORS
+.nf
+Davidlohr Bueso <dave@gnu.org>
+.fi
+.SH AVAILABILITY
+The fibmap command is part of the util-linux package and is available from
+ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
-- 
1.7.4.1





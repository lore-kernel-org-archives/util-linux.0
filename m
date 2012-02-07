Return-Path: dave@gnu.org
Subject: [PATCH 4/4] lslocks: add manpage
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 07 Feb 2012 23:42:02 +0100
Message-ID: <1328654522.3500.13.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 misc-utils/lslocks.8 |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 74 insertions(+), 0 deletions(-)
 create mode 100644 misc-utils/lslocks.8

diff --git a/misc-utils/lslocks.8 b/misc-utils/lslocks.8
new file mode 100644
index 0000000..120e097
--- /dev/null
+++ b/misc-utils/lslocks.8
@@ -0,0 +1,74 @@
+.\" lslocks.8 --
+.\" Copyright 2012 Davidlohr Bueso <dave@gnu.org>
+.\" May be distributed under the GNU General Public License
+
+.TH LSLOCKS 8 "February 2012" "util-linux" "System Administration"
+.SH NAME
+lslocks \-
+list local system locks
+.SH SYNOPSIS
+.B lslocks
+.RB [options]
+
+.SH DESCRIPTION
+.B lslocks
+lists information about all the file held locks in a Linux system.
+
+.SH OPTIONS
+.IP "\fB\-p, \-\-pid\fP"
+Specify the process id, if none is given, it will display all locks
+.IP "\fB\-h, \-\-help\fP"
+Print a help text and exit.
+.IP "\fB\-o, \-\-output \fIlist\fP"
+Specify which output columns to print. Use
+.B "--help"
+to get a list of all supported columns.
+.IP "\fB\-\-noheadings\fP"
+Do not print a header line.
+
+.IP "\fB\-\-raw\fP"
+Use the raw output format.
+
+.SH OUTPUT
+.IP "COMMAND"
+The command name of the process holding the lock.
+
+.IP "PID"
+Process ID which holds the lock.
+
+.IP "SIZE"
+Size of the locked file.
+
+.IP "ACCESS"
+Lock access permissions (read, write).
+
+.IP "M"
+Mandatory state of the lock: 0 if none; 1 if set.  (See chmod(1)).
+
+.IP "START"
+Relative byte offset of the lock.
+
+.IP "END"
+Ending offset of the lock.
+
+.IP "PATH"
+Full path of the lock - if none is found it will fallback to the device's mountpoint.
+
+.SH NOTES
+.nf
+The lslocks command is meant to replace the lslk(8) command, originally written by
+Victor A. Abell <abe@purdue.edu> and unmaintained since 2001.
+.fi
+
+.SH AUTHORS
+.nf
+Davidlohr Bueso <dave@gnu.org>
+.fi
+
+.SH "SEE ALSO"
+.BR lslk (8),
+.BR flock (1)
+
+.SH AVAILABILITY
+The lslocks command is part of the util-linux package and is available from
+ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
-- 
1.7.4.1

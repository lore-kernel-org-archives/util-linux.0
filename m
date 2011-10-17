Return-Path: dave@gnu.org
Date: Mon, 17 Oct 2011 19:23:13 -0400
From: Davidlohr Bueso <dave@gnu.org>
Subject: [PATCH 3/3] prlimit: add manpage documentation
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Message-id: <1318893793.5289.11.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 sys-utils/prlimit.1 |   83 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 83 insertions(+), 0 deletions(-)
 create mode 100644 sys-utils/prlimit.1

diff --git a/sys-utils/prlimit.1 b/sys-utils/prlimit.1
new file mode 100644
index 0000000..2f1e666
--- /dev/null
+++ b/sys-utils/prlimit.1
@@ -0,0 +1,83 @@
+.\" prlimit.1 --
+.\" Copyright 2011 Davidlohr Bueso <dave@gnu.org>
+.\" May be distributed under the GNU General Public License
+
+.TH PRLIMIT 1 "October 2011" "util-linux" "User Commands"
+.SH NAME
+prlimit \-
+get and set a process resource limits.
+.SH SYNOPSIS
+.B prlimit
+.RB [ \--{resource_name}
+.IR soft:hard ]
+
+.SH DESCRIPTION
+Given a process id and one or more resources, \fBprlimit\fP tries to retrieve and/or modify it's limits. Below is a complete list of resources.
+
+.SH GENERAL OPTIONS
+.IP "\fB\-p, \-\-pid\fP"
+Specify the process id, if none is given, it will use the running process.
+.IP "\fB\-o, \-\-output \fIlist\fP"
+Define the output columns to use. If no output arrangement is specified, then a default set is used.
+Use \fB\-\-help\fP to  get list of all supported columns.
+.IP "\fB\-V, \-\-version\fP"
+Output version information and exit.
+.IP "\fB\-h, \-\-help\fP"
+Print a help text and exit.
+
+.SH RESOURCE OPTIONS
+.IP "\fB\-a, \-\-as\fP"
+Address space limit.
+.IP "\fB\-c, \-\-core\fP"
+Maximum size of a core file.
+.IP "\fB\-C, \-\-cpu\fP"
+CPU time, in seconds.
+.IP "\fB\-d, \-\-data\fP"
+Maximum data size.
+.IP "\fB\-f, \-\-fsize\fP"
+Maximum file size.
+.IP "\fB\-l, \-\-locks\fP"
+Maximum amount of file locks held.
+.IP "\fB\-m, \-\-memlock\fP"
+Maximum locked-in-memory address space.
+.IP "\fB\-M, \-\-msgqueue\fP"
+Maximum amount of bytes in POSIX message queues.
+.IP "\fB\-n, \-\-nice\fP"
+Maximum nice priority allowed to raise.
+.IP "\fB\-N, \-\-nofile\fP"
+Maximum amount of open files.
+.IP "\fB\-P, \-\-nproc\fP"
+Maximum amount of processes.
+.IP "\fB\-r, \-\-rss\fP"
+Maximum Resident Set Size (RSS).
+.IP "\fB\-R, \-\-rtprio\fP"
+Maximum real-time priority.
+.IP "\fB\-t, \-\-rttime\fP"
+Timeout for real-time tasks.
+.IP "\fB\-s, \-\-sigpending\fP"
+Maximum amount of pending signals.
+.IP "\fB\-S, \-\-stack\fP"
+Maximum size of the stack.
+
+.TP
+Note that all of these options allow a parameter soft:high to set the soft and high values for the resource's limits. If nothing is passed, then prlimit will only display them. The soft value must be lower or equal to the high value, as this is the maximum value the limit can go to. If one of the values is not passed, then the already existing one will be used. See the examples below.
+
+.RE
+.SH EXAMPLES
+.IP "\fBprlimit \-\-pid 13134\fP"
+Display limit values for all current resources.
+.IP "\fBprlimit \-\-pid 13134 \--rss --nofile=1024:4095\fP"
+Display the limits of the RSS and set the soft and hard limits for the amount of open files to 1024 and 4095, respectively.
+.IP "\fBprlimit \-\-pid 13134 --nproc=512:\fP"
+Modify only the soft limit for the amount of processes.
+
+.BR prlimit (2),
+.BR ulimit (1)
+
+.SH AUTHORS
+.nf
+Davidlohr Bueso <dave@gnu.org> - In memory of Dennis M. Ritchie.
+.fi
+.SH AVAILABILITY
+The prlimit command is part of the util-linux package and is available from
+ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
-- 
1.7.7

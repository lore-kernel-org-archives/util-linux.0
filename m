Return-Path: util-linux-owner@vger.kernel.org
Received: from mtagate7.uk.ibm.com ([194.196.100.167]:45708 "EHLO
	mtagate7.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839Ab1JJJAb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 10 Oct 2011 05:00:31 -0400
Received: from d06nrmr1307.portsmouth.uk.ibm.com (d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate7.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p9A90TXw001485
	for <util-linux@vger.kernel.org>; Mon, 10 Oct 2011 09:00:29 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com [9.149.37.212])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p9A90SLf2134110
	for <util-linux@vger.kernel.org>; Mon, 10 Oct 2011 10:00:28 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p9A90R1h017846
	for <util-linux@vger.kernel.org>; Mon, 10 Oct 2011 03:00:27 -0600
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 5/6] chcpu: man page update
Date: Mon, 10 Oct 2011 10:59:43 +0200
Message-Id: <1318237184-6616-6-git-send-email-heiko.carstens@de.ibm.com>
In-Reply-To: <1318237184-6616-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1318237184-6616-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Move chcpu man page to section 8 (admin commands) where it belongs.
Also update the contents of the man page.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/Makefile.am |    2 +-
 sys-utils/chcpu.1     |   94 -------------------------------------------------
 sys-utils/chcpu.8     |   85 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 95 deletions(-)
 delete mode 100644 sys-utils/chcpu.1
 create mode 100644 sys-utils/chcpu.8

diff --git a/sys-utils/Makefile.am b/sys-utils/Makefile.am
index 8059ee6..1be7eaf 100644
--- a/sys-utils/Makefile.am
+++ b/sys-utils/Makefile.am
@@ -28,7 +28,7 @@ dist_man_MANS += lscpu.1
 sbin_PROGRAMS += chcpu
 chcpu_SOURCES = chcpu.c $(top_srcdir)/lib/cpuset.c \
 			$(top_srcdir)/lib/path.c
-dist_man_MANS += chcpu.1
+dist_man_MANS += chcpu.8
 endif
 
 endif
diff --git a/sys-utils/chcpu.1 b/sys-utils/chcpu.1
deleted file mode 100644
index 9417a72..0000000
--- a/sys-utils/chcpu.1
+++ /dev/null
@@ -1,94 +0,0 @@
-.TH CHCPU 1 "August 2011" Linux "User Manuals"
-.SH NAME
-chcpu \- CPU configuration utility
-.SH SYNOPSIS
-.B chcpu
-\fB-c\fP|\fB\-d\fP|\fB\-e\fP|\fB\-g\fP
-.IR cpu-list
-.br
-.B
-\fBchcpu \-p\fP \fImode\fP
-.br
-.B chcpu
-.RB [ \-rhV\ ]
-.br
-.SH DESCRIPTION
-.B chcpu
-can modify the logical state of CPUs. It can enable and disable CPUs, scan
-for new CPUs, change the CPU dispatching mode of the underlying hypervisor
-and request (configure) or give logical CPUs back (deconfigure) to the
-the underlying hypervisor.
-
-Some options have a \fIcpu-list\fP argument. A \fIcpu-list\fP may specify
-multiple CPUs, separated by comma, and ranges.  For example,
-.BR 0,5,7,9-11 .
-.SH OPTIONS
-The --configure, --deconfigure, --disable, --dispatch, --enable and --rescan
-options are mutually exclusive.
-.TP
-.BR \-c , " \-\-configure " <\fIcpu-list\fP>
-Configure all CPUs specified with \fIcpu-list\fP. If
-.BR chcpu
-fails to configure a CPU specified in the \fIcpu-list\fP it will skip that
-CPU and continue with the next one until all specified CPUs have been
-processed.
-.br
-Configuring a CPU means that the underlying hypervisor is informed that
-a logical CPU within a guest should be used. If the hypervisor has enough
-resources the request will succeed.
-.TP
-.BR \-d , " \-\-disable " <\fIcpu-list\fP>
-Disable all CPUs specified with \fIcpu-list\fP. If
-.BR chcpu
-fails to disable a CPU specified in the \fIcpu-list\fP it will skip that
-CPU and continue with the next one until all specified CPUs have been
-processed.
-.br
-When a CPU has been disabled its state is offline.
-.TP
-.BR \-e , " \-\-enable " <\fIcpu-list\fP>
-Enable all CPUs specified with \fIcpu-list\fP. If
-.BR chcpu
-fails to enable a CPU specified in the \fIcpu-list\fP it will skip that
-CPU and continue with the next one until all specified CPUs have been
-processed.
-.br
-When a CPU has been enabled its state is online.
-.TP
-.BR \-g , " \-\-deconfigure " <\fIcpu-list\fP>
-Deconfigure all CPUs specified with \fIcpu-list\fP. If
-.BR chcpu
-fails to deconfigure a CPU specified in the \fIcpu-list\fP it will skip
-that CPU and continue with the next one until all specified CPUs have been
-processed. Only disabled (offline) CPUs can be deconfigured.
-.br
-Deconfiguring a CPU means that the underlying hypervisor is informed that
-the CPU will not be used anymore and that the hypervisor can add the CPU
-back to its CPU pool.
-.TP
-.BR \-h , " \-\-help"
-Print a help text and exit.
-.TP
-.BR \-p , " \-\-dispatch " <\fImode\fP>
-Set the CPU dispatching \fImode\fP if the underlying hypervisor supports this.
-\fImode\fP may be horizontal or vertical.
-.TP
-.BR \-r , " \-\-rescan"
-Trigger a rescan of CPUs. If new CPUs have been attached to the system the
-kernel will detect them. On some systems no event will be generated if a
-CPU gets attached. In that case a CPU rescan must be manually triggered.
-.TP
-.BR \-V , " \-\-version"
-Output version information and exit.
-.SH AUTHOR
-.nf
-Heiko Carstens <heiko.carstens@de.ibm.com>
-.fi
-.SH COPYRIGHT
-Copyright IBM Corp. 2011
-.br
-.SH "SEE ALSO"
-.BR lscpu (1)
-.SH AVAILABILITY
-The chcpu command is part of the util-linux package and is available from
-ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
diff --git a/sys-utils/chcpu.8 b/sys-utils/chcpu.8
new file mode 100644
index 0000000..8bafd0d
--- /dev/null
+++ b/sys-utils/chcpu.8
@@ -0,0 +1,85 @@
+.TH CHCPU 8 "August 2011" Linux "User Manuals"
+.SH NAME
+chcpu \- configure CPUs
+.SH SYNOPSIS
+.B chcpu
+.BR \-e | \-d | \-c | \-g " \fIcpu-list\fP"
+.br
+.B chcpu
+.BR \-p " \fImode\fP"
+.br
+.B chcpu
+.BR \-r
+.br
+.B chcpu
+.BR \-h | \-V
+.br
+.SH DESCRIPTION
+.B chcpu
+can modify the state of CPUs. It can enable or disable CPUs, scan
+for new CPUs, change the CPU dispatching mode of the underlying hypervisor,
+and request CPUs from the hypervisor (configure) or return CPUs to the
+hypervisor (deconfigure).
+
+Some options have a \fIcpu-list\fP argument. Use this argument to specify a
+comma-separated list of CPUs. The list can contain individual CPU addresses or
+ranges of addresses.
+For example,
+.BR 0,5,7,9-11
+makes the command applicable to the CPUs with the addresses 0, 5, 7, 9, 10, and
+11.
+
+.SH OPTIONS
+.TP
+.BR \-r , " \-\-rescan"
+Trigger a rescan of CPUs. Use this option on systems that do not automatically
+detect newly attached CPUs. The Linux kernel then recognizes the new CPUs.
+.TP
+.BR \-c , " \-\-configure " \fIcpu-list\fP
+Configure all specified CPUs. Configuring a CPU means that the hypervisor takes
+a CPU from the CPU pool and assigns it to the virtual hardware on which your
+kernel runs.
+.TP
+.BR \-e , " \-\-enable " \fIcpu-list\fP
+Enable all specified CPUs. Enabling a CPU means that the kernel sets it
+online. A CPU must be configured, see -c,  before it can be enabled.
+.TP
+.BR \-p , " \-\-dispatch " \fImode\fP
+Set the CPU dispatching mode (polarization). This option has an effect only if
+your hardware architecture and hypervisor support CPU polarization. There are
+two modes:
+.RS
+.TP 12
+.B horizontal
+The workload is spread across all available CPUs.
+.TP 12
+.B vertical
+The workload is concentrated on few CPUs.
+.RE
+.TP
+.BR \-d , " \-\-disable " \fIcpu-list\fP
+Disable all specified CPUs. Disabling a CPU means that the kernel sets it offline.
+.TP
+.BR \-g , " \-\-deconfigure " \fIcpu-list\fP
+Deconfigure all specified CPUs. Deconfiguring a CPU means that the hypervisor
+removes the CPU from the virtual hardware on which the Linux instance runs and
+returns it to the CPU pool. A CPU must be offline, see -d,  before it can be
+deconfigured. 
+.TP
+.BR \-h , " \-\-help"
+Display help information and exit.
+.TP
+.BR \-V , " \-\-version"
+Display version information and exit.
+.SH AUTHOR
+.nf
+Heiko Carstens <heiko.carstens@de.ibm.com>
+.fi
+.SH COPYRIGHT
+Copyright IBM Corp. 2011
+.br
+.SH "SEE ALSO"
+.BR lscpu (1)
+.SH AVAILABILITY
+The chcpu command is part of the util-linux package and is available from
+ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
-- 
1.7.6.3


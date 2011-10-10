Return-Path: util-linux-owner@vger.kernel.org
Received: from mtagate2.uk.ibm.com ([194.196.100.162]:37244 "EHLO
	mtagate2.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939Ab1JJJAb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 10 Oct 2011 05:00:31 -0400
Received: from d06nrmr1507.portsmouth.uk.ibm.com (d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p9A90TBG030066
	for <util-linux@vger.kernel.org>; Mon, 10 Oct 2011 09:00:29 GMT
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com [9.149.37.252])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p9A90Tud1556546
	for <util-linux@vger.kernel.org>; Mon, 10 Oct 2011 10:00:29 +0100
Received: from d06av11.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av11.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p9A90RKM030284
	for <util-linux@vger.kernel.org>; Mon, 10 Oct 2011 03:00:27 -0600
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 6/6] lscpu: man page update
Date: Mon, 10 Oct 2011 10:59:44 +0200
Message-Id: <1318237184-6616-7-git-send-email-heiko.carstens@de.ibm.com>
In-Reply-To: <1318237184-6616-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1318237184-6616-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Rather large man page update which adds more information.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.1 |  136 +++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 97 insertions(+), 39 deletions(-)

diff --git a/sys-utils/lscpu.1 b/sys-utils/lscpu.1
index 47c4c31..2df4780 100644
--- a/sys-utils/lscpu.1
+++ b/sys-utils/lscpu.1
@@ -3,86 +3,144 @@
 .\"
 .TH LSCPU 1 "February 2011" "util-linux" "User Commands"
 .SH NAME
-lscpu \- display information on CPU architecture
+lscpu \- display information about the CPU architecture
 .SH SYNOPSIS
 .B lscpu
-.RB [ \-abcehpxV ]
-.RB [ \-s
-.IR directory ]
+.RB [ \-a | \-b | \-c "] [" \-x "] [" \-s " \fIdirectory\fP] [" \-e " [\fI=list\fP]|" \-p " [\fI=list\fP]]"
+.br
+.B lscpu
+.BR \-h | \-V
 .SH DESCRIPTION
 .B lscpu
-gathers CPU architecture information like number of CPUs, threads,
-cores, sockets, NUMA nodes, information about CPU caches, CPU family,
-model, bogoMIPS, byte order and stepping from sysfs and /proc/cpuinfo, and prints it in
-a human-readable format.  It supports both online and offline CPUs.
-It can also print out in a parsable format,
-including how different caches are shared by different CPUs,
-which can be fed to other programs.
+gathers CPU architecture information from sysfs and /proc/cpuinfo. The
+command output can be optimized for parsing or for easy readability by humans.
+.br
+The information includes, for example, the number of CPUs, threads, cores,
+sockets,  and Non-Uniform Memory Access (NUMA) nodes. There is also information
+about the CPU caches and cache sharing, family, model, bogoMIPS, byte order,
+and stepping.
+
+Options that result in an output table have a \fIlist\fP argument. Use this
+argument to customize the command output. Specify a comma-separated list of
+column labels to limit the output table to only the specified columns, arranged
+in the specified order. See \fBCOLUMNS\fP for a list of valid column labels. The
+column labels are not case sensitive.
 
-Some options have a \fIlist\fP argument. The \fIlist\fP argument is a comma
-delimited list of the columns. Currently supported are CPU, Core, Node, Socket,
-Book, Cache, Polarization, Address, Configured and Online columns.
-If the \fIlist\fP argument is given then all requested columns are printed in
-the defined order.
+Not all columns are supported on all architectures. If an unsupported column is
+specified, \fBlscpu\fP prints the column but does not provide any data for it.
 
+.SS COLUMNS
+.TP
+.B CPU
+The logical CPU number of a CPU as used by the Linux kernel.
+.TP
+.B Core
+The logical core number. A core can contain several CPUs.
+.TP
+.B Socket
+The logical socket number. A socket can contain several cores.
+.TP
+.B Book
+The logical book number. A book can contain several sockets.
+.TP
+.B Node
+The logical NUMA node number. A node may contain several books.
+.TP
+.B Cache
+Information about how caches are shared between CPUs.
+.TP
+.B Address
+The physical address of a CPU.
+.TP
+.B Online
+Indicator that shows whether the Linux instance currently makes use of the CPU.
+.TP
+.B Configured
+Indicator that shows if the hypervisor has allocated the CPU to the virtual
+hardware on which the Linux instance runs. CPUs that are configured can be set
+online by the Linux instance.
+This column contains data only if your hardware system and hypervisor support
+dynamic CPU resource allocation.
+.TP
+.B Polarization
+This column contains data for Linux instances that run on virtual hardware with
+a hypervisor that can switch the CPU dispatching mode (polarization). The
+polarization can be:
+.RS
+.TP 12
+.B horizontal\fP
+The workload is spread across all available CPUs.
+.TP 12
+.B vertical
+The workload is concentrated on few CPUs.
+.P
+For vertical polarization, the column also shows the degree of concentration,
+high, medium, or low. This column contains data only if your hardware system
+and hypervisor support CPU polarization.
+.RE
 .SH OPTIONS
 .TP
 .BR \-a , " \-\-all"
-Include online and offline CPUs in output (default for -e).
+Include online and offline CPUs in the output (default for -e).
 .TP
 .BR \-b , " \-\-online"
-Include only online CPUs in output (default for -p).
+Limit the output to online CPUs (default for -p).
 .TP
 .BR \-c , " \-\-offline"
-Include only offline CPUs in output.
+Limit the output to offline CPUs.
 .TP
 .BR \-e , " \-\-extended " \fI[=list]\fP
-Print CPU list out in human-readable format.
+Display the CPU information in human readable format.
 
-If the \fIlist\fP argument is not given then all columns where data is
-available will be printed.
+If the \fIlist\fP argument is omitted, all columns for which data is available
+are included in the command output.
 
-Note that the optional \fIlist\fP argument cannot be separated from the
-option by a space, the correct form is for example '\fB-e=cpu,node\fP' or '\fB--extended=cpu,node\fP'.
+When specifying the \fIlist\fP argument, the string of option, equal sign (=), and
+\fIlist\fP must not contain any blanks or other white space.
+Examples: '\fB-e=cpu,node\fP' or '\fB--extended=cpu,node\fP'.
 .TP
 .BR \-h , " \-\-help"
-Print a help message.
+Display help information and exit.
 .TP
 .BR \-p , " \-\-parse " \fI[=list]\fP
-Print out in parsable format.
+Optimize the command output for easy parsing.
 
-If the \fIlist\fP argument is not given then the default backwardly compatible
-output is printed.  The backwardly compatible format uses two commas to
-separate CPU cache columns. If no CPU caches are identified, then the cache
-columns are not printed at all.
+If the \fIlist\fP argument is omitted, the command output is compatible with earlier
+versions of \fBlscpu\fP. In this compatible format, two commas are used to separate
+CPU cache columns. If no CPU caches are identified the cache column is omitted.
 .br
-If the \fIlist\fP argument is given then the cache columns are separated by ':'.
+If the \fIlist\fP argument is used, cache columns are separated with a colon (:).
 
-Note that the optional \fIlist\fP argument cannot be separated from the
-option by a space, the correct form is for example '\fB-p=cpu,node\fP' or '\fB--parse=cpu,node\fP'.
+When specifying the \fIlist\fP argument, the string of option, equal sign (=), and
+\fIlist\fP must not contain any blanks or other white space.
+Examples: '\fB-p=cpu,node\fP' or '\fB--parse=cpu,node\fP'.
 .TP
 .BR \-s , " \-\-sysroot " \fIdirectory\fP
-Use the specified \fIdirectory\fP as system root.  This allows you to inspect
-a snapshot from a different system.
+Gather CPU data for a Linux instance other than the instance from which the
+\fBlscpu\fP command is issued. The specified \fIdirectory\fP is the system root
+of the Linux instance to be inspected.
 .TP
 .BR \-x , " \-\-hex"
-Use hexadecimal masks for CPU sets (e.g. 0x3).  The default is to print the sets
-in list format (e.g. 0,1).
+Use hexadecimal masks for CPU sets (for example 0x3).  The default is to print
+the sets in list format (for example 0,1).
 .TP
 .BR \-V , " \-\-version"
-Output version information and exit.
+Display version information and exit.
 .SH BUGS
 The basic overview about CPU family, model, etc. is always based on the first
 CPU only.
 
 Sometimes in Xen Dom0 the kernel reports wrong data.
+
+On virtual hardware the number of cores per socket, etc. can be wrong.
 .SH AUTHOR
 .nf
 Cai Qian <qcai@redhat.com>
 Karel Zak <kzak@redhat.com>
+Heiko Carstens <heiko.carstens@de.ibm.com>
 .fi
 .SH "SEE ALSO"
-.BR chcpu (1)
+.BR chcpu (8)
 .SH AVAILABILITY
 The lscpu command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
-- 
1.7.6.3


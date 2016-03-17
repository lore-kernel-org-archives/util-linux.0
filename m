Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews08.kpnxchange.com ([213.75.39.13]:61730 "EHLO
	cpsmtpb-ews08.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935410AbcCQJjl (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Mar 2016 05:39:41 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/5] lscpu: improve spacing and spelling in the man page
Date: Thu, 17 Mar 2016 10:39:11 +0100
Message-Id: <1458207554-2405-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1458207554-2405-1-git-send-email-bensberg@justemail.net>
References: <1458207554-2405-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/lscpu.1 |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sys-utils/lscpu.1 b/sys-utils/lscpu.1
index 26487d2..d61c2bc 100644
--- a/sys-utils/lscpu.1
+++ b/sys-utils/lscpu.1
@@ -1,4 +1,4 @@
-.TH LSCPU 1 "January 2013" "util-linux" "User Commands"
+.TH LSCPU 1 "November 2015" "util-linux" "User Commands"
 .SH NAME
 lscpu \- display information about the CPU architecture
 .SH SYNOPSIS
@@ -10,33 +10,33 @@ lscpu \- display information about the CPU architecture
 .SH DESCRIPTION
 .B lscpu
 gathers CPU architecture information from sysfs, /proc/cpuinfo and any
-applicable architecture-specific libraries (e.g. librtas on Powerpc). The
+applicable architecture-specific libraries (e.g.\& librtas on Powerpc).  The
 command output can be optimized for parsing or for easy readability by humans.
 The information includes, for example, the number of CPUs, threads, cores,
 sockets, and Non-Uniform Memory Access (NUMA) nodes.  There is also information
 about the CPU caches and cache sharing, family, model, bogoMIPS, byte order,
 and stepping.
-
+.sp
 In virtualized environments, the CPU architecture information displayed
 reflects the configuration of the guest operating system which is
-typically different from the physical (host) system. On architectures that
-support retreiving physical topology information,
+typically different from the physical (host) system.  On architectures that
+support retrieving physical topology information,
 .B lscpu
 also displays the number of physical sockets, chips, cores in the host system.
-
+.sp
 Options that result in an output table have a \fIlist\fP argument.  Use this
 argument to customize the command output.  Specify a comma-separated list of
 column labels to limit the output table to only the specified columns, arranged
 in the specified order.  See \fBCOLUMNS\fP for a list of valid column labels.  The
 column labels are not case sensitive.
-
+.sp
 Not all columns are supported on all architectures.  If an unsupported column is
 specified, \fBlscpu\fP prints the column but does not provide any data for it.
 
 .SS COLUMNS
-Note that topology elements (core, socket, etc.) use sequential unique ID
-starting from zero, but CPU logical numbers follow kernel where is no guarantee
-of the sequential numbering.
+Note that topology elements (core, socket, etc.) use a sequential unique ID
+starting from zero, but CPU logical numbers follow the kernel where there is
+no guarantee of sequential numbering.
 .TP
 .B CPU
 The logical CPU number of a CPU as used by the Linux kernel.
@@ -86,7 +86,7 @@ high, medium, or low.  This column contains data only if your hardware system
 and hypervisor support CPU polarization.
 .TP
 .B MMHZ
-Maximum megaherz value for the cpu.  Useful when lscpu is used as hardware
+Maximum megahertz value for the cpu.  Useful when lscpu is used as hardware
 inventory information gathering tool.  Notice that the megahertz value is
 dynamic, and driven by CPU governor depending on current resource need.
 .RE
@@ -105,7 +105,7 @@ Limit the output to offline CPUs.
 This option may only be specified together with option \fB-e\fR or \fB-p\fR.
 .TP
 .BR \-e , " \-\-extended" [=\fIlist\fP]
-Display the CPU information in human readable format.
+Display the CPU information in human-readable format.
 
 If the \fIlist\fP argument is omitted, all columns for which data is available
 are included in the command output.
-- 
1.7.0.4


Return-Path: util-linux-owner@vger.kernel.org
Received: from e39.co.us.ibm.com ([32.97.110.160]:34778 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbbKYUKq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Nov 2015 15:10:46 -0500
Received: from localhost
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <sukadev@linux.vnet.ibm.com>;
	Wed, 25 Nov 2015 13:10:45 -0700
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 4B7236E8045
	for <util-linux@vger.kernel.org>; Wed, 25 Nov 2015 14:58:52 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id tAPKAgva21102618
	for <util-linux@vger.kernel.org>; Wed, 25 Nov 2015 20:10:42 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id tAPKAfBD010714
	for <util-linux@vger.kernel.org>; Wed, 25 Nov 2015 15:10:42 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: kzak@redhat.com
Cc: nacc@linux.vnet.ibm.com, util-linux@vger.kernel.org
Subject: [PATCH v2 1/1] lscpu: Print physical cpu information
Date: Wed, 25 Nov 2015 12:10:39 -0800
Message-Id: <1448482240-31011-1-git-send-email-sukadev@linux.vnet.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

lscpu currently prints information for CPUs configured in the system.
In case of KVM or other virtualized guest operating systems, this
refers to the virtual system, and bears no relation to the physical
topology of the system.

It would be useful if lscpu could also display the physical topology
info when available:

	$ ./lscpu
	Architecture:          ppc64le
	Byte Order:            Little Endian
	CPU(s):                16
	On-line CPU(s) list:   0-15
	Thread(s) per core:    1
	Core(s) per socket:    1
	Socket(s):             16
	NUMA node(s):          1
	Model:                 IBM pSeries (emulated by qemu)
	Hypervisor vendor:     KVM
	Virtualization type:   para
	L1d cache:             64K
	L1i cache:             32K
	NUMA node0 CPU(s):     0-15
	Physical sockets:      2		<<< New
	Physical chips:        4		<<< New
	Physical cores/chip:   4		<<< New

For now, physical topology information is available on platforms that
support the following RTAS (Real time abstraction service) call provided
by librtas:

	rtas_get_sysparm(PROCESSOR_MODULE_INFO).

Currently this call is available to the PowerVM (pHYP) guests on PowerPC.
With a patch propoosed to PowerKVM, this RTAS call would also be available
to PowerKVM guests.

Based on input from Nishanth Aravamudan and Karel Zak.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---

Changelog[v2]
	[Karel Zak]. Drop the --physical option and display the info
		uncondidtionally, check the SYSTEM_LIVE flag before
		making rtas call; use BUFSIZ instead of hardcoding.
		Update lscpu man page.
---
 configure.ac            |  6 ++++++
 sys-utils/Makemodule.am |  2 +-
 sys-utils/lscpu.1       | 10 ++++++++-
 sys-utils/lscpu.c       | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6075f72..977402c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -386,6 +386,12 @@ AC_CHECK_FUNCS([clock_gettime], [],
 )
 AC_SUBST([REALTIME_LIBS])
 
+AC_CHECK_LIB([rtas], [rtas_get_sysparm], [
+	RTAS_LIBS="-lrtas"
+	AC_DEFINE_UNQUOTED([HAVE_LIBRTAS], [1], [Define if librtas exists]), [],
+])
+AC_SUBST([RTAS_LIBS])
+
 have_timer="no"
 AC_CHECK_FUNCS([timer_createx],
 	[have_time="yes"],
diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 8f65eb7..6c8c885 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -315,7 +315,7 @@ lscpu_SOURCES = \
 	sys-utils/lscpu.c \
 	sys-utils/lscpu.h \
 	sys-utils/lscpu-dmi.c
-lscpu_LDADD = $(LDADD) libcommon.la libsmartcols.la
+lscpu_LDADD = $(LDADD) libcommon.la libsmartcols.la $(RTAS_LIBS)
 lscpu_CFLAGS = $(AM_CFLAGS) -I$(ul_libsmartcols_incdir)
 dist_man_MANS += sys-utils/lscpu.1
 endif
diff --git a/sys-utils/lscpu.1 b/sys-utils/lscpu.1
index 5502da3..26487d2 100644
--- a/sys-utils/lscpu.1
+++ b/sys-utils/lscpu.1
@@ -9,13 +9,21 @@ lscpu \- display information about the CPU architecture
 .BR \-h | \-V
 .SH DESCRIPTION
 .B lscpu
-gathers CPU architecture information from sysfs and /proc/cpuinfo.  The
+gathers CPU architecture information from sysfs, /proc/cpuinfo and any
+applicable architecture-specific libraries (e.g. librtas on Powerpc). The
 command output can be optimized for parsing or for easy readability by humans.
 The information includes, for example, the number of CPUs, threads, cores,
 sockets, and Non-Uniform Memory Access (NUMA) nodes.  There is also information
 about the CPU caches and cache sharing, family, model, bogoMIPS, byte order,
 and stepping.
 
+In virtualized environments, the CPU architecture information displayed
+reflects the configuration of the guest operating system which is
+typically different from the physical (host) system. On architectures that
+support retreiving physical topology information,
+.B lscpu
+also displays the number of physical sockets, chips, cores in the host system.
+
 Options that result in an output table have a \fIlist\fP argument.  Use this
 argument to customize the command output.  Specify a comma-separated list of
 column labels to limit the output table to only the specified columns, arranged
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 47f690d..d555022 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -52,6 +52,10 @@
 # endif
 #endif
 
+#if defined(HAVE_LIBRTAS)
+#include <librtas.h>
+#endif
+
 #include <libsmartcols.h>
 
 #include "cpuset.h"
@@ -242,6 +246,9 @@ struct lscpu_desc {
 	int		*polarization;	/* cpu polarization */
 	int		*addresses;	/* physical cpu addresses */
 	int		*configured;	/* cpu configured */
+	int		physsockets;	/* Physical sockets (modules) */
+	int		physchips;	/* Physical chips */
+	int		physcoresperchip;	/* Physical cores per chip */
 };
 
 enum {
@@ -400,6 +407,45 @@ init_mode(struct lscpu_modifier *mod)
 	return m;
 }
 
+#if defined(HAVE_LIBRTAS)
+#define PROCESSOR_MODULE_INFO	43
+static int strbe16toh(const char *buf, int offset)
+{
+	return (buf[offset] << 8) + buf[offset+1];
+}
+
+static void read_physical_info_powerpc(struct lscpu_desc *desc)
+{
+	char buf[BUFSIZ];
+	int rc, len, ntypes;
+
+	desc->physsockets = desc->physchips = desc->physcoresperchip = 0;
+
+	rc = rtas_get_sysparm(PROCESSOR_MODULE_INFO, sizeof(buf), buf);
+	if (rc < 0)
+		return;
+
+	len = strbe16toh(buf, 0);
+	if (len < 8)
+		return;
+
+	ntypes = strbe16toh(buf, 2);
+
+	assert(ntypes <= 1);
+	if (!ntypes)
+		return;
+
+	desc->physsockets = strbe16toh(buf, 4);
+	desc->physchips = strbe16toh(buf, 6);
+	desc->physcoresperchip = strbe16toh(buf, 8);
+}
+#else
+static void read_physical_info_powerpc(
+		struct lscpu_desc *desc __attribute__((__unused__)))
+{
+}
+#endif
+
 static void
 read_basicinfo(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 {
@@ -506,6 +552,9 @@ read_basicinfo(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		desc->dispatching = path_read_s32(_PATH_SYS_CPU "/dispatching");
 	else
 		desc->dispatching = -1;
+
+	if (mod->system == SYSTEM_LIVE)
+		read_physical_info_powerpc(desc);
 }
 
 static int
@@ -1636,6 +1685,12 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 
 	if (desc->flags)
 		print_s(_("Flags:"), desc->flags);
+
+	if (desc->physsockets) {
+		print_n(_("Physical sockets:"), desc->physsockets);
+		print_n(_("Physical chips:"), desc->physchips);
+		print_n(_("Physical cores/chip:"), desc->physcoresperchip);
+	}
 }
 
 static void __attribute__((__noreturn__)) usage(FILE *out)
-- 
2.5.3


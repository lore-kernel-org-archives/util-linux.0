Return-Path: sukadev@linux.vnet.ibm.com
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: kzak@redhat.com
Cc: nacc@linux.vnet.ibm.com, util-linux@vger.kernel.org
Subject: [RFC][PATCH 1/1] lscpu: Print physical cpu information
Date: Tue, 24 Nov 2015 13:58:05 -0800
Message-Id: <1448402285-15621-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-ID: <util-linux.vger.kernel.org>

lscpu currently prints information for CPUs configured in the system.
In case of KVM or other virtualized guest operating systems, this
refers to the virtual system and bears no relation to the physical
topology of the system.

It would be useful if lscpu could optionally display the physical
topology info when available. An use case for this is the distro
licensing where the billing is based on the physical topology.
As Nishanth Aravamudan pointed out:

	I can make a KVM guest with 100 sockets, but I definitely
	shouldn't be billed for 100 sockets worth of RH seats, if
	the physical system only has 2 sockets.

This patch proposes adding a --physical option to lscpu, which will
retrieve/display the physical topology information.

	./lscpu --physical
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

For now --physical option works on platforms that support the following
call, provided by librtas:

	rtas_get_sysparm(PROCESSOR_MODULE_INFO).

Currently this RTAS (Real time abstraction service) call is available to
the PowerVM (pHYP) guests on PowerPC. With a patch propoosed to PowerKVM,
this RTAS call would also be available to PowerKVM guests.

Based on input from Nishanth Aravamudan and Karel Zak.

Appreciate comments on the proposal including following:

	- Should we instead display the physical information unconditionally?
	  Maybe add '--system' or '--no-physical' to suppress the physical
	  topology info?

	- Should we ignore (as this patch does) or fail if '--physical'
	  is specified on yet unsupported architectures?

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 configure.ac            |  6 +++++
 sys-utils/Makemodule.am |  2 +-
 sys-utils/lscpu.c       | 67 +++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 72 insertions(+), 3 deletions(-)

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
index 8f65eb7..6516de2 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -315,7 +315,7 @@ lscpu_SOURCES = \
 	sys-utils/lscpu.c \
 	sys-utils/lscpu.h \
 	sys-utils/lscpu-dmi.c
-lscpu_LDADD = $(LDADD) libcommon.la libsmartcols.la
+lscpu_LDADD = $(LDADD) libcommon.la libsmartcols.la	$(RTAS_LIBS)
 lscpu_CFLAGS = $(AM_CFLAGS) -I$(ul_libsmartcols_incdir)
 dist_man_MANS += sys-utils/lscpu.1
 endif
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 47f690d..106c8d1 100644
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
@@ -261,7 +268,8 @@ struct lscpu_modifier {
 	unsigned int	hex:1,		/* print CPU masks rather than CPU lists */
 			compat:1,	/* use backwardly compatible format */
 			online:1,	/* print online CPUs */
-			offline:1;	/* print offline CPUs */
+			offline:1,	/* print offline CPUs */
+			physical:1;	/* Print physical system info */
 };
 
 static int maxcpus;		/* size in bits of kernel cpu mask */
@@ -400,6 +408,47 @@ init_mode(struct lscpu_modifier *mod)
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
+	char buf[4096];
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
+
+	return;
+}
+#else
+static void read_physical_info_powerpc(struct lscpu_desc *desc __attribute__((__unused__)))
+{
+	return;
+}
+#endif
+
 static void
 read_basicinfo(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 {
@@ -506,6 +555,9 @@ read_basicinfo(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		desc->dispatching = path_read_s32(_PATH_SYS_CPU "/dispatching");
 	else
 		desc->dispatching = -1;
+
+	if (mod->physical)
+		read_physical_info_powerpc(desc);
 }
 
 static int
@@ -1636,6 +1688,12 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 
 	if (desc->flags)
 		print_s(_("Flags:"), desc->flags);
+
+	if (mod->physical && desc->physsockets) {
+		print_n(_("Physical sockets:"), desc->physsockets);
+		print_n(_("Physical chips:"), desc->physchips);
+		print_n(_("Physical cores/chip:"), desc->physcoresperchip);
+	}
 }
 
 static void __attribute__((__noreturn__)) usage(FILE *out)
@@ -1654,6 +1712,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -c, --offline           print offline CPUs only\n"), out);
 	fputs(_(" -e, --extended[=<list>] print out an extended readable format\n"), out);
 	fputs(_(" -p, --parse[=<list>]    print out a parsable format\n"), out);
+	fputs(_(" -P, --physical          print physical system information\n"), out);
 	fputs(_(" -s, --sysroot <dir>     use specified directory as system root\n"), out);
 	fputs(_(" -x, --hex               print hexadecimal masks rather than lists of CPUs\n"), out);
 	fputs(USAGE_SEPARATOR, out);
@@ -1685,6 +1744,7 @@ int main(int argc, char *argv[])
 		{ "help",	no_argument,       0, 'h' },
 		{ "extended",	optional_argument, 0, 'e' },
 		{ "parse",	optional_argument, 0, 'p' },
+		{ "physical",	no_argument, 0, 'P' },
 		{ "sysroot",	required_argument, 0, 's' },
 		{ "hex",	no_argument,	   0, 'x' },
 		{ "version",	no_argument,	   0, 'V' },
@@ -1703,7 +1763,7 @@ int main(int argc, char *argv[])
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((c = getopt_long(argc, argv, "abce::hp::s:xV", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "abce::hPp::s:xV", longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
 
@@ -1722,6 +1782,9 @@ int main(int argc, char *argv[])
 			break;
 		case 'h':
 			usage(stdout);
+		case 'P':
+			mod->physical = 1;
+			break;
 		case 'p':
 		case 'e':
 			if (optarg) {
-- 
2.5.3

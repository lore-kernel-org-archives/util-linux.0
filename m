Return-Path: heiko.carstens@de.ibm.com
Message-Id: <20110810083824.087008662@de.ibm.com>
Date: Wed, 10 Aug 2011 10:36:50 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 5/8] [PATCH] lscpu: use hypervisor generated topology information
References: <20110810083645.135814950@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The readable output prints also informations like cores per socket etc.
On newer kernel versions on s390 this information is available via
/proc/sysinfo. However it does not contain the layout of the guest but
the layout of the real machine.
Nevertheless this is better than random guessing with completely broken
numbers like we have it now on s390. If the information is not available
we fall back to old mechanism with more or less random numbers.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.c |   33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -1007,13 +1007,38 @@ print_readable(struct lscpu_desc *desc,
 	}
 
 	if (desc->nsockets) {
+		int cores_per_socket, sockets_per_book, books;
+
+		cores_per_socket = sockets_per_book = books = 0;
+		/* s390 detects its cpu topology via /proc/sysinfo, if present.
+		 * Using simply the cpu topology masks in sysfs will not give
+		 * usable results since everything is virtualized. E.g.
+		 * virtual core 0 may have only 1 cpu, but virtual core 2 may
+		 * five cpus.
+		 * If the cpu topology is not exported (e.g. 2nd level guest)
+		 * fall back to old calculation scheme.
+		 */
+		if (path_exist(_PATH_PROC_SYSINFO)) {
+			FILE *fd = path_fopen("r", 0, _PATH_PROC_SYSINFO);
+			char buf[BUFSIZ];
+			int t0, t1, t2;
+
+			while (fgets(buf, sizeof(buf), fd) != NULL) {
+				if (sscanf(buf, "CPU Topology SW:%d%d%d%d%d%d",
+					   &t0, &t1, &t2, &books, &sockets_per_book,
+					   &cores_per_socket) == 6)
+					break;
+			}
+		}
 		print_n(_("Thread(s) per core:"), desc->nthreads / desc->ncores);
-		print_n(_("Core(s) per socket:"), desc->ncores / desc->nsockets);
+		print_n(_("Core(s) per socket:"),
+			cores_per_socket ?: desc->ncores / desc->nsockets);
 		if (desc->nbooks) {
-			print_n(_("Socket(s) per book:"), desc->nsockets / desc->nbooks);
-			print_n(_("Book(s):"), desc->nbooks);
+			print_n(_("Socket(s) per book:"),
+				sockets_per_book ?: desc->nsockets / desc->nbooks);
+			print_n(_("Book(s):"), books ?: desc->nbooks);
 		} else {
-			print_n(_("Socket(s):"), desc->nsockets);
+			print_n(_("Socket(s):"), sockets_per_book ?: desc->nsockets);
 		}
 	}
 	if (desc->nnodes)

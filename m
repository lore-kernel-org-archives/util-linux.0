Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:56703 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933419AbdCaRyp (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 31 Mar 2017 13:54:45 -0400
Received: from adsiz.fritz.box ([178.25.190.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LoKHN-1cELDm06Qr-00gDki for
 <util-linux@vger.kernel.org>; Fri, 31 Mar 2017 19:54:43 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH] icps: make shmall overflow a bit less worse
Date: Fri, 31 Mar 2017 19:54:42 +0200
Message-Id: <20170331175442.30459-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Still no large integer support but on overflow we print now
the largest possible value, maybe even the largest one which
makes sense at all.

So on x86_64 systems we'll see now:
$ echo "4503599627370496" > /proc/sys/kernel/shmall
$ ipcs -m -l | grep "max total"
max total shared memory (kbytes) = 18014398509481980

rather than this:
$ ipcs -m -l | grep "max total"
max total shared memory (kbytes) = 0

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/ipcs.c           | 10 ++++++++--
 tests/ts/ipcs/functions.sh |  6 ++++++
 tests/ts/ipcs/limits2      |  6 ------
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index 4f3d23d..64f0aec 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -198,6 +198,7 @@ static void do_shm (char format, int unit)
 	case LIMITS:
 	{
 		struct ipc_limits lim;
+		uint64_t tmp, pgsz = getpagesize();
 
 		if (ipc_shm_get_limits(&lim)) {
 			printf (_("unable to fetch shared memory limits\n"));
@@ -207,9 +208,14 @@ static void do_shm (char format, int unit)
 		printf (_("max number of segments = %ju\n"), lim.shmmni);
 		ipc_print_size(unit == IPC_UNIT_DEFAULT ? IPC_UNIT_KB : unit,
 			       _("max seg size"), lim.shmmax, "\n", 0);
+
+		tmp = (uint64_t) lim.shmall * pgsz;
+		/* overflow handling, at least we don't print ridiculus small values */
+		if (lim.shmall != 0 && tmp / lim.shmall != pgsz) {
+			tmp = UINT64_MAX - (UINT64_MAX % pgsz);
+		}
 		ipc_print_size(unit == IPC_UNIT_DEFAULT ? IPC_UNIT_KB : unit,
-			       _("max total shared memory"),
-			       (uint64_t) lim.shmall * getpagesize(), "\n", 0);
+			       _("max total shared memory"), tmp, "\n", 0);
 		ipc_print_size(unit == IPC_UNIT_DEFAULT ? IPC_UNIT_BYTES : unit,
 			       _("min seg size"), lim.shmmin, "\n", 0);
 		return;
diff --git a/tests/ts/ipcs/functions.sh b/tests/ts/ipcs/functions.sh
index a9cf228..586ce42 100644
--- a/tests/ts/ipcs/functions.sh
+++ b/tests/ts/ipcs/functions.sh
@@ -78,6 +78,12 @@ function ipcs_limits_check {
 		#echo "IPCS-CMD:   ${IPCS_CMD[$i]}"
 		#echo
 
+		# overflow is handled differently because we don't have large
+		# int math, see https://github.com/karelzak/util-linux/issues/51
+		if [ $(bc <<<"$a >= 2^64/1024") -eq 1 ]; then
+			a=$(bc <<<"(2^64 - $PAGE_SIZE)/1024")
+		fi
+
 		if [ x"$a" == x"$b" ]; then
 			echo " OK"
 		else
diff --git a/tests/ts/ipcs/limits2 b/tests/ts/ipcs/limits2
index 4e96ce6..62a4f5b 100755
--- a/tests/ts/ipcs/limits2
+++ b/tests/ts/ipcs/limits2
@@ -27,12 +27,6 @@ ts_check_prog "bc"
 
 . $TS_SELF/functions.sh
 
-# TODO https://github.com/karelzak/util-linux/issues/51
-SHMALL=$(</proc/sys/kernel/shmall)
-if [ $(bc <<<"(2^64 / $PAGE_SIZE) <= $SHMALL") -eq 1 ]; then
-	TS_KNOWN_FAIL="yes"
-fi
-
 ts_log "check for difference between kernel and IPC"
 ipcs_limits_check >> $TS_OUTPUT
 
-- 
2.10.2


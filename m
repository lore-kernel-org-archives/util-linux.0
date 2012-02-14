Return-Path: dave@gnu.org
Subject: [PATCH 2/4] sys-utils: fix typos
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 14 Feb 2012 12:13:14 +0100
Message-ID: <1329217994.3269.6.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 sys-utils/cytune.c |    2 +-
 sys-utils/ipcrm.c  |    4 ++--
 sys-utils/swapon.c |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sys-utils/cytune.c b/sys-utils/cytune.c
index 8876fb3..96d2d64 100644
--- a/sys-utils/cytune.c
+++ b/sys-utils/cytune.c
@@ -137,7 +137,7 @@ static void summary(int sig)
 	}
 	cc = &cmon[cmon_index];
 	if (cc->threshold_value > 0 && sig != -1) {
-		warnx(_("File %s, For threshold value %lu and timrout value %lu, Maximum characters in fifo were %d,\n"
+		warnx(_("File %s, For threshold value %lu and timeout value %lu, Maximum characters in fifo were %d,\n"
 			"and the maximum transfer rate in characters/second was %f"),
 		      argv[cmon_index + local_optind], cc->threshold_value,
 		      cc->timeout_value, cc->maxmax, cc->maxtran);
diff --git a/sys-utils/ipcrm.c b/sys-utils/ipcrm.c
index 6f74107..c091de3 100644
--- a/sys-utils/ipcrm.c
+++ b/sys-utils/ipcrm.c
@@ -53,8 +53,8 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fputs(_(" -M, --shmem-key <key>      remove shared memory segment by key\n"), out);
 	fputs(_(" -q, --queue-id <id>        remove message queue by id\n"), out);
 	fputs(_(" -Q, --queue-key <key>      remove message queue by key\n"), out);
-	fputs(_(" -s, --semaphore-id <id>    remove semaprhore by id\n"), out);
-	fputs(_(" -S, --semaphore-key <key>  remove semaprhore by key\n"), out);
+	fputs(_(" -s, --semaphore-id <id>    remove semaphore by id\n"), out);
+	fputs(_(" -S, --semaphore-key <key>  remove semaphore by key\n"), out);
 	fputs(_(" -a, --all[=<shm|msg|sem>]  remove all\n"), out);
 	fputs(_(" -v, --verbose              explain what is being done\n"), out);
 	fprintf(out, USAGE_SEPARATOR);
diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index 7b45d37..f17fad6 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -120,7 +120,7 @@ swapon_usage(FILE *out, int n) {
 		" -e, --ifexists         silently skip devices that do not exis\n"
 		" -f, --fixpgsz          reinitialize the swap space if necessary\n"
 		" -h, --help             display help and exit\n"
-		" -p, --priority <prio>  specify the priority of the swap device.\n"
+		" -p, --priority <prio>  specify the priority of the swap device\n"
 		" -s, --summary          display summary about used swap devices and exit\n"
 		" -v, --verbose          verbose mode\n"
 		" -V, --version          display version and exit\n"), out);
-- 
1.7.4.1

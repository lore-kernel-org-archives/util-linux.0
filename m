Return-Path: dave@gnu.org
Date: Mon, 24 Oct 2011 12:30:58 +0200
From: Davidlohr Bueso <dave@gnu.org>
Subject: [PATCH] prlimit: add a units column
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Message-id: <1319452258.2170.7.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 sys-utils/prlimit.c |   40 ++++++++++++++++++++++++----------------
 1 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index 74c7fc9..49f8f6e 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -55,27 +55,28 @@ enum {
 struct prlimit_desc {
 	const char *name;
 	const char *help;
+	const char *unit;
 	int resource;
 };
 
 static struct prlimit_desc prlimit_desc[] =
 {
-	[AS]         = { "AS",         N_("address space limit"),                RLIMIT_AS },
-	[CORE]       = { "CORE",       N_("max core file size"),                 RLIMIT_CORE },
-	[CPU]        = { "CPU",        N_("CPU time in secs"),                   RLIMIT_CPU },
-	[DATA]       = { "DATA",       N_("max data size"),                      RLIMIT_DATA },
-	[FSIZE]      = { "FSIZE",      N_("max file size"),                      RLIMIT_FSIZE },
-	[LOCKS]      = { "LOCKS",      N_("max amount of file locks held"),      RLIMIT_LOCKS },
-	[MEMLOCK]    = { "MEMLOCK",    N_("max locked-in-memory address space"), RLIMIT_MEMLOCK },
-	[MSGQUEUE]   = { "MSGQUEUE",   N_("max bytes in POSIX mqueues"),         RLIMIT_MSGQUEUE },
-	[NICE]       = { "NICE",       N_("max nice prio allowed to raise"),     RLIMIT_NICE },
-	[NOFILE]     = { "NOFILE",     N_("max amount of open files"),           RLIMIT_NOFILE },
-	[NPROC]      = { "NPROC",      N_("max number of processes"),            RLIMIT_NPROC },
-	[RSS]        = { "RSS",        N_("max resident set size"),              RLIMIT_RSS },
-	[RTPRIO]     = { "RTPRIO",     N_("max real-time priority"),             RLIMIT_RTPRIO },
-	[RTTIME]     = { "RTTIME",     N_("timeout for real-time tasks"),        RLIMIT_RTTIME },
-	[SIGPENDING] = { "SIGPENDING", N_("max amount of pending signals"),      RLIMIT_SIGPENDING },
-	[STACK]      = { "STACK",      N_("max stack size"),                     RLIMIT_STACK }
+	[AS]         = { "AS",         N_("address space limit"),                "bytes",     RLIMIT_AS },
+	[CORE]       = { "CORE",       N_("max core file size"),                 "blocks",    RLIMIT_CORE },
+	[CPU]        = { "CPU",        N_("CPU time"),                           "seconds",   RLIMIT_CPU },
+	[DATA]       = { "DATA",       N_("max data size"),                      "bytes",     RLIMIT_DATA },
+	[FSIZE]      = { "FSIZE",      N_("max file size"),                      "blocks",    RLIMIT_FSIZE },
+	[LOCKS]      = { "LOCKS",      N_("max amount of file locks held"),      NULL,        RLIMIT_LOCKS },
+	[MEMLOCK]    = { "MEMLOCK",    N_("max locked-in-memory address space"), "kbytes",    RLIMIT_MEMLOCK },
+	[MSGQUEUE]   = { "MSGQUEUE",   N_("max bytes in POSIX mqueues"),         "bytes",     RLIMIT_MSGQUEUE },
+	[NICE]       = { "NICE",       N_("max nice prio allowed to raise"),     NULL,        RLIMIT_NICE },
+	[NOFILE]     = { "NOFILE",     N_("max amount of open files"),           NULL,        RLIMIT_NOFILE },
+	[NPROC]      = { "NPROC",      N_("max number of processes"),            NULL,        RLIMIT_NPROC },
+	[RSS]        = { "RSS",        N_("max resident set size"),              "pages",     RLIMIT_RSS },
+	[RTPRIO]     = { "RTPRIO",     N_("max real-time priority"),             NULL,        RLIMIT_RTPRIO },
+	[RTTIME]     = { "RTTIME",     N_("timeout for real-time tasks"),        "microsecs", RLIMIT_RTTIME },
+	[SIGPENDING] = { "SIGPENDING", N_("max amount of pending signals"),      NULL,        RLIMIT_SIGPENDING },
+	[STACK]      = { "STACK",      N_("max stack size"),                     "kbytes",    RLIMIT_STACK }
 };
 
 struct prlimit {
@@ -91,6 +92,7 @@ enum {
 	COL_RES,
 	COL_SOFT,
 	COL_HARD,
+	COL_UNITS,
 };
 
 /* column names */
@@ -107,6 +109,7 @@ struct colinfo infos[] = {
 	[COL_HELP]    = { "DESCRIPTION", 0.1,  TT_FL_TRUNC, N_("resource description")},
 	[COL_SOFT]    = { "SOFT",        0.1,  TT_FL_RIGHT, N_("soft limit")},
 	[COL_HARD]    = { "HARD",        1,    TT_FL_RIGHT, N_("hard limit (ceiling)")},
+	[COL_UNITS]   = { "UNITS",       0.1,    TT_FL_TRUNC, N_("units")},
 };
 
 #define NCOLS ARRAY_SIZE(infos)
@@ -217,6 +220,10 @@ static void add_tt_line(struct tt *tt, struct prlimit *l)
 				asprintf(&str, "%s", "unlimited") :
 				asprintf(&str, "%llu", (unsigned long long) l->rlim.rlim_max);
 			break;
+		case COL_UNITS:
+			rc =  l->desc->unit ? asprintf(&str, "%s", l->desc->unit) :
+			                      asprintf(&str, "------");
+			break;
 		default:
 			break;
 		}
@@ -557,6 +564,7 @@ int main(int argc, char **argv)
 		columns[ncolumns++] = COL_HELP;
 		columns[ncolumns++] = COL_SOFT;
 		columns[ncolumns++] = COL_HARD;
+		columns[ncolumns++] = COL_UNITS;
 	}
 
 	if (!n) {
-- 
1.7.7

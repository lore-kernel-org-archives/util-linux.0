Return-Path: heiko.carstens@de.ibm.com
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 5/6] lscpu: add --offline option
Date: Thu, 15 Sep 2011 08:52:33 +0200
Message-Id: <1316069554-20977-6-git-send-email-heiko.carstens@de.ibm.com>
In-Reply-To: <1316069554-20977-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1316069554-20977-1-git-send-email-heiko.carstens@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

Implement "--offline" option which only prints offline cpus. As a side effect
we can get rid of the internal "allcpus" flag, since if we want to print
informations for online and offline cpus we simply set both flags.

When reading sysfs attributes of cpus this is now done for all cpus, since
e.g. the topology informations of the online cpus may influence the
topology informations of the offline cpus. This mainly because online cpus
may contain masks which include offline cpus while offline cpus have a
missing topology directory.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.1 |    9 ++++++---
 sys-utils/lscpu.c |   34 ++++++++++++++++++++++------------
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/sys-utils/lscpu.1 b/sys-utils/lscpu.1
index b073a22..47c4c31 100644
--- a/sys-utils/lscpu.1
+++ b/sys-utils/lscpu.1
@@ -6,7 +6,7 @@
 lscpu \- display information on CPU architecture
 .SH SYNOPSIS
 .B lscpu
-.RB [ \-aehpxV ]
+.RB [ \-abcehpxV ]
 .RB [ \-s
 .IR directory ]
 .SH DESCRIPTION
@@ -28,10 +28,13 @@ the defined order.
 .SH OPTIONS
 .TP
 .BR \-a , " \-\-all"
-Include online and offline CPUs in output (default for -e)
+Include online and offline CPUs in output (default for -e).
 .TP
 .BR \-b , " \-\-online"
-Include only online CPUs in output (default for -p)
+Include only online CPUs in output (default for -p).
+.TP
+.BR \-c , " \-\-offline"
+Include only offline CPUs in output.
 .TP
 .BR \-e , " \-\-extended " \fI[=list]\fP
 Print CPU list out in human-readable format.
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 63377d1..31c8fa8 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -195,8 +195,8 @@ struct lscpu_modifier {
 	int		system;		/* SYSTEM_* */
 	unsigned int	hex:1,		/* print CPU masks rather than CPU lists */
 			compat:1,	/* use backwardly compatible format */
-			allcpus:1,	/* print all CPUs */
-			online:1;	/* print online CPUs only */
+			online:1,	/* print online CPUs */
+			offline:1;	/* print offline CPUs */
 };
 
 static int maxcpus;		/* size in bits of kernel cpu mask */
@@ -957,7 +957,9 @@ print_parsable(struct lscpu_desc *desc, int cols[], int ncols,
 	for (i = 0; i < desc->ncpus; i++) {
 		int c;
 
-		if (!mod->allcpus && desc->online && !is_cpu_online(desc, i))
+		if (!mod->offline && desc->online && !is_cpu_online(desc, i))
+			continue;
+		if (!mod->online && desc->online && is_cpu_online(desc, i))
 			continue;
 		for (c = 0; c < ncols; c++) {
 			if (mod->compat && cols[c] == COL_CACHE) {
@@ -1003,7 +1005,9 @@ print_readable(struct lscpu_desc *desc, int cols[], int ncols,
 		int c;
 		struct tt_line *line;
 
-		if (!mod->allcpus && desc->online && !is_cpu_online(desc, i))
+		if (!mod->offline && desc->online && !is_cpu_online(desc, i))
+			continue;
+		if (!mod->online && desc->online && is_cpu_online(desc, i))
 			continue;
 
 		line = tt_add_line(tt, NULL);
@@ -1187,6 +1191,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_("\nOptions:\n"), out);
 	fputs(_(" -a, --all               print online and offline CPUs (default for -e)\n"
 		" -b, --online            print online CPUs only (default for -p)\n"
+		" -c, --offline           print offline CPUs only\n"
 		" -e, --extended[=<list>] print out a extended readable format\n"
 		" -h, --help              print this help\n"
 		" -p, --parse[=<list>]    print out a parsable format\n"
@@ -1207,6 +1212,7 @@ int main(int argc, char *argv[])
 	static const struct option longopts[] = {
 		{ "all",        no_argument,       0, 'a' },
 		{ "online",     no_argument,       0, 'b' },
+		{ "offline",    no_argument,       0, 'c' },
 		{ "help",	no_argument,       0, 'h' },
 		{ "extended",	optional_argument, 0, 'e' },
 		{ "parse",	optional_argument, 0, 'p' },
@@ -1220,22 +1226,25 @@ int main(int argc, char *argv[])
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 
-	while ((c = getopt_long(argc, argv, "abe::hp::s:xV", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "abce::hp::s:xV", longopts, NULL)) != -1) {
 
 		if (mod->mode != OUTPUT_SUMMARY && strchr("ep", c))
 			errx(EXIT_FAILURE,
 			     _("extended and parsable formats are mutually exclusive"));
-		if ((mod->allcpus || mod->online) && strchr("ab", c))
+		if ((mod->online || mod->offline) && strchr("abc", c))
 			errx(EXIT_FAILURE,
-			     _("--all and --online options are mutually exclusive"));
+			     _("--all, --online and --offline options are mutually exclusive"));
 
 		switch (c) {
 		case 'a':
-			mod->allcpus = 1;
+			mod->online = mod->offline = 1;
 			break;
 		case 'b':
 			mod->online = 1;
 			break;
+		case 'c':
+			mod->offline = 1;
+			break;
 		case 'h':
 			usage(stdout);
 		case 'p':
@@ -1266,14 +1275,15 @@ int main(int argc, char *argv[])
 			usage(stderr);
 		}
 	}
-	if (mod->mode == OUTPUT_READABLE && !mod->online)
-		mod->allcpus = 1;
+	/* set default cpu display mode if none was specified */
+	if (!mod->online && !mod->offline) {
+		mod->online = 1;
+		mod->offline = mod->mode == OUTPUT_READABLE ? 1 : 0;
+	}
 
 	read_basicinfo(desc, mod);
 
 	for (i = 0; i < desc->ncpus; i++) {
-		if (desc->online && !is_cpu_online(desc, i) && !mod->allcpus)
-			continue;
 		read_topology(desc, i);
 		read_cache(desc, i);
 		read_polarization(desc, i);
-- 
1.7.5.4

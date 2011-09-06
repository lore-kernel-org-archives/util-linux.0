Return-Path: heiko.carstens@de.ibm.com
Message-Id: <20110906010200.408740997@de.ibm.com>
Date: Tue, 06 Sep 2011 02:53:00 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 09/11] [PATCH] lscpu: add --all option
References: <20110906005251.497675140@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

The parsable output includes only lines of online CPUs. To also include
lines for all offline CPUs the "--all" option can be specified.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.1 |    4 +++-
 sys-utils/lscpu.c |    7 ++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/sys-utils/lscpu.1 b/sys-utils/lscpu.1
index 3bf341b..7242a6b 100644
--- a/sys-utils/lscpu.1
+++ b/sys-utils/lscpu.1
@@ -6,7 +6,7 @@
 lscpu \- CPU architecture information helper
 .SH SYNOPSIS
 .B lscpu
-.RB [ \-ehpxV ]
+.RB [ \-aehpxV ]
 .RB [ \-s
 .IR directory ]
 .SH DESCRIPTION
@@ -27,6 +27,8 @@ the defined order.
 
 .SH OPTIONS
 .TP
+.BR \-a , " \-\-all"
+Include online and offline CPUs in output.
 .TP
 .BR \-e , " \-\-extended " \fI[=list]\fP
 Print CPU list out in human-readable format.
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 2e45b05..7923cc2 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -1293,6 +1293,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 		"  -p, --parse[=LIST] print out a parsable instead of a readable format\n"
 		"  -e, --table[=LIST] print out a readable format\n"
 		"  -s, --sysroot DIR  use directory DIR as system root\n"
+		"  -a, --all          print online and offline CPUs\n"
 		"  -x, --hex          print hexadecimal masks rather than lists of CPUs\n"
 		"  -V, --version      output version information and exit\n"));
 
@@ -1308,6 +1309,7 @@ int main(int argc, char *argv[])
 	int print_cpu_table = 0;
 
 	static const struct option longopts[] = {
+		{ "all",	no_argument,       0, 'a' },
 		{ "extended",	optional_argument, 0, 'e' },
 		{ "help",	no_argument,       0, 'h' },
 		{ "parse",	optional_argument, 0, 'p' },
@@ -1322,11 +1324,14 @@ int main(int argc, char *argv[])
 	textdomain(PACKAGE);
 
 	memset(mod, 0, sizeof(*mod));
-	while ((c = getopt_long(argc, argv, "e::hp::s:xV", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "ae::hp::s:xV", longopts, NULL)) != -1) {
 		if (print_cpu_table && strchr("ep", c))
 			errx(EXIT_FAILURE,
 			     _("extended and parsable are mutually exclusive"));
 		switch (c) {
+		case 'a':
+			mod->allcpus = 1;
+			break;
 		case 'h':
 			usage(stdout);
 		case 'e':
-- 
1.7.5.4

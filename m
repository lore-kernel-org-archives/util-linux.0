Return-Path: heiko.carstens@de.ibm.com
Message-Id: <20110906010158.126216533@de.ibm.com>
Date: Tue, 06 Sep 2011 02:52:56 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 05/11] [PATCH] lscpu: add --version option
References: <20110906005251.497675140@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

Add a --version option like most other tools have it.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.1 |    5 ++++-
 sys-utils/lscpu.c |   10 ++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/sys-utils/lscpu.1 b/sys-utils/lscpu.1
index 6840590..2dc31b7 100644
--- a/sys-utils/lscpu.1
+++ b/sys-utils/lscpu.1
@@ -6,7 +6,7 @@
 lscpu \- CPU architecture information helper
 .SH SYNOPSIS
 .B lscpu
-.RB [ \-hpx ]
+.RB [ \-hpxV ]
 .RB [ \-s
 .IR directory ]
 .SH DESCRIPTION
@@ -47,6 +47,9 @@ a snapshot from a different system.
 .BR \-x , " \-\-hex"
 Use hexadecimal masks for CPU sets (e.g. 0x3).  The default is to print the sets
 in list format (e.g. 0,1).
+.TP
+.BR \-V , " \-\-version"
+Output version information and exit.
 .SH BUGS
 The basic overview about CPU family, model, etc. is always based on the first
 CPU only.
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index d7c7028..841beae 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -1178,7 +1178,8 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 		"  -h, --help         print this help\n"
 		"  -p, --parse[=LIST] print out a parsable instead of a readable format\n"
 		"  -s, --sysroot DIR  use directory DIR as system root\n"
-		"  -x, --hex          print hexadecimal masks rather than lists of CPUs\n"));
+		"  -x, --hex          print hexadecimal masks rather than lists of CPUs\n"
+		"  -V, --version      output version information and exit\n"));
 
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
@@ -1195,6 +1196,7 @@ int main(int argc, char *argv[])
 		{ "parse",	optional_argument, 0, 'p' },
 		{ "sysroot",	required_argument, 0, 's' },
 		{ "hex",	no_argument,	   0, 'x' },
+		{ "version",	no_argument,	   0, 'V' },
 		{ NULL,		0, 0, 0 }
 	};
 
@@ -1202,7 +1204,7 @@ int main(int argc, char *argv[])
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 
-	while ((c = getopt_long(argc, argv, "hp::s:x", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "hp::s:xV", longopts, NULL)) != -1) {
 		switch (c) {
 		case 'h':
 			usage(stdout);
@@ -1233,6 +1235,10 @@ int main(int argc, char *argv[])
 		case 'x':
 			hex = 1;
 			break;
+		case 'V':
+			printf(_("%s from %s\n"), program_invocation_short_name,
+			       PACKAGE_STRING);
+			return EXIT_SUCCESS;
 		default:
 			usage(stderr);
 		}
-- 
1.7.5.4

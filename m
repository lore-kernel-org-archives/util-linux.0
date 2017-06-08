Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35288 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751652AbdFHTw1 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 8 Jun 2017 15:52:27 -0400
Received: by mail-wr0-f194.google.com with SMTP id g76so4710833wrd.2
        for <util-linux@vger.kernel.org>; Thu, 08 Jun 2017 12:52:26 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 05/11] uuidgen: add --date option to display time when uuid was generated
Date: Thu,  8 Jun 2017 20:52:09 +0100
Message-Id: <20170608195215.1702-6-kerolasa@iki.fi>
In-Reply-To: <20170608195215.1702-1-kerolasa@iki.fi>
References: <20170608195215.1702-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The uuidgen has always had option to use time as a uuid value.  To common
users these timestamps have been difficult to convert to readable format, so
add an option to do that.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/uuidgen     |  5 ++++-
 misc-utils/Makemodule.am    |  2 +-
 misc-utils/uuidgen.1        |  8 ++++++++
 misc-utils/uuidgen.c        | 41 +++++++++++++++++++++++++++++++++++++++--
 tests/expected/uuid/uuidgen |  6 ++++++
 tests/ts/uuid/uuidgen       | 10 ++++++++++
 6 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/bash-completion/uuidgen b/bash-completion/uuidgen
index 42d95d42f..729e9621d 100644
--- a/bash-completion/uuidgen
+++ b/bash-completion/uuidgen
@@ -8,10 +8,13 @@ _uuidgen_module()
 		'-h'|'--help'|'-V'|'--version')
 			return 0
 			;;
+		'--date')
+			COMPREPLY=( $(compgen -W "uuid" -- $cur) )
+			;;
 	esac
 	case $cur in
 		-*)
-			OPTS="--random --time --version --help"
+			OPTS="--random --time --date --version --help"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
index f28261c8b..38f799ddd 100644
--- a/misc-utils/Makemodule.am
+++ b/misc-utils/Makemodule.am
@@ -84,7 +84,7 @@ if BUILD_UUIDGEN
 usrbin_exec_PROGRAMS += uuidgen
 dist_man_MANS += misc-utils/uuidgen.1
 uuidgen_SOURCES = misc-utils/uuidgen.c
-uuidgen_LDADD = $(LDADD) libuuid.la
+uuidgen_LDADD = $(LDADD) libuuid.la libcommon.la
 uuidgen_CFLAGS = $(AM_CFLAGS) -I$(ul_libuuid_incdir)
 endif
 
diff --git a/misc-utils/uuidgen.1 b/misc-utils/uuidgen.1
index 56c2bc7bd..a67e22c08 100644
--- a/misc-utils/uuidgen.1
+++ b/misc-utils/uuidgen.1
@@ -42,6 +42,14 @@ quality random number generator, such as
 Generate a time-based UUID.  This method creates a UUID based on the system
 clock plus the system's ethernet hardware address, if present.
 .TP
+.BI "\-\-date " uuid
+Display when a time-based UUID was generated.  If there are additional
+command-line arguments they are printed as well.
+.PP
+Notice that there is no way to know by looking an UUID if it is time or
+random based.  Both types are converted, and random-based UUIDs tend to have
+values mostly in future, but sometimes in past.
+.TP
 .BR \-h , " \-\-help"
 Display help text and exit.
 .TP
diff --git a/misc-utils/uuidgen.c b/misc-utils/uuidgen.c
index 4c1d47d5e..5a43af5c3 100644
--- a/misc-utils/uuidgen.c
+++ b/misc-utils/uuidgen.c
@@ -17,6 +17,7 @@
 #include "nls.h"
 #include "c.h"
 #include "closestream.h"
+#include "timeutils.h"
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
@@ -28,8 +29,9 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fputs(_("Create a new UUID value.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -r, --random     generate random-based uuid\n"), out);
-	fputs(_(" -t, --time       generate time-based uuid\n"), out);
+	fputs(_(" -r, --random       generate random-based uuid\n"), out);
+	fputs(_(" -t, --time         generate time-based uuid\n"), out);
+	fputs(_("     --date <uuid>  display when uuid was generated\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
@@ -37,6 +39,23 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
+static int print_uuid_date(char *date)
+{
+	uuid_t uuid;
+	struct timeval tv;
+	char buf[ISO_8601_BUFSIZ];
+
+	if (uuid_parse(date, uuid)) {
+		printf(_("invalid uuid: %s\n"), date);
+		return 1;
+	}
+	uuid_time(uuid, &tv);
+	strtimeval_iso(&tv, ISO_8601_DATE | ISO_8601_TIME | ISO_8601_COMMAUSEC |
+		       ISO_8601_TIMEZONE | ISO_8601_SPACE, buf, sizeof(buf));
+	printf("%s\n", buf);
+	return 0;
+}
+
 int
 main (int argc, char *argv[])
 {
@@ -44,10 +63,16 @@ main (int argc, char *argv[])
 	int    do_type = 0;
 	char   str[37];
 	uuid_t uu;
+	int    print_dates = 0;
+	int    valid_uuids = 0;
 
+	enum {
+		OPT_DATE = CHAR_MAX + 1,
+	};
 	static const struct option longopts[] = {
 		{"random", no_argument, NULL, 'r'},
 		{"time", no_argument, NULL, 't'},
+		{"date", required_argument, NULL, OPT_DATE},
 		{"version", no_argument, NULL, 'V'},
 		{"help", no_argument, NULL, 'h'},
 		{NULL, 0, NULL, 0}
@@ -60,6 +85,10 @@ main (int argc, char *argv[])
 
 	while ((c = getopt_long(argc, argv, "rtVh", longopts, NULL)) != -1)
 		switch (c) {
+		case OPT_DATE:
+			valid_uuids |= print_uuid_date(optarg);
+			print_dates = 1;
+			break;
 		case 't':
 			do_type = UUID_TYPE_DCE_TIME;
 			break;
@@ -75,6 +104,14 @@ main (int argc, char *argv[])
 			errtryhelp(EXIT_FAILURE);
 		}
 
+	if (print_dates) {
+		for (; optind < argc; optind++)
+			valid_uuids |= print_uuid_date(argv[optind]);
+		if (valid_uuids)
+			return EXIT_FAILURE;
+		return EXIT_SUCCESS;
+	}
+
 	switch (do_type) {
 	case UUID_TYPE_DCE_TIME:
 		uuid_generate_time(uu);
diff --git a/tests/expected/uuid/uuidgen b/tests/expected/uuid/uuidgen
index b0d1d98e7..00ea3f2d2 100644
--- a/tests/expected/uuid/uuidgen
+++ b/tests/expected/uuid/uuidgen
@@ -6,3 +6,9 @@ option: --random
 return values: 0 and 0
 option: --time
 return values: 0 and 0
+test --date
+2017-05-21 17:25:32,471528+0000
+2017-05-21 17:50:52,171166+0000
+invalid uuid: 080fc42c-3e4e-11e7-8ba8-00037f50000
+invalid uuid: 080fc42c-3e4e-11e7-8ba8-00037f50000g
+return value: 1
diff --git a/tests/ts/uuid/uuidgen b/tests/ts/uuid/uuidgen
index 6aa1b5b21..1514afc5c 100755
--- a/tests/ts/uuid/uuidgen
+++ b/tests/ts/uuid/uuidgen
@@ -40,6 +40,16 @@ test_flag -t
 test_flag --random
 test_flag --time
 
+export TZ=GMT
+echo "test --date" >> $TS_OUTPUT
+$TS_CMD_UUIDGEN --date \
+	7e400110-3e4a-11e7-8af1-00037f500001 \
+	080fc42c-3e4e-11e7-8ba8-00037f500001 \
+	080fc42c-3e4e-11e7-8ba8-00037f50000 \
+	080fc42c-3e4e-11e7-8ba8-00037f50000g \
+	>> "$TS_OUTPUT" 2>&1
+echo "return value: $?" >> $TS_OUTPUT
+
 rm -f "$OUTPUT_FILE"
 
 ts_finalize
-- 
2.13.1


Return-Path: elseifthen@gmx.com
Subject: [PATCH 2/2] hwclock: make debug implicit for test mode.
To: Karel Zak <kzak@redhat.com>
References: <a996a4b2-89f5-eb63-a0cb-499830bce2e6@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <719020ca-427f-971d-31b1-14f4fda54f00@gmx.com>
Date: Thu, 21 Sep 2017 16:10:51 -0400
MIME-Version: 1.0
In-Reply-To: <a996a4b2-89f5-eb63-a0cb-499830bce2e6@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Calling --test without --debug is not useful, so
make it implicit.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.8.in | 8 ++++----
 sys-utils/hwclock.c    | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index a3cbc015e..d88feb07b 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -372,10 +372,10 @@ must be specified when using this option.
 .
 .TP
 .B \-\-test
-Do not actually change anything on the system, i.e., the Clocks or
-adjtime file.  This is useful, especially in conjunction with
-.BR \%\-\-debug ,
-in learning about the internal operations of hwclock.
+Do not actually change anything on the system, that is, the Clocks or
+.I @ADJTIME_PATH@
+.RB ( \%\-\-debug
+is implicit with this option).
 .
 .TP
 .B \-\-update\-drift
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 6a23bf2b0..36b6204b0 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1083,7 +1083,7 @@ usage(void)
 	       "     --noadjfile      do not use %1$s\n"), _PATH_ADJTIME);
 	printf(_(
 	       "     --adjfile <file> use an alternate file to %1$s\n"), _PATH_ADJTIME);
-	puts(_("     --test           dry run; use -D to view what would have happened"));
+	puts(_("     --test           dry run; implies --debug"));
 	puts(_(" -D, --debug          display more details"));
 	fputs(USAGE_SEPARATOR, stdout);
 	printf(USAGE_HELP_OPTIONS(22));
@@ -1251,6 +1251,7 @@ int main(int argc, char **argv)
 			break;
 		case OPT_TEST:
 			ctl.testing = 1;	/* --test */
+			ctl.debug++;
 			break;
 		case OPT_DATE:
 			ctl.date_opt = optarg;	/* --date */

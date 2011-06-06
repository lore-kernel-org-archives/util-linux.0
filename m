Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ew0-f46.google.com ([209.85.215.46]:63725 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712Ab1FFTHa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 6 Jun 2011 15:07:30 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1471009ewy.19
        for <util-linux@vger.kernel.org>; Mon, 06 Jun 2011 12:07:29 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/6] sfdisk: help screen format
Date: Mon,  6 Jun 2011 21:07:15 +0200
Message-Id: <1307387239-9022-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1307387239-9022-1-git-send-email-kerolasa@iki.fi>
References: <1307387239-9022-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Readability improvement by making the help screen to look like
majority of command line utilities.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 fdisk/sfdisk.c |   93 +++++++++++++++++++++++++++++---------------------------
 1 files changed, 48 insertions(+), 45 deletions(-)

diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
index 8d8ccea..1b35f66 100644
--- a/fdisk/sfdisk.c
+++ b/fdisk/sfdisk.c
@@ -2308,47 +2308,47 @@ read_input(char *dev, int interactive, struct disk_desc *z) {
 /*
  *  G. The command line
  */
+static void usage(FILE * out)
+{
 
-static void version(void) {
-    printf("sfdisk (%s)\n", PACKAGE_STRING);
+	fprintf(out, _("\nUsage:\n"
+		       "  %s [options] device [...]\n"),
+		program_invocation_short_name);
+	fprintf(out, _("Device is something like /dev/hda or /dev/sda\n"));
+
+	fprintf(out, _("\nOptions:\n"
+		       "  -s, --show-size         list size of a partition\n"
+		       "  -c, --id                change or print partition Id\n"
+		       "  -l, --list              list partitions of each device\n"
+		       "  -d, --dump              idem, but in a format suitable for later input\n"
+		       "  -i, --increment         number cylinders etc. from 1 instead of from 0\n"
+		       "  -u, --unit=[SBCM]       units in sectors, blocks, cylinders or MB\n"
+		       "  -T, --list-types        list the known partition types\n"
+		       "  -D, --DOS               for DOS-compatibility: waste a little space\n"
+		       "  -R, --re-read           make kernel reread partition table\n"
+		       "  -N=NUM                  change only the partition with number NUM\n"
+		       "  -n                      do not actually write to disk\n"
+		       "  -O FILE                 save the sectors that will be overwritten to file\n"
+		       "  -I FILE                 restore sectors from file\n"
+		       "  -v, --version           print version\n"
+		       "  -h, --help              print this message\n"));
+
+	fprintf(out, _("\nDangerous options:\n"
+		       "  -f, --force             disable all consistency checking\n"
+		       "  -g, --show-geometry     print the kernel's idea of the geometry\n"
+		       "  -G, --show-pt-geometry  print geometry guessed from the partition table\n"
+		       "  -x, --show-extended     also list extended partitions on output\n"
+		       "                          or expect descriptors for them on input\n"
+		       "  -L, --Linux             do not complain about things irrelevant for Linux\n"
+		       "  -q, --quiet             suppress warning messages\n"
+		       "\n  Override the detected geometry using:\n"
+		       "  -C, --cylinders=NUM     set the number of cylinders to use\n"
+		       "  -H, --heads=NUM         set the number of heads to use\n"
+		       "  -S, --sectors=NUM       set the number of sectors to use\n\n"));
+
+	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-static void
-usage(void) {
-    version();
-    printf(_("Usage: %s [options] device ...\n"), PROGNAME);
-    puts (_("device: something like /dev/hda or /dev/sda"));
-    puts (_("useful options:"));
-    puts (_("    -s [or --show-size]: list size of a partition"));
-    puts (_("    -c [or --id]:        print or change partition Id"));
-    puts (_("    -l [or --list]:      list partitions of each device"));
-    puts (_("    -d [or --dump]:      idem, but in a format suitable for later input"));
-    puts (_("    -i [or --increment]: number cylinders etc. from 1 instead of from 0"));
-    puts (_("    -uS, -uB, -uC, -uM:  accept/report in units of sectors/blocks/cylinders/MB"));
-    puts (_("    -T [or --list-types]:list the known partition types"));
-    puts (_("    -D [or --DOS]:       for DOS-compatibility: waste a little space"));
-    puts (_("    -R [or --re-read]:   make kernel reread partition table"));
-    puts (_("    -N# :                change only the partition with number #"));
-    puts (_("    -n :                 do not actually write to disk"));
-    puts (_("    -O file :            save the sectors that will be overwritten to file"));
-    puts (_("    -I file :            restore these sectors again"));
-    puts (_("    -v [or --version]:   print version"));
-    puts (_("    -? [or --help]:      print this message"));
-    puts (_("dangerous options:"));
-    puts (_("    -g [or --show-geometry]: print the kernel's idea of the geometry"));
-    puts (_("    -G [or --show-pt-geometry]: print geometry guessed from the partition table"));
-    puts (_("    -x [or --show-extended]: also list extended partitions on output\n"
-          "                             or expect descriptors for them on input"));
-    puts (_("    -L  [or --Linux]:      do not complain about things irrelevant for Linux"));
-    puts (_("    -q  [or --quiet]:      suppress warning messages"));
-    puts (_("    You can override the detected geometry using:"));
-    puts (_("    -C# [or --cylinders #]:set the number of cylinders to use"));
-    puts (_("    -H# [or --heads #]:    set the number of heads to use"));
-    puts (_("    -S# [or --sectors #]:  set the number of sectors to use"));
-    puts (_("You can disable all consistency checking with:"));
-    puts (_("    -f  [or --force]:      do what I say, even if it is stupid"));
-    exit(1);
-}
 
 static void
 activate_usage(char *progn) {
@@ -2364,7 +2364,7 @@ unhide_usage(char *progn __attribute__ ((__unused__))) {
     exit(1);
 }
 
-static char short_opts[] = "cdfgilnqsu:vx?1A::C:DGH:I:LN:O:RS:TU::V";
+static const char short_opts[] = "cdfghilnqsu:vx1A::C:DGH:I:LN:O:RS:TU::V";
 
 #define PRINT_ID 0400
 #define CHANGE_ID 01000
@@ -2376,6 +2376,7 @@ static const struct option long_opts[] = {
     { "dump",             no_argument, NULL, 'd' },
     { "force",            no_argument, NULL, 'f' },
     { "show-geometry",	  no_argument, NULL, 'g' },
+    { "help",	          no_argument, NULL, 'h' },
     { "increment",        no_argument, NULL, 'i' },
     { "list",             no_argument, NULL, 'l' },
     { "quiet",            no_argument, NULL, 'q' },
@@ -2383,7 +2384,6 @@ static const struct option long_opts[] = {
     { "unit",       required_argument, NULL, 'u' },
     { "version",          no_argument, NULL, 'v' },
     { "show-extended",    no_argument, NULL, 'x' },
-    { "help",	          no_argument, NULL, '?' },
     { "one-only",         no_argument, NULL, '1' },
     { "cylinders",  required_argument, NULL, 'C' },
     { "heads",      required_argument, NULL, 'H' },
@@ -2556,8 +2556,12 @@ main(int argc, char **argv) {
 	  case 'u':
 	    set_format(*optarg); break;
 	  case 'v':
-	    version();
-	    exit(0);
+	    printf(_("%s from %s\n"), program_invocation_short_name,
+	                              PACKAGE_STRING);
+	    return EXIT_SUCCESS;
+	  case 'h':
+	    usage(stdout);
+	    return EXIT_SUCCESS;
 	  case 'x':
 	    show_extended = 1; break;
 	  case 'A':
@@ -2591,9 +2595,8 @@ main(int argc, char **argv) {
 	    unhide = 1; break;
 	  case 'V':
 	    verify = 1; break;
-	  case '?':
 	  default:
-	    usage(); break;
+	    usage(stderr); break;
 
 	  /* undocumented flags */
 	  case 128:
@@ -2659,7 +2662,7 @@ main(int argc, char **argv) {
 	else if (unhide)
 	  unhide_usage(fdisk ? "sfdisk -U" : progn);
 	else
-	  usage();
+	  usage(stderr);
     }
 
     if (opt_list || opt_out_geom || opt_out_pt_geom || opt_size || verify) {
-- 
1.7.5.2


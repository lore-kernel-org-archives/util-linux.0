Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35523 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1046084AbdDWU6o (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 23 Apr 2017 16:58:44 -0400
Received: by mail-wm0-f65.google.com with SMTP id d79so13792843wmi.2
        for <util-linux@vger.kernel.org>; Sun, 23 Apr 2017 13:58:43 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 05/10] partx: add --list-types option
Date: Sun, 23 Apr 2017 21:58:16 +0100
Message-Id: <20170423205821.7444-6-kerolasa@iki.fi>
In-Reply-To: <20170423205821.7444-1-kerolasa@iki.fi>
References: <20170423205821.7444-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use libblkid as the source of truth what partition type names exist, and are
supported.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/partx |  4 ++--
 disk-utils/partx.8    | 18 ++++--------------
 disk-utils/partx.c    | 22 +++++++++++++++++++++-
 3 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/bash-completion/partx b/bash-completion/partx
index 921666274..929000013 100644
--- a/bash-completion/partx
+++ b/bash-completion/partx
@@ -27,8 +27,7 @@ _partx_module()
 			return 0
 			;;
 		'-t'|'--type')
-			# FIXME: some command should list type libblkid knows.
-			COMPREPLY=( $(compgen -W "aix bsd dos gpt mac minix PMBR sgi solaris sun ultrix unixware" -- $cur) )
+			COMPREPLY=( $(compgen -W "$(partx --list-types)" -- $cur) )
 			return 0
 			;;
 		'-h'|'--help'|'-V'|'--version')
@@ -50,6 +49,7 @@ _partx_module()
 				--raw
 				--sector-size
 				--type
+				--list-types
 				--verbose
 				--help
 				--version
diff --git a/disk-utils/partx.8 b/disk-utils/partx.8
index 2dd34f209..c9720359d 100644
--- a/disk-utils/partx.8
+++ b/disk-utils/partx.8
@@ -119,20 +119,10 @@ The output columns can be selected and rearranged with the
 All numbers (except SIZE) are in 512-byte sectors.
 .TP
 .BR \-t , " \-\-type " \fItype
-Specify the partition table type, which can be one of
-.BR aix ,
-.BR bsd ,
-.BR dos ,
-.BR gpt ,
-.BR mac ,
-.BR minix ,
-.BR PMBR ,
-.BR sgi ,
-.BR solaris ,
-.BR sun ,
-.BR ultrix ,
-or
-.BR unixware .
+Specify the partition table type.
+.TP
+.BR \-\-list\-types
+List partition types and exit.
 .TP
 .BR \-u , " \-\-update"
 Update the specified partitions.
diff --git a/disk-utils/partx.c b/disk-utils/partx.c
index a0e337b78..de0eadd28 100644
--- a/disk-utils/partx.c
+++ b/disk-utils/partx.c
@@ -743,6 +743,18 @@ static blkid_partlist get_partlist(blkid_probe pr,
 	return ls;
 }
 
+static void list_partition_types(void)
+{
+	char **list = blkid_return_known_pttypes();
+	size_t i;
+
+	for (i = 0; list[i]; i++) {
+		puts(list[i]);
+		free(list[i]);
+	}
+	free(list);
+}
+
 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	size_t i;
@@ -767,7 +779,8 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -P, --pairs          use key=\"value\" output format\n"), out);
 	fputs(_(" -r, --raw            use raw output format\n"), out);
 	fputs(_(" -S, --sector-size <num>  overwrite sector size\n"), out);
-	fputs(_(" -t, --type <type>    specify the partition type (dos, bsd, solaris, etc.)\n"), out);
+	fputs(_(" -t, --type <type>    specify the partition type\n"), out);
+	fputs(_("     --list-types     list partition types and exit\n"), out);
 	fputs(_(" -v, --verbose        verbose mode\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
@@ -795,6 +808,9 @@ int main(int argc, char **argv)
 	dev_t disk_devno = 0, part_devno = 0;
 	unsigned int sector_size = 0;
 
+	enum {
+		OPT_LIST_TYPES = CHAR_MAX + 1
+	};
 	static const struct option long_opts[] = {
 		{ "bytes",	no_argument,       NULL, 'b' },
 		{ "noheadings",	no_argument,       NULL, 'g' },
@@ -805,6 +821,7 @@ int main(int argc, char **argv)
 		{ "delete",	no_argument,	   NULL, 'd' },
 		{ "update",     no_argument,       NULL, 'u' },
 		{ "type",	required_argument, NULL, 't' },
+		{ "list-types", no_argument,       NULL, OPT_LIST_TYPES },
 		{ "nr",		required_argument, NULL, 'n' },
 		{ "output",	required_argument, NULL, 'o' },
 		{ "pairs",      no_argument,       NULL, 'P' },
@@ -877,6 +894,9 @@ int main(int argc, char **argv)
 		case 'v':
 			verbose = 1;
 			break;
+		case OPT_LIST_TYPES:
+			list_partition_types();
+			return EXIT_SUCCESS;
 		case 'h':
 			usage(stdout);
 		case 'V':
-- 
2.12.2


Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34880 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1046002AbdDWU6l (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 23 Apr 2017 16:58:41 -0400
Received: by mail-wm0-f44.google.com with SMTP id w64so48376265wma.0
        for <util-linux@vger.kernel.org>; Sun, 23 Apr 2017 13:58:41 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 02/10] blkid: add long options
Date: Sun, 23 Apr 2017 21:58:13 +0100
Message-Id: <20170423205821.7444-3-kerolasa@iki.fi>
In-Reply-To: <20170423205821.7444-1-kerolasa@iki.fi>
References: <20170423205821.7444-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This change attempts to make tab completion more reasonable by alloging
memorizable option names.  That also has positive impact to manual page, in
which referrals to other options are now easier to understand.

All short options are kept exactly as they were to avoid ABI breakage.  The
only exception is -f option that getopt(3) recognized, but was not found
from anywhere else.  The -f has been part of blkid since the initial commit.

Commit: 51410fc6deb29cae54a2669aafabae6c49f964fc
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/blkid |  70 +++++++++++++++++++++-------
 misc-utils/blkid.8    | 127 ++++++++++++++++++++++++--------------------------
 misc-utils/blkid.c    |  83 +++++++++++++++++++++------------
 3 files changed, 167 insertions(+), 113 deletions(-)

diff --git a/bash-completion/blkid b/bash-completion/blkid
index 26e414a5e..eb2ecf3fe 100644
--- a/bash-completion/blkid
+++ b/bash-completion/blkid
@@ -1,59 +1,93 @@
 _blkid_module()
 {
-	local cur prev OPTS
+	local cur prev OPTS OUTPUT_ALL
+	OUTPUT_ALL=''
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
-		'-c')
+		'-c'|'--cache-file')
 			local IFS=$'\n'
 			compopt -o filenames
 			COMPREPLY=( $(compgen -f -- $cur) )
 			return 0
 			;;
-		'-o')
+		'-o'|'--output')
 			COMPREPLY=( $(compgen -W "value device export full" -- $cur) )
 			return 0
 			;;
-		'-s')
+		'-s'|'--match-tag')
 			COMPREPLY=( $(compgen -W "tag" -- $cur) )
 			return 0
 			;;
-		'-t')
-			COMPREPLY=( $(compgen -W "token" -- $cur) )
+		'-t'|'--match-token')
+			COMPREPLY=( $(compgen -W "TYPE= LABEL= UUID=" -- $cur) )
 			return 0
 			;;
-		'-L')
+		'-L'|'--label')
 			COMPREPLY=( $(compgen -W "$(cd /dev/disk/by-label/ 2>/dev/null && echo *)" -- $cur) )
 			return 0
 			;;
-		'-U')
+		'-U'|'--uuid')
 			COMPREPLY=( $(compgen -W "$(cd /dev/disk/by-uuid/ 2>/dev/null && echo *)" -- $cur) )
 			return 0
 			;;
-		'-s')
+		'-S'|'--size')
 			COMPREPLY=( $(compgen -W "size" -- $cur) )
 			return 0
 			;;
-		'-O')
+		'-O'|'--offset')
 			COMPREPLY=( $(compgen -W "offset" -- $cur) )
 			return 0
 			;;
-		'-u')
-			COMPREPLY=( $(compgen -W "filesystem raid crypto other nofilesystem noraid nocrypto noother" -- $cur) )
-			return 0
+		'-u'|'--usages')
+			OUTPUT_ALL={,no}{filesystem,raid,crypto,other}
 			;;
-		'-n')
-			COMPREPLY=( $(compgen -W "$(awk '{print $NF}' /proc/filesystems)" -- $cur) )
-			return 0
+		'-n'|'--match-types')
+			OUTPUT_ALL="
+				$(awk '{print $NF}' /proc/filesystems)
+				$(\ls /lib/modules/$(uname -r)/kernel/fs)
+			"
 			;;
-		'-h'|'-V')
+		'-h'|'--help'|'-V'|'--version')
 			return 0
 			;;
 	esac
+	if [ -n "$OUTPUT_ALL" ]; then
+		local prefix realcur OUTPUT_ALL OUTPUT
+		realcur="${cur##*,}"
+		prefix="${cur%$realcur}"
+		for WORD in $OUTPUT_ALL; do
+			if ! [[ $prefix == *"$WORD"* ]]; then
+				OUTPUT="$WORD $OUTPUT"
+			fi
+		done
+		compopt -o nospace
+		COMPREPLY=( $(compgen -P "$prefix" -W "$OUTPUT" -S ',' -- "$realcur") )
+		return 0
+	fi
 	case $cur in
 		-*)
-			OPTS="-c -d -h -g -o -k -s -t -l -L -U -V -p -i -S -O -u -n"
+			OPTS="
+				--cache-file
+				--no-encoding
+				--garbage-collect
+				--output
+				--list-filesystems
+				--match-tag
+				--match-token
+				--list-one
+				--label
+				--uuid
+				--probe
+				--info
+				--size
+				--offset
+				--usages
+				--match-types
+				--help
+				--version
+			"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/misc-utils/blkid.8 b/misc-utils/blkid.8
index 508222717..3fc102f25 100644
--- a/misc-utils/blkid.8
+++ b/misc-utils/blkid.8
@@ -5,46 +5,42 @@
 .SH NAME
 blkid \- locate/print block device attributes
 .SH SYNOPSIS
-.B blkid
-.BI \-L " label"
+.IP \fBblkid\fR
+.BI \-\-label " label"
 |
-.BI \-U " uuid"
+.BI \-\-uuid " uuid"
 
-.B blkid
-.RB [ \-dghlv ]
-.RB [ \-c
+.IP \fBblkid\fR
+.RB [ \-\-no\-encoding
+.B \-\-garbage\-collect \-\-list\-one \-\-cache\-file
 .IR file ]
-.RB [ \-o
+.RB [ \-\-output
 .IR format ]
-.RB [ \-s
+.RB [ \-\-match\-tag
 .IR tag ]
-.in +6
-.RB [ \-t
+.RB [ \-\-match\-token
 .IR NAME=value ]
 .RI [ device " ...]"
-.in -6
 
-.B blkid
-.BR -p " [" \-O
+.IP \fBblkid\fR
+.BR \-\-probe " [" \-\-offset
 .IR offset ]
-.RB [ \-o
+.RB [ \-\-output
 .IR format ]
-.RB [ \-S
+.RB [ \-\-size
 .IR size ]
-.RB [ \-s
+.RB [ \-\-match\-tag
 .IR tag ]
-.in +9
-.RB [ \-n
+.RB [ \-\-match\-types
 .IR list ]
-.RB [ \-u
+.RB [ \-\-usages
 .IR list ]
 .IR device " ..."
-.in -9
 
-.B blkid
-.BR -i " [" \-o
+.IP \fBblkid\fR
+.BR \-\-info " [" \-\-output
 .IR format ]
-.RB [ \-s
+.RB [ \-\-match\-tag
 .IR tag ]
 .IR device " ..."
 
@@ -95,7 +91,7 @@ suffixes like KiB (=1024), MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, Z
 (the "iB" is optional, e.g. "K" has the same meaning as "KiB"), or the suffixes
 KB (=1000), MB (=1000*1000), and so on for GB, TB, PB, EB, ZB and YB.
 .TP
-.BI \-c " cachefile"
+\fB\-c\fR, \fB\-\-cache\-file\fR \fIcachefile\fR
 Read from
 .I cachefile
 instead of reading from the default cache file (see the CONFIGURATION FILE section
@@ -103,27 +99,27 @@ for more details).  If you want to start with a clean cache (i.e. don't report
 devices previously scanned but not necessarily available at this time), specify
 .IR /dev/null .
 .TP
-.B \-d
+\fB\-d\fR, \fB\-\-no\-encoding\fR
 Don't encode non-printing characters.  The non-printing characters are encoded
-by ^ and M- notation by default.  Note that the \fB-o udev\fR output format uses
+by ^ and M- notation by default.  Note that the \fB\-\-output udev\fR output format uses
 a different encoding which cannot be disabled.
 .TP
-.B \-g
+\fB\-g\fR, \fB\-\-garbage\-collect\fR
 Perform a garbage collection pass on the blkid cache to remove
 devices which no longer exist.
 .TP
-.B \-h
+\fB\-h\fR, \fB\-\-help\fR
 Display a usage message and exit.
 .TP
-.B \-i
+\fB\-i\fR, \fB\-\-info\fR
 Display information about I/O Limits (aka I/O topology).  The 'export' output format is
-automatically enabled.  This option can be used together with the \fB-p\fR option.
+automatically enabled.  This option can be used together with the \fB\-\-probe\fR option.
 .TP
-.B \-k
+\fB\-k\fR, \fB\-\-list\-filesystems\fR
 List all known filesystems and RAIDs and exit.
 .TP
-.B \-l
-Look up only one device that matches the search parameter specified with the \fB-t\fR
+\fB\-l\fR, \fB\-\-list\-one\fR
+Look up only one device that matches the search parameter specified with the \fB\-\-match\-token\fR
 option.  If there are multiple devices that match the specified search
 parameter, then the device with the highest priority is returned, and/or
 the first device found at a given priority.  Device types in order of
@@ -132,13 +128,13 @@ block devices.  If this option is not specified,
 .B blkid
 will print all of the devices that match the search parameter.
 .TP
-.BI \-L " label"
+\fB\-L\fR, \fB\-\-label\fR \fIlabel\fR
 Look up the device that uses this filesystem \fIlabel\fR; this is equal to
-.BR "-l -o device -t LABEL=\fIlabel\fR" .
+.BR "--list-one --output device --match-token LABEL=\fIlabel\fR" .
 This lookup method is able to reliably use /dev/disk/by-label
 udev symlinks (dependent on a setting in /etc/blkid.conf).  Avoid using the
 symlinks directly; it is not reliable to use the symlinks without verification.
-The \fB-L\fR option works on systems with and without udev.
+The \fB-\-label\fR option works on systems with and without udev.
 
 Unfortunately, the original
 .BR blkid (8)
@@ -146,22 +142,22 @@ from e2fsprogs uses the \fB-L\fR option as a
 synonym for \fB-o list\fR.  For better portability, use \fB-l -o device
 -t LABEL=\fIlabel\fR and \fB-o list\fR in your scripts rather than the \fB-L\fR option.
 .TP
-.BI \-n " list"
+\fB\-n\fR, \fB\-\-match\-types\fR \fIlist\fR
 Restrict the probing functions to the specified (comma-separated) \fIlist\fR of
 superblock types (names).
 The list items may be prefixed with "no" to specify the types which should be ignored.
 For example:
 .sp
-  blkid -p -n vfat,ext3,ext4 /dev/sda1
+  blkid --probe --match-types vfat,ext3,ext4 /dev/sda1
 .sp
 probes for vfat, ext3 and ext4 filesystems, and
 .sp
-  blkid -p -n nominix /dev/sda1
+  blkid --probe --match-types nominix /dev/sda1
 .sp
 probes for all supported formats except minix filesystems.
-This option is only useful together with \fB-p\fR.
+This option is only useful together with \fB\-\-probe\fR.
 .TP
-.BI \-o " format"
+\fB\-o\fR, \fB\-\-output\fR \fIformat\fR
 Use the specified output format.  Note that the order of variables and
 devices is not fixed.  See also option \fB-s\fR.  The
 .I format
@@ -176,15 +172,15 @@ print the value of the tags
 .TP
 .B list
 print the devices in a user-friendly format; this output format is unsupported
-for low-level probing (\fB-p\fR or \fB-i\fR).
+for low-level probing (\fB\-\-probe\fR or \fB\-\-info\fR).
 
 This output format is \fBDEPRECATED\fR in favour of the
 .BR lsblk (8)
 command.
 .TP
 .B device
-print the device name only; this output format is always enabled for the \fB-L\fR
-and \fB-U\fR options
+print the device name only; this output format is always enabled for the \fB\-\-label\fR
+and \fB\-\-uuid\fR options
 .TP
 .B udev
 print key="value" pairs for easy import into the udev environment; the keys are
@@ -196,40 +192,40 @@ partitions.  This output format is \fBDEPRECATED\fR.
 .TP
 .B export
 print key=value pairs for easy import into the environment; this output format
-is automatically enabled when I/O Limits (\fB-i\fR option) are requested.
+is automatically enabled when I/O Limits (\fB\-\-info\fR option) are requested.
 
 The non-printing characters are encoded by ^ and M- notation and all
 potentially unsafe characters are escaped.
 .RE
 .TP
-.BI \-O " offset"
-Probe at the given \fIoffset\fR (only useful with \fB-p\fR).  This option can be
-used together with the \fB-i\fR option.
+\fB\-O\fR, \fB\-\-offset\fR \fIoffset\fR
+Probe at the given \fIoffset\fR (only useful with \fB\-\-probe\fR).  This option can be
+used together with the \fB\-\-info\fR option.
 .TP
-.BI \-p
+\fB\-p\fR, \fB\-\-probe\fR
 Switch to low-level superblock probing mode (bypassing the cache).
 
 Note that low-level probing also returns information about partition table type
 (PTTYPE tag) and partitions (PART_ENTRY_* tags). The tag names produced by
 low-level probing are based on names used internally by libblkid and it may be
-different than when executed without \fB-p\fR (for example PART_ENTRY_UUID= vs
+different than when executed without \fB\-\-probe\fR (for example PART_ENTRY_UUID= vs
 PARTUUID=).
 .TP
-.BI \-s " tag"
+\fB\-s\fR, \fB\-\-match\-tag\fR \fItag\fR
 For each (specified) device, show only the tags that match
 .IR tag .
 It is possible to specify multiple
-.B \-s
+.B \-\-match\-tag
 options.  If no tag is specified, then all tokens are shown for all
 (specified) devices.
 In order to just refresh the cache without showing any tokens, use
-.B "-s none"
+.B "\-\-match\-tag none"
 with no other options.
 .TP
-.BI \-S " size"
-Override the size of device/file (only useful with \fB-p\fR).
+\fB\-S\fR, \fB\-\-size\fR \fIsize\fR
+Override the size of device/file (only useful with \fB\-\-probe\fR).
 .TP
-.BI \-t " NAME" = value
+\fB\-t\fR, \fB\-\-match\-token\fR \fINAME=value\fR
 Search for block devices with tokens named
 .I NAME
 that have the value
@@ -245,29 +241,30 @@ and
 If there are no devices specified on the command line, all block devices
 will be searched; otherwise only the specified devices are searched.
 .TP
-.BI \-u " list"
+\fB\-u\fR, \fB\-\-usages\fR \fIlist\fR
 Restrict the probing functions to the specified (comma-separated) \fIlist\fR of "usage" types.
 Supported usage types are: filesystem, raid, crypto and other.  The list items may be
 prefixed with "no" to specify the usage types which should be ignored.  For example:
 .sp
-  blkid -p -u filesystem,other /dev/sda1
+  blkid --probe --usages filesystem,other /dev/sda1
 .sp
 probes for all filesystem and other (e.g. swap) formats, and
 .sp
-  blkid -p -u noraid /dev/sda1
+  blkid --probe --usages noraid /dev/sda1
 .sp
 probes for all supported formats except RAIDs.
-This option is only useful together with \fB-p\fR.
+This option is only useful together with \fB\-\-probe\fR.
 .TP
-.BI \-U " uuid"
-Look up the device that uses this filesystem \fIuuid\fR.  For more details see the \fB-L\fR option.
+\fB\-U\fR, \fB\-\-uuid\fR \fIuuid\fR
+Look up the device that uses this filesystem \fIuuid\fR.  For more details see the
+\fB\-\-label\fR option.
 .TP
-.B \-V
+\fB\-V\fR, \fB\-\-version\fR
 Display version number and exit.
 .SH "RETURN CODE"
 If the specified device or device addressed by specified token (option
-\fB-t\fR) was found and it's possible to gather any information about the
-device, an exit code 0 is returned.  Note the option \fB-s\fR filters output
+\fB\-\-match\-token\fR) was found and it's possible to gather any information about the
+device, an exit code 0 is returned.  Note the option \fB\-\-match\-tag\fR filters output
 tags, but it does not affect return code.
 
 If the specified token was not found, or no (specified) devices could be
diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index a472d06c4..d8cf39a2f 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -72,37 +72,38 @@ static void usage(int error)
 	FILE *out = error ? stderr : stdout;
 
 	fputs(USAGE_HEADER, out);
-	fprintf(out, _(	" %s -L <label> | -U <uuid>\n\n"), program_invocation_short_name);
-	fprintf(out, _(	" %s [-c <file>] [-ghlLv] [-o <format>] [-s <tag>] \n"
-			"       [-t <token>] [<dev> ...]\n\n"), program_invocation_short_name);
-	fprintf(out, _(	" %s -p [-s <tag>] [-O <offset>] [-S <size>] \n"
-			"       [-o <format>] <dev> ...\n\n"), program_invocation_short_name);
-	fprintf(out, _(	" %s -i [-s <tag>] [-o <format>] <dev> ...\n"), program_invocation_short_name);
+	fprintf(out, _(	" %s --label <label> | --uuid <uuid>\n\n"), program_invocation_short_name);
+	fprintf(out, _(	" %s [--cache-file <file>] [-ghlLv] [--output <format>] [--match-tag <tag>] \n"
+			"       [--match-token <token>] [<dev> ...]\n\n"), program_invocation_short_name);
+	fprintf(out, _(	" %s -p [--match-tag <tag>] [--offset <offset>] [--size <size>] \n"
+			"       [--output <format>] <dev> ...\n\n"), program_invocation_short_name);
+	fprintf(out, _(	" %s -i [--match-tag <tag>] [--output <format>] <dev> ...\n"), program_invocation_short_name);
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(	" -c <file>   read from <file> instead of reading from the default\n"
-			"               cache file (-c /dev/null means no cache)\n"), out);
-	fputs(_(	" -d          don't encode non-printing characters\n"), out);
-	fputs(_(	" -h          print this usage message and exit\n"), out);
-	fputs(_(	" -g          garbage collect the blkid cache\n"), out);
-	fputs(_(	" -o <format> output format; can be one of:\n"
-			"               value, device, export or full; (default: full)\n"), out);
-	fputs(_(	" -k          list all known filesystems/RAIDs and exit\n"), out);
-	fputs(_(	" -s <tag>    show specified tag(s) (default show all tags)\n"), out);
-	fputs(_(	" -t <token>  find device with a specific token (NAME=value pair)\n"), out);
-	fputs(_(	" -l          look up only first device with token specified by -t\n"), out);
-	fputs(_(	" -L <label>  convert LABEL to device name\n"), out);
-	fputs(_(	" -U <uuid>   convert UUID to device name\n"), out);
-	fputs(_(	" -V          print version and exit\n"), out);
-	fputs(_(	" <dev>       specify device(s) to probe (default: all devices)\n"), out);
+	fputs(_(	" -c, --cache-file <file>    read from <file> instead of reading from the default\n"
+			"                              cache file (-c /dev/null means no cache)\n"), out);
+	fputs(_(	" -d, --no-encoding          don't encode non-printing characters\n"), out);
+	fputs(_(	" -g, --garbage-collect      garbage collect the blkid cache\n"), out);
+	fputs(_(	" -o, --output <format>      output format; can be one of:\n"
+			"                              value, device, export or full; (default: full)\n"), out);
+	fputs(_(	" -k, --list-filesystems     list all known filesystems/RAIDs and exit\n"), out);
+	fputs(_(	" -s, --match-tag <tag>      show specified tag(s) (default show all tags)\n"), out);
+	fputs(_(	" -t, --match-token <token>  find device with a specific token (NAME=value pair)\n"), out);
+	fputs(_(	" -l, --list-one             look up only first device with token specified by -t\n"), out);
+	fputs(_(	" -L, --label <label>        convert LABEL to device name\n"), out);
+	fputs(_(	" -U, --uuid <uuid>          convert UUID to device name\n"), out);
+	fputs(_(	" <dev>                      specify device(s) to probe (default: all devices)\n"), out);
 	fputs(          "\n", out);
 	fputs(_(	"Low-level probing options:\n"), out);
-	fputs(_(	" -p          low-level superblocks probing (bypass cache)\n"), out);
-	fputs(_(	" -i          gather information about I/O limits\n"), out);
-	fputs(_(	" -S <size>   overwrite device size\n"), out);
-	fputs(_(	" -O <offset> probe at the given offset\n"), out);
-	fputs(_(	" -u <list>   filter by \"usage\" (e.g. -u filesystem,raid)\n"), out);
-	fputs(_(	" -n <list>   filter by filesystem type (e.g. -n vfat,ext3)\n"), out);
-
+	fputs(_(	" -p, --probe                low-level superblocks probing (bypass cache)\n"), out);
+	fputs(_(	" -i, --info                 gather information about I/O limits\n"), out);
+	fputs(_(	" -S, --size <size>          overwrite device size\n"), out);
+	fputs(_(	" -O, --offset <offset>      probe at the given offset\n"), out);
+	fputs(_(	" -u, --usages <list>        filter by \"usage\" (e.g. -u filesystem,raid)\n"), out);
+	fputs(_(	" -n, --match-types <list>   filter by filesystem type (e.g. -n vfat,ext3)\n"), out);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
 	fprintf(out, USAGE_MAN_TAIL("blkid(8)"));
 	exit(error);
 }
@@ -657,6 +658,28 @@ int main(int argc, char **argv)
 	unsigned int i;
 	int c;
 
+	static const struct option longopts[] = {
+		{ "cache-file",	      required_argument, NULL, 'c' },
+		{ "no-encoding",      no_argument,	 NULL, 'd' },
+		{ "garbage-collect",  no_argument,	 NULL, 'g' },
+		{ "output",	      required_argument, NULL, 'o' },
+		{ "list-filesystems", no_argument,	 NULL, 'k' },
+		{ "match-tag",	      required_argument, NULL, 's' },
+		{ "match-token",      required_argument, NULL, 't' },
+		{ "list-one",	      no_argument,	 NULL, 'l' },
+		{ "label",	      required_argument, NULL, 'L' },
+		{ "uuid",	      required_argument, NULL, 'U' },
+		{ "probe",	      no_argument,	 NULL, 'p' },
+		{ "info",	      no_argument,	 NULL, 'i' },
+		{ "size",	      required_argument, NULL, 'S' },
+		{ "offset",	      required_argument, NULL, 'O' },
+		{ "usages",	      required_argument, NULL, 'u' },
+		{ "match-types",      required_argument, NULL, 'n' },
+		{ "version",	      no_argument,	 NULL, 'V' },
+		{ "help",	      no_argument,       NULL, 'h' },
+		{ NULL, 0, NULL, 0 }
+	};
+
 	static const ul_excl_t excl[] = {       /* rows and cols in ASCII order */
 		{ 'n','u' },
 		{ 0 }
@@ -668,8 +691,8 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((c = getopt (argc, argv,
-			    "c:df:ghilL:n:ko:O:ps:S:t:u:U:w:Vv")) != EOF) {
+	while ((c = getopt_long (argc, argv,
+			    "c:dghilL:n:ko:O:ps:S:t:u:U:w:Vv", longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, NULL, excl, excl_st);
 
-- 
2.12.2


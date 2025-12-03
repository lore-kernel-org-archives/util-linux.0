Received: from csmtpq3-prd-nl1-vfz.edge.unified.services (csmtpq3-prd-nl1-vfz.edge.unified.services [84.116.50.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72DF257423
	for <util-linux@vger.kernel.org>; Wed,  3 Dec 2025 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.116.50.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764789983; cv=none; b=lguyfQIcQLFbJcL9sHvZTHlvanE4u2rzFZeFEPzXDpaR9EAM1jhNOmDIOECvnyRQHksrZBCRDgI7KQyvBehrmHU5AHqIntq+5bjOLd+rLtlPyPgn6KpcYyfOcxSbEKeU9+B1kXXh7kK8Ux9AfYN+j1X+56KB46LFEIY/XfGTk18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764789983; c=relaxed/simple;
	bh=kPDrG2sfpHuqnc9OlQFkpT1hK56HGAk/6v9pQqJ1aWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lg3BFQb5KC821lh2lXrVPYj6w6xlwDLih9sslYNq7HNU/97LLlYDaG2/5fA1lqj/2XUDX9FZKgPSKAoTEMaPeZKQR2OJu86sxVnften51JQ/8XaWaszH6fxiru4loE1CT4KGafpwmzbmuPayvACS1Qnf7175P78Rmyc9oxoNUIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mrns.nl; spf=none smtp.mailfrom=mrns.nl; dkim=pass (1024-bit key) header.d=mrns.nl header.i=@mrns.nl header.b=W1rK7j8Y; arc=none smtp.client-ip=84.116.50.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mrns.nl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mrns.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mrns.nl header.i=@mrns.nl header.b="W1rK7j8Y"
Received: from csmtp3-prd-nl1-vfz.nl1.unified.services ([100.107.80.12] helo=csmtp3-prd-nl1-vfz.edge.unified.services)
	by csmtpq3-prd-nl1-vfz.edge.unified.services with esmtp (Exim 4.95)
	(envelope-from <dick@mrns.nl>)
	id 1vQsUO-00BHM1-48
	for util-linux@vger.kernel.org;
	Wed, 03 Dec 2025 20:26:13 +0100
Received: from routi.mrns.nl ([212.204.155.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by csmtp3-prd-nl1-vfz.edge.unified.services with ESMTPSA
	id QsUNvjV7V4qMTQsUNv9aio; Wed, 03 Dec 2025 20:26:13 +0100
X-Env-Mailfrom: dick@mrns.nl
X-Env-Rcptto: util-linux@vger.kernel.org
X-SourceIP: 212.204.155.133
X-CNFS-Analysis: v=2.4 cv=Me7GfZ/f c=1 sm=1 tr=0 ts=69308ed5 cx=a_exe
 a=+NQzl7YsTyKB6E3DpOjMZQ==:117 a=+NQzl7YsTyKB6E3DpOjMZQ==:17
 a=wP3pNCr1ah4A:10 a=LQrtYbNyCH8A:10 a=oxU5Xt4QAAAA:8 a=mDV3o1hIAAAA:8
 a=o7NSSjmN_tqXl4h1rAEA:9 a=lqcHg5cX4UMA:10 a=jKdzr7yA372qb7_9lzlF:22
X-Authenticated-Sender: ieb1yoh3@ziggo.nl
Received: by routi.mrns.nl (sSMTP sendmail emulation); Wed, 03 Dec 2025 20:26:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mrns.nl;
 i=@mrns.nl; q=dns/txt; s=mail; t=1764789971; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version
 : content-transfer-encoding : from;
 bh=kPDrG2sfpHuqnc9OlQFkpT1hK56HGAk/6v9pQqJ1aWo=;
 b=W1rK7j8Yx7KtcLjowan+PGtV2D7aQpUGnNisvh33SO69c0noHB12bNgCw0bNrIVilmbkx
 KsuhQ5USRIe6WNiu7cTuKdkcx/M9VUhXNWiHngOdUSV+Nj81Nbzpy9AYKY2E8CpktvXl/eR
 45Z2yuhLsHoJaljeFfgWliSASyoE46Y=
From: Dick Marinus <dick@mrns.nl>
To: util-linux@vger.kernel.org
Cc: Dick Marinus <dick@mrns.nl>
Subject: [PATCH 1/1] copyfilerange: new command to call copy-file-range
Date: Wed,  3 Dec 2025 20:25:49 +0100
Message-ID: <20251203192558.1116470-2-dick@mrns.nl>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251203192558.1116470-1-dick@mrns.nl>
References: <20251202201500.1029349-1-dick@mrns.nl>
 <20251203192558.1116470-1-dick@mrns.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfETDgMdiB7EfZR7ba1mAmnJ8SOF2jABjidRxSyXe+wp4yqTTfix3Q3TSwmrpGOC8ndXuLFXJAltfOFx96jHEYny4K5u665acRYHEiG2HLJWwDoBu5izj
 FwHIVl4OSylJzN4B1ZhPdyZZ/cRlxvaYpJpCxpFUChOnEQPz0+dJvFAD2mf29qEWGa8+zwXWUjIW1uBBzPtR+dnapeST6Zz/ndU=

This command allows you to call the copy-file range system call which
performs an in-kernel copy between two files without the additional cost
of transferring data from the kernel to user space and then back into
the kernel.

It gives filesystems an opportunity to implement "copy acceleration"
techniques, such as the use of reflinks (i.e., two or more inodes that
share  pointers to the same copy-on-write disk blocks) or
server-side-copy (in the case of NFS).

A purpose of this command is to in-place deduplicate equal file blocks
in two different files.

When calling this command the source and destination file are required
and ranges can be supplied using command line arguments or from a
commands file. The source and destination filename can be supplied using
the optional --source and --destination options.

A file range contains the offset in the source and destination file and
the length of the range in bytes. The offsets can be omitted so that the
current file pointer is used. When the size is omitted or set to zero
the remainder of the file is copied.

If the file range is too long to fit in SIZE_MAX subsequential calls to
copy_file_range will be performed to copy the whole range.

The following command will copy/reflink a file:

	$ copyfilerange file1 file2 0::

The following command will copy the second block from file1 into file2:

        $ copyfilerange file1 file2 4096:4096:4096

Signed-off-by: Dick Marinus <dick@mrns.nl>
---
 .gitignore                                 |   1 +
 configure.ac                               |   3 +
 meson.build                                |  14 ++
 meson_options.txt                          |   2 +
 misc-utils/Makemodule.am                   |   9 +
 misc-utils/copyfilerange.1.adoc            |  78 +++++++
 misc-utils/copyfilerange.c                 | 226 +++++++++++++++++++++
 misc-utils/meson.build                     |   5 +
 tests/commands.sh                          |   1 +
 tests/expected/copyfilerange/copyfilerange |   4 +
 tests/ts/copyfilerange/copyfilerange       |  40 ++++
 11 files changed, 383 insertions(+)
 create mode 100644 misc-utils/copyfilerange.1.adoc
 create mode 100644 misc-utils/copyfilerange.c
 create mode 100644 tests/expected/copyfilerange/copyfilerange
 create mode 100755 tests/ts/copyfilerange/copyfilerange

diff --git a/.gitignore b/.gitignore
index 14d320cf3..06fb8ddc1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -99,6 +99,7 @@ ylwrap
 /colcrt
 /colrm
 /column
+/copyfilerange
 /coresched
 /ctrlaltdel
 /delpart
diff --git a/configure.ac b/configure.ac
index cf415f5ed..0975f8e50 100644
--- a/configure.ac
+++ b/configure.ac
@@ -2650,6 +2650,9 @@ UL_REQUIRES_HAVE([write], [utmpx_h], [utmpx.h header])
 UL_REQUIRES_HAVE([write], [gnu_utmpx], [GNU utmpx functions])
 AM_CONDITIONAL([BUILD_WRITE], [test "x$build_write" = xyes])
 
+UL_BUILD_INIT([copyfilerange], [check])
+UL_REQUIRES_LINUX([copyfilerange])
+AM_CONDITIONAL([BUILD_COPYFILERANGE], [test "x$build_copyfilerange" = xyes])
 
 AC_ARG_WITH([btrfs],
   AS_HELP_STRING([--without-btrfs], [do not build with btrfs support]),
diff --git a/meson.build b/meson.build
index cac8bb578..e23804ef3 100644
--- a/meson.build
+++ b/meson.build
@@ -3076,6 +3076,20 @@ if opt and not is_disabler(exe)
   exes += exe
 endif
 
+opt = opt and 'copyfilerange' in static_programs
+exe = executable(
+  'copyfilerange',
+  copyfilerange_sources,
+  include_directories : includes,
+  link_with : [lib_common],
+  dependencies : [copyfilerange_dep],
+  install_dir : sbindir,
+  install : opt,
+  build_by_default : opt)
+if opt and not is_disabler(exe)
+  exes += exe
+endif
+
 exe = executable(
   'sample-mkfs',
   'libblkid/samples/mkfs.c',
diff --git a/meson_options.txt b/meson_options.txt
index 1ec904668..f023a4c27 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -259,6 +259,8 @@ option('build-hexdump', type : 'feature',
        description : 'build hexdump')
 option('build-findfs', type : 'feature',
        description : 'build findfs')
+option('build-copyfilerange', type : 'feature',
+       description : 'build copyfilerange')
 
 # static programs
 
diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
index d0bc8d806..afa9e6eec 100644
--- a/misc-utils/Makemodule.am
+++ b/misc-utils/Makemodule.am
@@ -337,3 +337,12 @@ lsclocks_SOURCES = misc-utils/lsclocks.c
 lsclocks_LDADD = $(LDADD) libcommon.la libsmartcols.la
 lsclocks_CFLAGS = $(AM_CFLAGS) -I$(ul_libsmartcols_incdir)
 endif
+
+if BUILD_COPYFILERANGE
+usrbin_exec_PROGRAMS += copyfilerange
+MANPAGES += misc-utils/copyfilerange.1
+dist_noinst_DATA += misc-utils/copyfilerange.1.adoc
+copyfilerange_SOURCES = misc-utils/copyfilerange.c
+copyfilerange_LDADD = $(LDADD) libcommon.la
+copyfilerange_CFLAGS = $(AM_CFLAGS)
+endif
diff --git a/misc-utils/copyfilerange.1.adoc b/misc-utils/copyfilerange.1.adoc
new file mode 100644
index 000000000..52a03ca09
--- /dev/null
+++ b/misc-utils/copyfilerange.1.adoc
@@ -0,0 +1,78 @@
+//po4a: entry man manual
+= copyfilerange(1)
+:doctype: manpage
+:man manual: User Commands
+:man source: util-linux {release-version}
+:page-layout: base
+:command: copyfilerange
+
+== NAME
+
+copyfilerange - Copy file ranges from source to destination file.
+
+== SYNOPSIS
+
+*copyfilerange* [options] [<source>] [<destination>] [<command>...]
+
+== DESCRIPTION
+
+*copyfilerange* copy file ranges from source to destination file
+*copyfilerange* is a simple utility to call the copy_file_range() system call.
+
+== OPTIONS
+
+*-s*, *--source*::
+Source filename
+
+*-d*, *--destination*::
+Destination filename
+
+*-c*, *--commands*::
+Commands filename
+
+*source*::
+Source filename
+
+*destination*::
+Destination filename
+
+*source_offset:dest_offset:length*::
+All values are in bytes, if length is set to 0 copy as much as available.
+Multiple commands can be supplied.
+
+When one or more of the offsets are omitted the operation will use the last used location, starting with 0
+
+include::man-common/help-version.adoc[]
+
+== EXIT STATUS
+
+*copyfilerange* has the following exit status values:
+
+*0*::
+success
+*1*::
+unspecified failure
+*2*::
+(some) range failed
+*3*::
+unspecified failure and (some) range failed
+
+== NOTES
+
+The copy_file_range() system call has some serious caveats, the source and destination files must use the same filesystem type and some virtual filesystems (like procfs) won't work. copy_file_range() will use reflinks when the filesystem supports this. To use reflinks the file range most often needs to align with the filesystem block size on both the source and destination file.
+
+== AUTHORS
+
+mailto:dick@mrns.nl[Dick Marinus]
+
+== SEE ALSO
+
+*copy_file_range*(2)
+
+include::man-common/bugreports.adoc[]
+
+include::man-common/footer.adoc[]
+
+ifdef::translation[]
+include::man-common/translation.adoc[]
+endif::[]
diff --git a/misc-utils/copyfilerange.c b/misc-utils/copyfilerange.c
new file mode 100644
index 000000000..d3e0a0521
--- /dev/null
+++ b/misc-utils/copyfilerange.c
@@ -0,0 +1,226 @@
+/*
+ * copyfilerange - utility to use the copy_file_range(2) system call
+ *
+ * Copyright (C) 2025 Dick Marinus <dick@mrns.nl>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <getopt.h>
+#include <string.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <limits.h>
+
+#include "c.h"
+#include "nls.h"
+#include "closestream.h"
+#include "xalloc.h"
+
+static void __attribute__((__noreturn__)) usage(void)
+{
+	FILE *out = stdout;
+	fputs(USAGE_HEADER, out);
+	fprintf(out,
+		_(" %1$s [options] [<source>] [<destination>] [<command>...]\n"),
+		program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputsln(_("Copy file ranges from source to destination file."), out);
+
+	fputs(USAGE_OPTIONS, out);
+	fputsln(_(" --source, -s filename       source filename"), out);
+	fputsln(_(" --destination, -d filename  destination filename"), out);
+	fputsln(_(" --commands, -c filename     read command(s) seperated by newlines from filename"), out);
+	fputsln(_(" source                      source filename"), out);
+	fputsln(_(" destination                 destination filename"), out);
+	fputsln(_(" command                     source_offset:dest_offset:length, all values are in bytes"), out);
+	fputsln(_("                             if length is set to 0 as much as available will be copied"), out);
+	fputsln(_("                             when the offset is omitted the last file position is used"), out);
+
+	fputs(USAGE_SEPARATOR, out);
+	fprintf(out, USAGE_HELP_OPTIONS(16));
+
+	fprintf(out, USAGE_MAN_TAIL("copyfilerange(1)"));
+	exit(EXIT_SUCCESS);
+}
+
+static int parse_range(const char *range_str, off_t *src_off, off_t *dst_off, size_t *len)
+{
+	char *copy = strdup(range_str);
+	if (!copy) return -1;
+
+	char *start;
+
+	start = copy;
+	char *token;
+	token = strchr(start, ':');
+	if (!token) goto fail;
+	*token = 0;
+	if (*start) *src_off = atoll(start);
+
+	start = token + 1;
+	token = strchr(start, ':');
+	if (!token) goto fail;
+	*token = 0;
+	if (*start) *dst_off = atoll(start);
+
+	start = token + 1;
+	if (*start) *len = atoll(start);
+	else *len = 0;
+
+	free(copy);
+	return 0;
+
+fail:
+	free(copy);
+	return -1;
+
+}
+
+static int handle_command(int fd_src, int fd_dst, off_t* src_off, off_t* dst_off, char* command)
+{
+	size_t len;
+	int rc = 0;
+	if (parse_range(command, src_off, dst_off, &len) != 0) {
+		fprintf(stderr, _("invalid range format: %s\n"), command);
+		return 1;
+	}
+
+	if (len == 0) {
+		off_t src_size = lseek(fd_src, 0, SEEK_END);
+		if (src_size == -1)
+			err(EXIT_FAILURE, _("cannot determine size of source file"));
+		len = src_size - *src_off;
+	}
+
+	size_t remaining = len;
+	while (remaining > 0) {
+		size_t chunk = remaining > SIZE_MAX ? SIZE_MAX : remaining;
+		ssize_t copied = copy_file_range(fd_src, src_off, fd_dst, dst_off, chunk, 0);
+		if (copied < 0) {
+			fprintf(stderr, _("failed copy file range %s at source offset %ld: %m\n"), command, *src_off);
+			rc |= 2;
+			break;
+		}
+		if (copied == 0) break;
+		remaining -= copied;
+	}
+	return rc;
+}
+
+int main(int argc, char **argv)
+{
+	char **command_files = NULL;
+	size_t ncommand_files = 0;
+	char *source_filename = NULL;
+	char *destination_filename = NULL;
+	int fd_src, fd_dst;
+	int rc = 0;
+
+	static const struct option longopts[] = {
+		{ "commands",    required_argument, NULL, 'c' },
+		{ "source",      required_argument, NULL, 's' },
+		{ "destination", required_argument, NULL, 'd' },
+		{ "version",     no_argument,       NULL, 'V' },
+		{ "help",        no_argument,       NULL, 'h' },
+		{ NULL, 0, NULL, 0 },
+	};
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	close_stdout_atexit();
+
+	int c;
+	while ((c = getopt_long (argc, argv, "c:s:d:Vh", longopts, NULL)) != -1) {
+		switch (c) {
+		case 'c':
+			if (!command_files)
+				command_files = xmalloc(sizeof(char *) * argc);
+			command_files[ncommand_files++] = xstrdup(optarg);
+			break;
+		case 's':
+			if (source_filename)
+				errx(EXIT_FAILURE, _("only one source file is allowed (%s already supplied)"), source_filename);
+			source_filename = xstrdup(optarg);
+			break;
+		case 'd':
+			if (destination_filename)
+				errx(EXIT_FAILURE, _("only one destination file is allowed (%s already supplied)"), destination_filename);
+			destination_filename = xstrdup(optarg);
+			break;
+		case 'V':
+			print_version(EXIT_SUCCESS);
+		case 'h':
+			usage();
+		}
+	}
+
+	int rem_optind;
+	for (rem_optind = optind; rem_optind < argc; rem_optind++) {
+		if (source_filename && destination_filename) break;
+		if (!source_filename)
+			source_filename = xstrdup(argv[rem_optind]);
+		else if (!destination_filename)
+			destination_filename = xstrdup(argv[rem_optind]);
+	}
+
+	if (!source_filename)
+		errx(EXIT_FAILURE, _("source file is required"));
+
+	if (!destination_filename)
+		errx(EXIT_FAILURE, _("destination file is required"));
+
+	if ((fd_src = open(source_filename, O_RDONLY)) < 0)
+		err(EXIT_FAILURE, _("cannot open source %s"), argv[1]);
+	free(source_filename);
+
+	if ((fd_dst = open(destination_filename, O_WRONLY | O_CREAT, 0666)) < 0)
+		err(EXIT_FAILURE, _("cannot open destination %s"), argv[2]);
+	free(destination_filename);
+
+	off_t src_off, dst_off;
+
+	for (size_t i = 0; i < ncommand_files; i++) {
+		FILE *f = NULL;
+
+		if (!(f = fopen(command_files[i], "r")))
+			err(EXIT_FAILURE, _("cannot open command file %s"), command_files[i]);
+		free(command_files[i]);
+
+		char *line = NULL;
+		size_t len = 0;
+
+		while (getline(&line, &len, f) != -1) {
+			rc |= handle_command(fd_src, fd_dst, &src_off, &dst_off, line);
+		}
+
+		free(line);
+		fclose(f);
+	}
+	free(command_files);
+
+	for (; rem_optind < argc; rem_optind++) {
+		rc |= handle_command(fd_src, fd_dst, &src_off, &dst_off, argv[rem_optind]);
+	}
+
+	close(fd_src);
+	close(fd_dst);
+	return rc;
+}
diff --git a/misc-utils/meson.build b/misc-utils/meson.build
index 1cd4713ce..50ec84ad8 100644
--- a/misc-utils/meson.build
+++ b/misc-utils/meson.build
@@ -229,3 +229,8 @@ lsclocks_sources = files(
   'lsclocks.c',
 )
 lsclocks_manadocs = files('lsclocks.1.adoc')
+
+copyfilerange_sources = files(
+  'copyfilerange.c',
+)
+copyfilerange_manadocs = files('copyfilerange.1.adoc')
diff --git a/tests/commands.sh b/tests/commands.sh
index 19f51529c..2e98cabdd 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -78,6 +78,7 @@ TS_CMD_COLCRT=${TS_CMD_COLCRT:-"${ts_commandsdir}colcrt"}
 TS_CMD_COLRM=${TS_CMD_COLRM:-"${ts_commandsdir}colrm"}
 TS_CMD_COL=${TS_CMD_COL:-"${ts_commandsdir}col"}
 TS_CMD_COLUMN=${TS_CMD_COLUMN:-"${ts_commandsdir}column"}
+TS_CMD_COPYFILERANGE=${TS_CMD_COPYFILERANGE:-"${ts_commandsdir}copyfilerange"}
 TS_CMD_CORESCHED=${TS_CMD_CORESCHED:-"${ts_commandsdir}coresched"}
 TS_CMD_ENOSYS=${TS_CMD_ENOSYS-"${ts_commandsdir}enosys"}
 TS_CMD_EJECT=${TS_CMD_EJECT-"${ts_commandsdir}eject"}
diff --git a/tests/expected/copyfilerange/copyfilerange b/tests/expected/copyfilerange/copyfilerange
new file mode 100644
index 000000000..240327782
--- /dev/null
+++ b/tests/expected/copyfilerange/copyfilerange
@@ -0,0 +1,4 @@
+float
+
+float
+aloof
diff --git a/tests/ts/copyfilerange/copyfilerange b/tests/ts/copyfilerange/copyfilerange
new file mode 100755
index 000000000..c81a55413
--- /dev/null
+++ b/tests/ts/copyfilerange/copyfilerange
@@ -0,0 +1,40 @@
+#!/bin/bash
+#
+# Copyright (C) 2025 Dick Marinus <dick@mrns.nl>
+#
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="copyfilerange"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_COPYFILERANGE"
+
+ts_cd "$TS_OUTDIR"
+
+{
+    echo float >  a
+    echo > b
+
+    cat a # float
+    cat b # empty
+
+    "$TS_CMD_COPYFILERANGE" a b 3::1 1::2 2::1 0::1 5::1
+
+    cat a # float
+    cat b # aloof, tribe to Donald Knuth five letter words
+} > "$TS_OUTPUT" 2>&1
+
+ts_finalize
-- 
2.51.1


Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:37317 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932317AbbD0PU5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 27 Apr 2015 11:20:57 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id ACFFDACCA
	for <util-linux@vger.kernel.org>; Mon, 27 Apr 2015 15:20:55 +0000 (UTC)
Message-ID: <553E53D7.8020800@suse.cz>
Date: Mon, 27 Apr 2015 17:20:55 +0200
From: Stanislav Brabec <sbrabec@suse.cz>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH] fsck: implement fsck -r {fd}
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Make possible sending of statistics to a dedicated file descriptor.

Rationale: When UI is calling fsck from a remote terminal, fsck progress
needs to be sent to stdout. It is mixed there with output of statistics,
and it is impossible to parse the output to get the statistics.

Now it will be possible e. g. with "fsck -C -r 3 /dev/sda1"

Note: Code in if and else is intentionally partially duplicated. Current
human readable output of floats does not conform to locale conventions,
and may be changed in future. But we want to keep machine readable output
exactly same as it is now.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 disk-utils/fsck.8 | 13 ++++++++++--
 disk-utils/fsck.c | 63 ++++++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/disk-utils/fsck.8 b/disk-utils/fsck.8
index c2bb7bf..df7d095 100644
--- a/disk-utils/fsck.8
+++ b/disk-utils/fsck.8
@@ -6,7 +6,9 @@
 fsck \- check and repair a Linux filesystem
 .SH SYNOPSIS
 .B fsck
-.RB [ \-lrsAVRTMNP ]
+.RB [ \-lsAVRTMNP ]
+.RB [ \-r
+.RI [ fd ]]
 .RB [ \-C
 .RI [ fd ]]
 .RB [ \-t
@@ -100,13 +102,20 @@ multiple devices or for non-rotating disks.  \fBfsck\fR does not lock underlying
 devices when executed to check stacked devices (e.g.\& MD or DM) \(en this feature is
 not implemented yet.
 .TP
-.B \-r
+.BR \-r \ [ \fIfd\fR ]
 Report certain statistics for each fsck when it completes.  These statistics
 include the exit status, the maximum run set size (in kilobytes), the elapsed
 all-clock time and the user and system CPU time used by the fsck run.  For
 example:
 
 /dev/sda1: status 0, rss 92828, real 4.002804, user 2.677592, sys 0.86186
+
+GUI front-ends may specify a file descriptor
+.IR fd ,
+in which case the progress bar information will be sent to that file descriptor
+in a machine parseable format.  For example:
+
+/dev/sda1 0 92828 4.002804 2.677592 0.86186
 .TP
 .B \-s
 Serialize
diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
index 299a775..27ffad3 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -141,6 +141,8 @@ static int progress;
 static int progress_fd;
 static int force_all_parallel;
 static int report_stats;
+static int report_stats_fd;
+static FILE *report_stats_file;
 
 static int num_running;
 static int max_running;
@@ -586,16 +588,28 @@ static void print_stats(struct fsck_instance *inst)
 
 	timersub(&inst->end_time, &inst->start_time, &delta);
 
-	fprintf(stdout, "%s: status %d, rss %ld, "
-			"real %ld.%06ld, user %d.%06d, sys %d.%06d\n",
-		fs_get_device(inst->fs),
-		inst->exit_status,
-		inst->rusage.ru_maxrss,
-		delta.tv_sec, delta.tv_usec,
-		(int)inst->rusage.ru_utime.tv_sec,
-		(int)inst->rusage.ru_utime.tv_usec,
-		(int)inst->rusage.ru_stime.tv_sec,
-		(int)inst->rusage.ru_stime.tv_usec);
+	if (report_stats_fd)
+		fprintf(report_stats_file, "%s %d %ld "
+					   "%ld.%06ld %d.%06d %d.%06d\n",
+			fs_get_device(inst->fs),
+			inst->exit_status,
+			inst->rusage.ru_maxrss,
+			delta.tv_sec, delta.tv_usec,
+			(int)inst->rusage.ru_utime.tv_sec,
+			(int)inst->rusage.ru_utime.tv_usec,
+			(int)inst->rusage.ru_stime.tv_sec,
+			(int)inst->rusage.ru_stime.tv_usec);
+	else
+		fprintf(stdout, "%s: status %d, rss %ld, "
+				"real %ld.%06ld, user %d.%06d, sys %d.%06d\n",
+			fs_get_device(inst->fs),
+			inst->exit_status,
+			inst->rusage.ru_maxrss,
+			delta.tv_sec, delta.tv_usec,
+			(int)inst->rusage.ru_utime.tv_sec,
+			(int)inst->rusage.ru_utime.tv_usec,
+			(int)inst->rusage.ru_stime.tv_sec,
+			(int)inst->rusage.ru_stime.tv_usec);
 }
 
 /*
@@ -1371,11 +1385,12 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -N         do not execute, just show what would be done\n"), out);
 	fputs(_(" -P         check filesystems in parallel, including root\n"), out);
 	fputs(_(" -R         skip root filesystem; useful only with '-A'\n"), out);
-	fputs(_(" -r         report statistics for each device checked\n"), out);
+	fputs(_(" -r [<fd>]  report statistics for each device checked;\n"
+		"            file descriptor is for GUIs\n"), out);
 	fputs(_(" -s         serialize the checking operations\n"), out);
 	fputs(_(" -T         do not show the title on startup\n"), out);
 	fputs(_(" -t <type>  specify filesystem types to be checked;\n"
-		"             <type> is allowed to be a comma-separated list\n"), out);
+		"            <type> is allowed to be a comma-separated list\n"), out);
 	fputs(_(" -V         explain what is being done\n"), out);
 	fputs(_(" -?         display this help and exit\n"), out);
 
@@ -1504,6 +1519,21 @@ static void parse_argv(int argc, char *argv[])
 				break;
 			case 'r':
 				report_stats = 1;
+				if (arg[j+1]) {					/* -r<fd> */
+					report_stats_fd = string_to_int(arg+j+1);
+					if (report_stats_fd < 0)
+						report_stats_fd = 0;
+					else
+						goto next_arg;
+				} else if (i+1 < argc && *argv[i+1] != '-') {	/* -r <fd> */
+					report_stats_fd = string_to_int(argv[i+1]);
+					if (report_stats_fd < 0)
+						report_stats_fd = 0;
+					else {
+						++i;
+						goto next_arg;
+					}
+				}
 				break;
 			case 's':
 				serialize = 1;
@@ -1569,6 +1599,15 @@ int main(int argc, char *argv[])
 
 	parse_argv(argc, argv);
 
+	/* Validate the report stats file descriptor to avoid disasters */
+	if (report_stats_fd) {
+		report_stats_file = fdopen(report_stats_fd, "w");
+		if (!report_stats_file)
+			err(FSCK_EX_ERROR,
+				_("invalid argument -r %d"),
+				report_stats_fd);
+	}
+
 	if (!notitle)
 		printf(UTIL_LINUX_VERSION);
 
-- 
2.3.5

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

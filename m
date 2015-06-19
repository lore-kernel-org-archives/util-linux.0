Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33184 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbbFSTlM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 19 Jun 2015 15:41:12 -0400
Received: by lbbvz5 with SMTP id vz5so30043304lbb.0
        for <util-linux@vger.kernel.org>; Fri, 19 Jun 2015 12:41:11 -0700 (PDT)
From: Boris Egorov <egorov@linux.com>
To: util-linux@vger.kernel.org
Cc: Boris Egorov <egorov@linux.com>
Subject: [PATCH 1/3] sys-utils/disk-utils/lib: fix printf format types [cppcheck]
Date: Sat, 20 Jun 2015 01:40:59 +0600
Message-Id: <1434742861-11704-2-git-send-email-egorov@linux.com>
In-Reply-To: <1434742861-11704-1-git-send-email-egorov@linux.com>
References: <1434742861-11704-1-git-send-email-egorov@linux.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Fix 'invalidPrintfArgType' cppcheck warnings

Signed-off-by: Boris Egorov <egorov@linux.com>
---
 disk-utils/fsck.cramfs.c |  6 +++---
 disk-utils/mkfs.bfs.c    |  6 +++---
 lib/cpuset.c             |  6 +++---
 sys-utils/chcpu.c        | 38 +++++++++++++++++++-------------------
 sys-utils/hwclock-rtc.c  |  2 +-
 sys-utils/ipcs.c         |  4 ++--
 sys-utils/readprofile.c  | 12 ++++++------
 7 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/disk-utils/fsck.cramfs.c b/disk-utils/fsck.cramfs.c
index 0a375f1..d5d3790 100644
--- a/disk-utils/fsck.cramfs.c
+++ b/disk-utils/fsck.cramfs.c
@@ -382,14 +382,14 @@ static void do_uncompress(char *path, int outfd, unsigned long offset,
 		offset += 4;
 		if (curr == next) {
 			if (opt_verbose > 1)
-				printf(_("  hole at %ld (%zd)\n"), curr,
+				printf(_("  hole at %lu (%zu)\n"), curr,
 				       blksize);
 			if (size < blksize)
 				out = size;
 			memset(outbuffer, 0x00, out);
 		} else {
 			if (opt_verbose > 1)
-				printf(_("  uncompressing block at %ld to %ld (%ld)\n"),
+				printf(_("  uncompressing block at %lu to %lu (%lu)\n"),
 				       curr, next, next - curr);
 			out = uncompress_block(romfs_read(curr), next - curr);
 		}
@@ -544,7 +544,7 @@ static void do_symlink(char *path, struct cramfs_inode *i)
 		xasprintf(&str, "%s -> %s", path, outbuffer);
 		print_node('l', i, str);
 		if (opt_verbose > 1)
-			printf(_("  uncompressing block at %ld to %ld (%ld)\n"),
+			printf(_("  uncompressing block at %lu to %lu (%lu)\n"),
 			       curr, next, next - curr);
 		free(str);
 	}
diff --git a/disk-utils/mkfs.bfs.c b/disk-utils/mkfs.bfs.c
index 2a22364..7057194 100644
--- a/disk-utils/mkfs.bfs.c
+++ b/disk-utils/mkfs.bfs.c
@@ -246,12 +246,12 @@ int main(int argc, char **argv)
 		fprintf(stderr, _("FSname: <%-6s>\n"), fsname);
 		fprintf(stderr, _("BlockSize: %d\n"), BFS_BLOCKSIZE);
 		if (ino_blocks == 1)
-			fprintf(stderr, _("Inodes: %lu (in 1 block)\n"),
+			fprintf(stderr, _("Inodes: %ld (in 1 block)\n"),
 				inodes);
 		else
-			fprintf(stderr, _("Inodes: %lu (in %llu blocks)\n"),
+			fprintf(stderr, _("Inodes: %ld (in %llu blocks)\n"),
 				inodes, ino_blocks);
-		fprintf(stderr, _("Blocks: %lld\n"), total_blocks);
+		fprintf(stderr, _("Blocks: %llu\n"), total_blocks);
 		fprintf(stderr, _("Inode end: %d, Data end: %d\n"),
 			le32_to_cpu(sb.s_start) - 1, le32_to_cpu(sb.s_end));
 	}
diff --git a/lib/cpuset.c b/lib/cpuset.c
index d715720..41c0eed 100644
--- a/lib/cpuset.c
+++ b/lib/cpuset.c
@@ -169,12 +169,12 @@ char *cpulist_create(char *str, size_t len,
 					break;
 			}
 			if (!run)
-				rlen = snprintf(ptr, len, "%zd,", i);
+				rlen = snprintf(ptr, len, "%zu,", i);
 			else if (run == 1) {
-				rlen = snprintf(ptr, len, "%zd,%zd,", i, i + 1);
+				rlen = snprintf(ptr, len, "%zu,%zu,", i, i + 1);
 				i++;
 			} else {
-				rlen = snprintf(ptr, len, "%zd-%zd,", i, i + run);
+				rlen = snprintf(ptr, len, "%zu-%zu,", i, i + run);
 				i += run;
 			}
 			if (rlen < 0 || (size_t) rlen + 1 > len)
diff --git a/sys-utils/chcpu.c b/sys-utils/chcpu.c
index 428fdc2..50b834c 100644
--- a/sys-utils/chcpu.c
+++ b/sys-utils/chcpu.c
@@ -84,22 +84,22 @@ static int cpu_enable(cpu_set_t *cpu_set, size_t setsize, int enable)
 		if (!CPU_ISSET(cpu, cpu_set))
 			continue;
 		if (!path_exist(_PATH_SYS_CPU "/cpu%d", cpu)) {
-			warnx(_("CPU %d does not exist"), cpu);
+			warnx(_("CPU %u does not exist"), cpu);
 			fails++;
 			continue;
 		}
 		if (!path_exist(_PATH_SYS_CPU "/cpu%d/online", cpu)) {
-			warnx(_("CPU %d is not hot pluggable"), cpu);
+			warnx(_("CPU %u is not hot pluggable"), cpu);
 			fails++;
 			continue;
 		}
 		online = path_read_s32(_PATH_SYS_CPU "/cpu%d/online", cpu);
 		if ((online == 1) && (enable == 1)) {
-			printf(_("CPU %d is already enabled\n"), cpu);
+			printf(_("CPU %u is already enabled\n"), cpu);
 			continue;
 		}
 		if ((online == 0) && (enable == 0)) {
-			printf(_("CPU %d is already disabled\n"), cpu);
+			printf(_("CPU %u is already disabled\n"), cpu);
 			continue;
 		}
 		if (path_exist(_PATH_SYS_CPU "/cpu%d/configure", cpu))
@@ -107,25 +107,25 @@ static int cpu_enable(cpu_set_t *cpu_set, size_t setsize, int enable)
 		if (enable) {
 			rc = path_write_str("1", _PATH_SYS_CPU "/cpu%d/online", cpu);
 			if ((rc == -1) && (configured == 0)) {
-				warn(_("CPU %d enable failed (CPU is deconfigured)"), cpu);
+				warn(_("CPU %u enable failed (CPU is deconfigured)"), cpu);
 				fails++;
 			} else if (rc == -1) {
-				warn(_("CPU %d enable failed"), cpu);
+				warn(_("CPU %u enable failed"), cpu);
 				fails++;
 			} else
-				printf(_("CPU %d enabled\n"), cpu);
+				printf(_("CPU %u enabled\n"), cpu);
 		} else {
 			if (onlinecpus && num_online_cpus() == 1) {
-				warnx(_("CPU %d disable failed (last enabled CPU)"), cpu);
+				warnx(_("CPU %u disable failed (last enabled CPU)"), cpu);
 				fails++;
 				continue;
 			}
 			rc = path_write_str("0", _PATH_SYS_CPU "/cpu%d/online", cpu);
 			if (rc == -1) {
-				warn(_("CPU %d disable failed"), cpu);
+				warn(_("CPU %u disable failed"), cpu);
 				fails++;
 			} else {
-				printf(_("CPU %d disabled\n"), cpu);
+				printf(_("CPU %u disabled\n"), cpu);
 				if (onlinecpus)
 					CPU_CLR(cpu, onlinecpus);
 			}
@@ -176,44 +176,44 @@ static int cpu_configure(cpu_set_t *cpu_set, size_t setsize, int configure)
 		if (!CPU_ISSET(cpu, cpu_set))
 			continue;
 		if (!path_exist(_PATH_SYS_CPU "/cpu%d", cpu)) {
-			warnx(_("CPU %d does not exist"), cpu);
+			warnx(_("CPU %u does not exist"), cpu);
 			fails++;
 			continue;
 		}
 		if (!path_exist(_PATH_SYS_CPU "/cpu%d/configure", cpu)) {
-			warnx(_("CPU %d is not configurable"), cpu);
+			warnx(_("CPU %u is not configurable"), cpu);
 			fails++;
 			continue;
 		}
 		current = path_read_s32(_PATH_SYS_CPU "/cpu%d/configure", cpu);
 		if ((current == 1) && (configure == 1)) {
-			printf(_("CPU %d is already configured\n"), cpu);
+			printf(_("CPU %u is already configured\n"), cpu);
 			continue;
 		}
 		if ((current == 0) && (configure == 0)) {
-			printf(_("CPU %d is already deconfigured\n"), cpu);
+			printf(_("CPU %u is already deconfigured\n"), cpu);
 			continue;
 		}
 		if ((current == 1) && (configure == 0) && onlinecpus &&
 		    is_cpu_online(cpu)) {
-			warnx(_("CPU %d deconfigure failed (CPU is enabled)"), cpu);
+			warnx(_("CPU %u deconfigure failed (CPU is enabled)"), cpu);
 			fails++;
 			continue;
 		}
 		if (configure) {
 			rc = path_write_str("1", _PATH_SYS_CPU "/cpu%d/configure", cpu);
 			if (rc == -1) {
-				warn(_("CPU %d configure failed"), cpu);
+				warn(_("CPU %u configure failed"), cpu);
 				fails++;
 			} else
-				printf(_("CPU %d configured\n"), cpu);
+				printf(_("CPU %u configured\n"), cpu);
 		} else {
 			rc = path_write_str("0", _PATH_SYS_CPU "/cpu%d/configure", cpu);
 			if (rc == -1) {
-				warn(_("CPU %d deconfigure failed"), cpu);
+				warn(_("CPU %u deconfigure failed"), cpu);
 				fails++;
 			} else
-				printf(_("CPU %d deconfigured\n"), cpu);
+				printf(_("CPU %u deconfigured\n"), cpu);
 		}
 	}
 
diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
index 91721f3..812b65b 100644
--- a/sys-utils/hwclock-rtc.c
+++ b/sys-utils/hwclock-rtc.c
@@ -471,7 +471,7 @@ int set_epoch_rtc(unsigned long epoch)
 	}
 
 	if (debug)
-		printf(_("setting epoch to %ld "
+		printf(_("setting epoch to %lu "
 			 "with RTC_EPOCH_SET ioctl to %s.\n"), epoch,
 		       rtc_dev_name);
 
diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index 74d8766..eaab922 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -359,7 +359,7 @@ static void do_sem (char format)
 		printf (_("max semaphores per array = %d\n"), lim.semmsl);
 		printf (_("max semaphores system wide = %d\n"), lim.semmns);
 		printf (_("max ops per semop call = %d\n"), lim.semopm);
-		printf (_("semaphore max value = %d\n"), lim.semvmx);
+		printf (_("semaphore max value = %u\n"), lim.semvmx);
 		return;
 	}
 	case STATUS:
@@ -649,7 +649,7 @@ static void print_sem(int semid)
 
 	for (i = 0; i < semdata->sem_nsems; i++) {
 		struct sem_elem *e = &semdata->elements[i];
-		printf("%-10zd %-10d %-10d %-10d %-10d\n",
+		printf("%-10zu %-10d %-10d %-10d %-10d\n",
 		       i, e->semval, e->ncount, e->zcount, e->pid);
 	}
 	printf("\n");
diff --git a/sys-utils/readprofile.c b/sys-utils/readprofile.c
index eb6b8ec..3ba866e 100644
--- a/sys-utils/readprofile.c
+++ b/sys-utils/readprofile.c
@@ -283,7 +283,7 @@ int main(int argc, char **argv)
 
 	step = buf[0];
 	if (optInfo) {
-		printf(_("Sampling_step: %i\n"), step);
+		printf(_("Sampling_step: %u\n"), step);
 		exit(EXIT_SUCCESS);
 	}
 
@@ -364,10 +364,10 @@ int main(int argc, char **argv)
 		} else if ((this || optAll) &&
 			   (fn_len = next_add - fn_add) != 0) {
 			if (optVerbose)
-				printf("%016llx %-40s %6i %8.4f\n", fn_add,
+				printf("%016llx %-40s %6u %8.4f\n", fn_add,
 				       fn_name, this, this / (double)fn_len);
 			else
-				printf("%6i %-40s %8.4f\n",
+				printf("%6u %-40s %8.4f\n",
 				       this, fn_name, this / (double)fn_len);
 			if (optSub) {
 				unsigned long long scan;
@@ -393,14 +393,14 @@ int main(int argc, char **argv)
 	}
 
 	/* clock ticks, out of kernel text - probably modules */
-	printf("%6i %s\n", buf[len / sizeof(*buf) - 1], "*unknown*");
+	printf("%6u %s\n", buf[len / sizeof(*buf) - 1], "*unknown*");
 
 	/* trailer */
 	if (optVerbose)
-		printf("%016x %-40s %6i %8.4f\n",
+		printf("%016x %-40s %6u %8.4f\n",
 		       0, "total", total, total / (double)(fn_add - add0));
 	else
-		printf("%6i %-40s %8.4f\n",
+		printf("%6u %-40s %8.4f\n",
 		       total, _("total"), total / (double)(fn_add - add0));
 
 	popenMap ? pclose(map) : fclose(map);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe util-linux" in

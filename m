Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33605 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbcGQNAZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 17 Jul 2016 09:00:25 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so8770123wme.0
        for <util-linux@vger.kernel.org>; Sun, 17 Jul 2016 06:00:24 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 01/13] misc: simplify if clauses [oclint]
Date: Sun, 17 Jul 2016 14:00:03 +0100
Message-Id: <20160717130015.31760-2-kerolasa@iki.fi>
In-Reply-To: <20160717130015.31760-1-kerolasa@iki.fi>
References: <20160717130015.31760-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/fsck.c          | 31 +++++++++++++++----------------
 disk-utils/fsck.cramfs.c   | 11 ++++-------
 disk-utils/fsck.minix.c    |  7 +++----
 disk-utils/mkfs.cramfs.c   | 15 ++++++---------
 disk-utils/mkfs.minix.c    |  8 ++------
 lib/sysfs.c                |  6 ++----
 lib/timeutils.c            |  6 ++----
 libfdisk/src/dos.c         | 26 ++++++++++++--------------
 libfdisk/src/sgi.c         |  5 ++---
 libmount/src/fs.c          |  9 ++++-----
 libmount/src/utils.c       |  6 ++----
 login-utils/sulogin.c      |  6 ++----
 login-utils/utmpdump.c     |  5 ++---
 login-utils/vipw.c         |  7 +++----
 misc-utils/cal.c           |  6 ++----
 misc-utils/mcookie.c       |  6 ++----
 misc-utils/uuidd.c         |  5 ++---
 sys-utils/dmesg.c          | 13 +++++--------
 sys-utils/ipcrm.c          |  5 ++---
 sys-utils/rtcwake.c        |  9 +++------
 sys-utils/setpriv.c        | 10 ++++------
 sys-utils/setsid.c         |  6 ++----
 term-utils/agetty.c        | 25 ++++++++++---------------
 term-utils/setterm.c       |  8 +++-----
 text-utils/hexdump-parse.c | 15 ++++++---------
 text-utils/tailf.c         |  8 +++-----
 26 files changed, 105 insertions(+), 159 deletions(-)

diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
index eede038..dd89527 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -632,22 +632,21 @@ static int execute(const char *progname, const char *progpath,
 	for (i=0; i <num_args; i++)
 		argv[argc++] = xstrdup(args[i]);
 
-	if (progress) {
-		if ((strcmp(type, "ext2") == 0) ||
-		    (strcmp(type, "ext3") == 0) ||
-		    (strcmp(type, "ext4") == 0) ||
-		    (strcmp(type, "ext4dev") == 0)) {
-			char tmp[80];
-
-			tmp[0] = 0;
-			if (!progress_active()) {
-				snprintf(tmp, 80, "-C%d", progress_fd);
-				inst->flags |= FLAG_PROGRESS;
-			} else if (progress_fd)
-				snprintf(tmp, 80, "-C%d", progress_fd * -1);
-			if (tmp[0])
-				argv[argc++] = xstrdup(tmp);
-		}
+	if (progress &&
+	       ((strcmp(type, "ext2") == 0) ||
+		(strcmp(type, "ext3") == 0) ||
+		(strcmp(type, "ext4") == 0) ||
+		(strcmp(type, "ext4dev") == 0))) {
+
+		char tmp[80];
+		tmp[0] = 0;
+		if (!progress_active()) {
+			snprintf(tmp, 80, "-C%d", progress_fd);
+			inst->flags |= FLAG_PROGRESS;
+		} else if (progress_fd)
+			snprintf(tmp, 80, "-C%d", progress_fd * -1);
+		if (tmp[0])
+			argv[argc++] = xstrdup(tmp);
 	}
 
 	argv[argc++] = xstrdup(fs_get_device(fs));
diff --git a/disk-utils/fsck.cramfs.c b/disk-utils/fsck.cramfs.c
index ef311c1..d904037 100644
--- a/disk-utils/fsck.cramfs.c
+++ b/disk-utils/fsck.cramfs.c
@@ -403,10 +403,8 @@ static void do_uncompress(char *path, int outfd, unsigned long offset,
 				     size);
 		}
 		size -= out;
-		if (*extract_dir != '\0')
-			if (write(outfd, outbuffer, out) < 0)
-				err(FSCK_EX_ERROR, _("write failed: %s"),
-				    path);
+		if (*extract_dir != '\0' && write(outfd, outbuffer, out) < 0)
+			err(FSCK_EX_ERROR, _("write failed: %s"), path);
 		curr = next;
 	} while (size);
 }
@@ -629,9 +627,8 @@ static void test_fs(int start)
 			     _("directory data end (%lu) != file data start (%lu)"),
 			     end_dir, start_data);
 	}
-	if (super.flags & CRAMFS_FLAG_FSID_VERSION_2)
-		if (end_data > super.size)
-			errx(FSCK_EX_UNCORRECTED, _("invalid file data offset"));
+	if (super.flags & CRAMFS_FLAG_FSID_VERSION_2 && end_data > super.size)
+		errx(FSCK_EX_UNCORRECTED, _("invalid file data offset"));
 
 	iput(root);		/* free(root) */
 }
diff --git a/disk-utils/fsck.minix.c b/disk-utils/fsck.minix.c
index 726f5da..97e558b 100644
--- a/disk-utils/fsck.minix.c
+++ b/disk-utils/fsck.minix.c
@@ -1333,10 +1333,9 @@ main(int argc, char **argv) {
 		usage(stderr);
 
 	check_mount();		/* trying to check a mounted filesystem? */
-	if (repair && !automatic) {
-		if (!isatty(STDIN_FILENO) || !isatty(STDOUT_FILENO))
-			die(_("need terminal for interactive repairs"));
-	}
+	if (repair && !automatic && (!isatty(STDIN_FILENO) || !isatty(STDOUT_FILENO)))
+		die(_("need terminal for interactive repairs"));
+
 	device_fd = open(device_name, repair ? O_RDWR : O_RDONLY);
 	if (device_fd < 0)
 		die(_("cannot open %s: %s"), device_name, strerror(errno));
diff --git a/disk-utils/mkfs.cramfs.c b/disk-utils/mkfs.cramfs.c
index 65ad356..bb1e4d0 100644
--- a/disk-utils/mkfs.cramfs.c
+++ b/disk-utils/mkfs.cramfs.c
@@ -313,10 +313,9 @@ static unsigned int parse_directory(struct entry *root_entry, const char *name,
 		if (dirent->d_name[0] == '.') {
 			if (dirent->d_name[1] == '\0')
 				continue;
-			if (dirent->d_name[1] == '.') {
-				if (dirent->d_name[2] == '\0')
-					continue;
-			}
+			if (dirent->d_name[1] == '.' &&
+			    dirent->d_name[2] == '\0')
+				continue;
 		}
 		namelen = strlen(dirent->d_name);
 		if (namelen > MAX_INPUT_NAMELEN) {
@@ -352,11 +351,9 @@ static unsigned int parse_directory(struct entry *root_entry, const char *name,
 			entry->size = parse_directory(root_entry, path, &entry->child, fslen_ub);
 		} else if (S_ISREG(st.st_mode)) {
 			entry->path = xstrdup(path);
-			if (entry->size) {
-				if (entry->size >= (1 << CRAMFS_SIZE_WIDTH)) {
-					warn_size = 1;
-					entry->size = (1 << CRAMFS_SIZE_WIDTH) - 1;
-				}
+			if (entry->size && entry->size >= (1 << CRAMFS_SIZE_WIDTH)) {
+				warn_size = 1;
+				entry->size = (1 << CRAMFS_SIZE_WIDTH) - 1;
 			}
 		} else if (S_ISLNK(st.st_mode)) {
 			entry->path = xstrdup(path);
diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index d4a576f..0e26966 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -669,15 +669,11 @@ static int find_super_magic(const struct fs_control *ctl)
 	case 1:
 		if (ctl->fs_namelen == 14)
 			return MINIX_SUPER_MAGIC;
-		else
-			return MINIX_SUPER_MAGIC2;
-		break;
+		return MINIX_SUPER_MAGIC2;
 	case 2:
 		if (ctl->fs_namelen == 14)
 			return MINIX2_SUPER_MAGIC;
-		else
-			return MINIX2_SUPER_MAGIC2;
-		break;
+		return MINIX2_SUPER_MAGIC2;
 	case 3:
 		return MINIX3_SUPER_MAGIC;
 	default:
diff --git a/lib/sysfs.c b/lib/sysfs.c
index f52b7a8..b52446c 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -785,10 +785,8 @@ int sysfs_devno_to_wholedisk(dev_t dev, char *diskname,
         /*
          * unpartitioned device
          */
-        if (diskname && len) {
-            if (!sysfs_get_devname(&cxt, diskname, len))
-                goto err;
-        }
+        if (diskname && len && !sysfs_get_devname(&cxt, diskname, len))
+            goto err;
         if (diskdevno)
             *diskdevno = dev;
 
diff --git a/lib/timeutils.c b/lib/timeutils.c
index fd9aa3e..608e6bd 100644
--- a/lib/timeutils.c
+++ b/lib/timeutils.c
@@ -385,10 +385,8 @@ static int format_iso_time(struct tm *tm, suseconds_t usec, int flags, char *buf
 		p += len;
 	}
 
-	if (flags & ISO_8601_TIMEZONE) {
-		if (strftime(p, bufsz, "%z", tm) <= 0)
-			return -1;
-	}
+	if (flags & ISO_8601_TIMEZONE && strftime(p, bufsz, "%z", tm) <= 0)
+		return -1;
 
 	return 0;
 }
diff --git a/libfdisk/src/dos.c b/libfdisk/src/dos.c
index b2e1c60..5ea56c2 100644
--- a/libfdisk/src/dos.c
+++ b/libfdisk/src/dos.c
@@ -1204,20 +1204,18 @@ static int add_partition(struct fdisk_context *cxt, size_t n,
 			    (uintmax_t)start,  (uintmax_t)stop, cxt->grain));
 	}
 
-	if (stop < limit) {
-		if (isrel && alignment_required(cxt)) {
-			/* the last sector has not been exactly requested (but
-			 * defined by +size{K,M,G} convention), so be smart and
-			 * align the end of the partition. The next partition
-			 * will start at phy.block boundary.
-			 */
-			stop = fdisk_align_lba_in_range(cxt, stop, start, limit);
-			if (stop > start)
-				stop -= 1;
-			if (stop > limit)
-				stop = limit;
-			DBG(LABEL, ul_debug("DOS: aligned stop: %ju", (uintmax_t) stop));
-		}
+	if (stop < limit && isrel && alignment_required(cxt)) {
+		/* the last sector has not been exactly requested (but
+		 * defined by +size{K,M,G} convention), so be smart and
+		 * align the end of the partition. The next partition
+		 * will start at phy.block boundary.
+		 */
+		stop = fdisk_align_lba_in_range(cxt, stop, start, limit);
+		if (stop > start)
+			stop -= 1;
+		if (stop > limit)
+			stop = limit;
+		DBG(LABEL, ul_debug("DOS: aligned stop: %ju", (uintmax_t) stop));
 	}
 
 	set_partition(cxt, n, 0, start, stop, sys, fdisk_partition_is_bootable(pa));
diff --git a/libfdisk/src/sgi.c b/libfdisk/src/sgi.c
index 73f9049..0ccf245 100644
--- a/libfdisk/src/sgi.c
+++ b/libfdisk/src/sgi.c
@@ -592,9 +592,8 @@ static int verify_disklabel(struct fdisk_context *cxt, int verbose)
 		if (sgi_get_num_sectors(cxt, i) != 0) {
 			Index[sortcount++] = i;
 			if (sgi_get_sysid(cxt, i) == SGI_TYPE_ENTIRE_DISK
-			    && entire++ == 1) {
-				if (verbose)
-					fdisk_info(cxt, _("More than one entire "
+			    && entire++ == 1 && verbose) {
+				fdisk_info(cxt, _("More than one entire "
 						"disk entry present."));
 			}
 		}
diff --git a/libmount/src/fs.c b/libmount/src/fs.c
index 9cb3293..c92b6ab 100644
--- a/libmount/src/fs.c
+++ b/libmount/src/fs.c
@@ -749,11 +749,10 @@ char *mnt_fs_strdup_options(struct libmnt_fs *fs)
 	res = merge_optstr(fs->vfs_optstr, fs->fs_optstr);
 	if (!res && errno)
 		return NULL;
-	if (fs->user_optstr) {
-		if (mnt_optstr_append_option(&res, fs->user_optstr, NULL)) {
-			free(res);
-			res = NULL;
-		}
+	if (fs->user_optstr &&
+	    mnt_optstr_append_option(&res, fs->user_optstr, NULL)) {
+		free(res);
+		res = NULL;
 	}
 	return res;
 }
diff --git a/libmount/src/utils.c b/libmount/src/utils.c
index 733a033..aa4bc62 100644
--- a/libmount/src/utils.c
+++ b/libmount/src/utils.c
@@ -454,10 +454,8 @@ static int check_option(const char *haystack, size_t len,
 		size_t plen = sep ? (size_t) (sep - p) :
 				    len - (p - haystack);
 
-		if (plen == needle_len) {
-			if (!strncmp(p, needle, plen))
-				return !no;	/* foo or nofoo was found */
-		}
+		if (plen == needle_len && !strncmp(p, needle, plen))
+			return !no;	/* foo or nofoo was found */
 		p += plen;
 	}
 
diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index 38ea161..fdbda7c 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -1105,10 +1105,8 @@ int main(int argc, char **argv)
 		}
 
 		signum = sigtimedwait(&set, NULL, &sigwait);
-		if (signum != SIGCHLD) {
-			if (signum < 0 && errno == EAGAIN)
-				break;
-		}
+		if (signum != SIGCHLD && signum < 0 && errno == EAGAIN)
+			break;
 
 	} while (1);
 
diff --git a/login-utils/utmpdump.c b/login-utils/utmpdump.c
index 1849a4e..cf8a50d 100644
--- a/login-utils/utmpdump.c
+++ b/login-utils/utmpdump.c
@@ -394,9 +394,8 @@ int main(int argc, char **argv)
 		in = dump(in, filename, follow, out);
 	}
 
-	if (out != stdout)
-		if (close_stream(out))
-			err(EXIT_FAILURE, _("write failed"));
+	if (out != stdout && close_stream(out))
+		err(EXIT_FAILURE, _("write failed"));
 
 	if (in && in != stdin)
 		fclose(in);
diff --git a/login-utils/vipw.c b/login-utils/vipw.c
index 2e343b6..d12ea73 100644
--- a/login-utils/vipw.c
+++ b/login-utils/vipw.c
@@ -354,10 +354,9 @@ int main(int argc, char *argv[])
 		 * which means they can be translated. */
 		printf(_("Would you like to edit %s now [y/n]? "), orig_file);
 
-		if (fgets(response, sizeof(response), stdin)) {
-			if (rpmatch(response) == RPMATCH_YES)
-				edit_file(1);
-		}
+		if (fgets(response, sizeof(response), stdin) &&
+		    rpmatch(response) == RPMATCH_YES)
+			edit_file(1);
 	}
 	exit(EXIT_SUCCESS);
 }
diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 2808793..ee8fafb 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -892,10 +892,8 @@ static int week_number(int day, int month, int32_t year, const struct cal_contro
 		month = JANUARY;
 
 	yday = day_in_year(day,month,year);
-	if (year == REFORMATION_YEAR) {
-		if (yday >= YDAY_AFTER_MISSING)
-			fday -= NUMBER_MISSING_DAYS;
-	}
+	if (year == REFORMATION_YEAR && yday >= YDAY_AFTER_MISSING)
+		fday -= NUMBER_MISSING_DAYS;
 
 	/* Last year is last year */
 	if (yday + fday < DAYS_IN_WEEK)
diff --git a/misc-utils/mcookie.c b/misc-utils/mcookie.c
index f26d4d2..ffeb36a 100644
--- a/misc-utils/mcookie.c
+++ b/misc-utils/mcookie.c
@@ -121,10 +121,8 @@ static void randomness_from_files(struct mcookie_control *ctl)
 					   "Got %zu bytes from %s\n", count),
 					count, fname);
 
-			if (fd != STDIN_FILENO)
-				if (close(fd))
-					err(EXIT_FAILURE,
-					    _("closing %s failed"), fname);
+			if (fd != STDIN_FILENO && close(fd))
+				err(EXIT_FAILURE, _("closing %s failed"), fname);
 		}
 	}
 }
diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index 4b1782a..a3fe830 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -371,9 +371,8 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 			if (ftruncate(fd_pidfile, 0))
 				err(EXIT_FAILURE, _("could not truncate file: %s"), pidfile_path);
 			write_all(fd_pidfile, reply_buf, strlen(reply_buf));
-			if (fd_pidfile > 1)
-				if (close_fd(fd_pidfile) != 0) /* Unlock the pid file */
-					err(EXIT_FAILURE, _("write failed: %s"), pidfile_path);
+			if (fd_pidfile > 1 && close_fd(fd_pidfile) != 0)
+				err(EXIT_FAILURE, _("write failed: %s"), pidfile_path);
 		}
 
 	}
diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 36c966f..4544388 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -1116,8 +1116,6 @@ static int parse_kmsg_record(struct dmesg_control *ctl,
 
 	/* D) optional fields (ignore) */
 	p = skip_item(p, end, ";");
-	if (LAST_KMSG_FIELD(p))
-		goto mesg;
 
 mesg:
 	/* E) message text */
@@ -1391,12 +1389,11 @@ int main(int argc, char *argv[])
 	if (argc > 1)
 		usage(stderr);
 
-	if (is_timefmt(&ctl, RELTIME) ||
-	    is_timefmt(&ctl, CTIME) ||
-	    is_timefmt(&ctl, ISO8601)) {
-		if (dmesg_get_boot_time(&ctl.boot_time) != 0)
-			ctl.time_fmt = DMESG_TIMEFTM_NONE;
-	}
+	if ((is_timefmt(&ctl, RELTIME) ||
+	     is_timefmt(&ctl, CTIME)   ||
+	     is_timefmt(&ctl, ISO8601))
+	    && dmesg_get_boot_time(&ctl.boot_time) != 0)
+		ctl.time_fmt = DMESG_TIMEFTM_NONE;
 
 	if (delta)
 		switch (ctl.time_fmt) {
diff --git a/sys-utils/ipcrm.c b/sys-utils/ipcrm.c
index 0b40f15..7912fee 100644
--- a/sys-utils/ipcrm.c
+++ b/sys-utils/ipcrm.c
@@ -407,9 +407,8 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (rm_all)
-		if (remove_all(what_all))
-			ret++;
+	if (rm_all && remove_all(what_all))
+		ret++;
 
 	/* print usage if we still have some arguments left over */
 	if (optind < argc) {
diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index 72894ea..053baf5 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -501,12 +501,9 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (ctl.clock_mode == CM_AUTO) {
-		if (read_clock_mode(&ctl) < 0) {
-			printf(_("%s: assuming RTC uses UTC ...\n"),
-					program_invocation_short_name);
-			ctl.clock_mode = CM_UTC;
-		}
+	if (ctl.clock_mode == CM_AUTO && read_clock_mode(&ctl) < 0) {
+		printf(_("%s: assuming RTC uses UTC ...\n"),  program_invocation_short_name);
+		ctl.clock_mode = CM_UTC;
 	}
 
 	if (ctl.verbose)
diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index 1630122..3b99a17 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -781,9 +781,8 @@ int main(int argc, char **argv)
 		errx(EXIT_FAILURE,
 		     _("--[re]gid requires --keep-groups, --clear-groups, or --groups"));
 
-	if (opts.nnp)
-		if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) == -1)
-			err(EXIT_FAILURE, _("disallow granting new privileges failed"));
+	if (opts.nnp && prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) == -1)
+		err(EXIT_FAILURE, _("disallow granting new privileges failed"));
 
 	if (opts.selinux_label)
 		do_selinux_label(opts.selinux_label);
@@ -820,9 +819,8 @@ int main(int argc, char **argv)
 			err(SETPRIV_EXIT_PRIVERR, _("setgroups failed"));
 	}
 
-	if (opts.have_securebits)
-		if (prctl(PR_SET_SECUREBITS, opts.securebits, 0, 0, 0) != 0)
-			err(SETPRIV_EXIT_PRIVERR, _("set process securebits failed"));
+	if (opts.have_securebits && prctl(PR_SET_SECUREBITS, opts.securebits, 0, 0, 0) != 0)
+		err(SETPRIV_EXIT_PRIVERR, _("set process securebits failed"));
 
 	if (opts.bounding_set) {
 		do_caps(CAPNG_BOUNDING_SET, opts.bounding_set);
diff --git a/sys-utils/setsid.c b/sys-utils/setsid.c
index bb089df..bae97ff 100644
--- a/sys-utils/setsid.c
+++ b/sys-utils/setsid.c
@@ -109,10 +109,8 @@ int main(int argc, char **argv)
 		/* cannot happen */
 		err(EXIT_FAILURE, _("setsid failed"));
 
-	if (ctty) {
-		if (ioctl(STDIN_FILENO, TIOCSCTTY, 1))
-			err(EXIT_FAILURE, _("failed to set the controlling terminal"));
-	}
+	if (ctty && ioctl(STDIN_FILENO, TIOCSCTTY, 1))
+		err(EXIT_FAILURE, _("failed to set the controlling terminal"));
 	execvp(argv[optind], argv + optind);
 	err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
 }
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index f3fc667..d5d9a91 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -502,21 +502,16 @@ int main(int argc, char **argv)
 
 	login_argv[login_argc] = NULL;	/* last login argv */
 
-	if (options.chroot) {
-		if (chroot(options.chroot) < 0)
-			log_err(_("%s: can't change root directory %s: %m"),
-				options.tty, options.chroot);
-	}
-	if (options.chdir) {
-		if (chdir(options.chdir) < 0)
-			log_err(_("%s: can't change working directory %s: %m"),
-				options.tty, options.chdir);
-	}
-	if (options.nice) {
-		if (nice(options.nice) < 0)
-			log_warn(_("%s: can't change process priority: %m"),
-				options.tty);
-	}
+	if (options.chroot && chroot(options.chroot) < 0)
+		log_err(_("%s: can't change root directory %s: %m"),
+			options.tty, options.chroot);
+	if (options.chdir && chdir(options.chdir) < 0)
+		log_err(_("%s: can't change working directory %s: %m"),
+			options.tty, options.chdir);
+	if (options.nice && nice(options.nice) < 0)
+		log_warn(_("%s: can't change process priority: %m"),
+			 options.tty);
+
 	free(options.osrelease);
 #ifdef DEBUGGING
 	if (close_stream(dbf) != 0)
diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 13836e9..704fc59 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -809,11 +809,9 @@ static void screendump(struct setterm_control *ctl)
 /* Some options are applicable when terminal is virtual console. */
 static int vc_only(struct setterm_control *ctl, const char *err)
 {
-	if (!ctl->vcterm) {
-		if (err)
-			warnx(_("terminal %s does not support %s"),
-			      ctl->opt_te_terminal_name, err);
-	}
+	if (!ctl->vcterm && err)
+		warnx(_("terminal %s does not support %s"),
+		      ctl->opt_te_terminal_name, err);
 	return ctl->vcterm;
 }
 
diff --git a/text-utils/hexdump-parse.c b/text-utils/hexdump-parse.c
index 9eb016d..c60a4d0 100644
--- a/text-utils/hexdump-parse.c
+++ b/text-utils/hexdump-parse.c
@@ -460,15 +460,12 @@ isint:				cs[3] = '\0';
 			fs->bcnt < hex->blocksize &&
 			!(fu->flags&F_SETREP) && fu->bcnt)
 				fu->reps += (hex->blocksize - fs->bcnt) / fu->bcnt;
-		if (fu->reps > 1) {
-			if (!list_empty(&fu->prlist)) {
-				pr = list_last_entry(&fu->prlist,
-				  struct hexdump_pr, prlist);
-				for (p1 = pr->fmt, p2 = NULL; *p1; ++p1)
-					p2 = isspace(*p1) ? p1 : NULL;
-				if (p2)
-					pr->nospace = p2;
-			}
+		if (fu->reps > 1 && !list_empty(&fu->prlist)) {
+			pr = list_last_entry(&fu->prlist, struct hexdump_pr, prlist);
+			for (p1 = pr->fmt, p2 = NULL; *p1; ++p1)
+				p2 = isspace(*p1) ? p1 : NULL;
+			if (p2)
+				pr->nospace = p2;
 		}
 	}
 }
diff --git a/text-utils/tailf.c b/text-utils/tailf.c
index 6219aa2..4ca5c16 100644
--- a/text-utils/tailf.c
+++ b/text-utils/tailf.c
@@ -74,11 +74,9 @@ static void tailf(const char *filename, size_t lines, struct stat *st)
 	if (data[i] == '\n')
 		lines++;
 	while (i) {
-		if (data[i] == '\n') {
-			if (--lines == 0) {
-				i++;
-				break;
-			}
+		if (data[i] == '\n' && --lines == 0) {
+			i++;
+			break;
 		}
 		i--;
 	}
-- 
2.9.0


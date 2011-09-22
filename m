Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:38616 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752625Ab1IVKMj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 22 Sep 2011 06:12:39 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id D28448F903
	for <util-linux@vger.kernel.org>; Thu, 22 Sep 2011 12:12:37 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] misc: use %m in format string instead of %s and strerror(errno)
Date: Thu, 22 Sep 2011 12:12:37 +0200
Message-Id: <1316686357-19893-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 Documentation/TODO      |    3 ---
 disk-utils/fsck.minix.c |    2 +-
 disk-utils/raw.c        |   14 ++++++--------
 fdisk/fdisk.c           |    4 ++--
 fdisk/gpt.c             |    3 +--
 hwclock/cmos.c          |   16 ++++++++--------
 include/c.h             |    2 +-
 libblkid/src/devname.c  |    3 +--
 libblkid/src/verify.c   |    8 ++++----
 libmount/src/context.c  |    2 +-
 login-utils/login.c     |    3 +--
 login-utils/vipw.c      |    3 +--
 misc-utils/blkid.c      |    2 +-
 misc-utils/uuidd.c      |   25 +++++++++----------------
 mount/fstab.c           |    2 +-
 mount/lomount.c         |    3 +--
 mount/mount.c           |    7 +++----
 mount/umount.c          |   10 ++++------
 sys-utils/chcpu.c       |   12 ++++--------
 sys-utils/ipcrm.c       |    3 +--
 sys-utils/readprofile.c |    8 ++++----
 term-utils/ttymsg.c     |    2 +-
 22 files changed, 56 insertions(+), 81 deletions(-)

diff --git a/Documentation/TODO b/Documentation/TODO
index 555f80d..4620e8a 100644
--- a/Documentation/TODO
+++ b/Documentation/TODO
@@ -149,9 +149,6 @@ login-utils:
 libblkid
 --------
 
- - remove strerrr() from debug messages (use %m) to make BLKID_DEBUG= output
-   thread-safe
-
  - (!) don't use internally blkid_loff_t, rather use off_t, size_t, ssize_t,
        stdint.h types and so on...
 
diff --git a/disk-utils/fsck.minix.c b/disk-utils/fsck.minix.c
index 0c6cfa4..eb02f9e 100644
--- a/disk-utils/fsck.minix.c
+++ b/disk-utils/fsck.minix.c
@@ -1306,7 +1306,7 @@ main(int argc, char ** argv) {
 	}
 	IN = open(device_name,repair?O_RDWR:O_RDONLY);
 	if (IN < 0)
-		die(_("unable to open '%s': %s"), device_name, strerror(errno));
+		die(_("unable to open '%s': %m"), device_name);
 	for (count=0 ; count<3 ; count++)
 		sync();
 	read_superblock();
diff --git a/disk-utils/raw.c b/disk-utils/raw.c
index 4cb74ca..84a71ec 100644
--- a/disk-utils/raw.c
+++ b/disk-utils/raw.c
@@ -142,8 +142,8 @@ int main(int argc, char *argv[])
 		err = stat(block_name, &statbuf);
 		if (err) {
 			fprintf (stderr,
-				 _("Cannot locate block device '%s' (%s)\n"),
-				 block_name, strerror(errno));
+				 _("Cannot locate block device '%s' (%m)\n"),
+				 block_name);
 			exit(2);
 		}
 
@@ -201,8 +201,8 @@ static int query(int minor_raw, const char *raw_name, int quiet)
 
 		err = stat(raw_name, &statbuf);
 		if (err) {
-			fprintf (stderr, _("Cannot locate raw device '%s' (%s)\n"),
-				 raw_name, strerror(errno));
+			fprintf (stderr, _("Cannot locate raw device '%s' (%m)\n"),
+				 raw_name);
 			exit(2);
 		}
 
@@ -227,8 +227,7 @@ static int query(int minor_raw, const char *raw_name, int quiet)
 		if (has_worked && errno == EINVAL)
 			return 0;
 		fprintf (stderr,
-			 _("Error querying raw device (%s)\n"),
-			 strerror(errno));
+			 _("Error querying raw device (%m)\n"));
 		exit(3);
 	}
 	/* If one query has worked, mark that fact so that we don't
@@ -253,8 +252,7 @@ static int bind(int minor_raw, int block_major, int block_minor)
 	err = ioctl(master_fd, RAW_SETBIND, &rq);
 	if (err < 0) {
 		fprintf (stderr,
-			 _("Error setting raw device (%s)\n"),
-			 strerror(errno));
+			 _("Error setting raw device (%m)\n"));
 		exit(3);
 	}
 	printf (_("%sraw%d:  bound to major %d, minor %d\n"),
diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 1c1f492..249de71 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -2631,10 +2631,10 @@ reread_partition_table(int leave) {
         }
 
 	if (i) {
-		printf(_("\nWARNING: Re-reading the partition table failed with error %d: %s.\n"
+		printf(_("\nWARNING: Re-reading the partition table failed with error %d: %m.\n"
 			 "The kernel still uses the old table. The new table will be used at\n"
 			 "the next reboot or after you run partprobe(8) or kpartx(8)\n"),
-			errno, strerror(errno));
+			errno);
 	}
 
 	if (dos_changed)
diff --git a/fdisk/gpt.c b/fdisk/gpt.c
index ff659fd..aeacd66 100644
--- a/fdisk/gpt.c
+++ b/fdisk/gpt.c
@@ -106,8 +106,7 @@ last_lba(int fd)
 	rc = fstat(fd, &s);
 	if (rc == -1)
 	{
-		fprintf(stderr, "last_lba() could not stat: %s\n",
-			strerror(errno));
+		fprintf(stderr, "last_lba() could not stat: %m\n");
 		return 0;
 	}
 	if (S_ISBLK(s.st_mode))
diff --git a/hwclock/cmos.c b/hwclock/cmos.c
index 09b1555..90da987 100644
--- a/hwclock/cmos.c
+++ b/hwclock/cmos.c
@@ -316,13 +316,13 @@ static inline unsigned long cmos_read(unsigned long reg)
 		lseek(dev_port_fd, clock_ctl_addr, 0);
 		if (write(dev_port_fd, &v, 1) == -1 && debug)
 			printf(_
-			       ("cmos_read(): write to control address %X failed: %s\n"),
-			       clock_ctl_addr, strerror(errno));
+			       ("cmos_read(): write to control address %X failed: %m\n"),
+			       clock_ctl_addr);
 		lseek(dev_port_fd, clock_data_addr, 0);
 		if (read(dev_port_fd, &v, 1) == -1 && debug)
 			printf(_
-			       ("cmos_read(): read data address %X failed: %s\n"),
-			       clock_data_addr, strerror(errno));
+			       ("cmos_read(): read data address %X failed: %m\n"),
+			       clock_data_addr);
 		return v;
 	} else {
 		/*
@@ -359,14 +359,14 @@ static inline unsigned long cmos_write(unsigned long reg, unsigned long val)
 		lseek(dev_port_fd, clock_ctl_addr, 0);
 		if (write(dev_port_fd, &v, 1) == -1 && debug)
 			printf(_
-			       ("cmos_write(): write to control address %X failed: %s\n"),
-			       clock_ctl_addr, strerror(errno));
+			       ("cmos_write(): write to control address %X failed: %m\n"),
+			       clock_ctl_addr);
 		v = (val & 0xff);
 		lseek(dev_port_fd, clock_data_addr, 0);
 		if (write(dev_port_fd, &v, 1) == -1 && debug)
 			printf(_
-			       ("cmos_write(): write to data address %X failed: %s\n"),
-			       clock_data_addr, strerror(errno));
+			       ("cmos_write(): write to data address %X failed: %m\n"),
+			       clock_data_addr);
 	} else {
 		outb(reg, clock_ctl_addr);
 		outb(val, clock_data_addr);
diff --git a/include/c.h b/include/c.h
index cecd05d..4beb49c 100644
--- a/include/c.h
+++ b/include/c.h
@@ -153,7 +153,7 @@ errmsg(char doexit, int excode, char adderr, const char *fmt, ...)
 			fprintf(stderr, ": ");
 	}
 	if (adderr)
-		fprintf(stderr, "%s", strerror(errno));
+		fprintf(stderr, "%m");
 	fprintf(stderr, "\n");
 	if (doexit)
 		exit(excode);
diff --git a/libblkid/src/devname.c b/libblkid/src/devname.c
index f824a17..42a8c19 100644
--- a/libblkid/src/devname.c
+++ b/libblkid/src/devname.c
@@ -260,8 +260,7 @@ static dev_t lvm_get_devno(const char *lvm_device)
 
 	DBG(DEBUG_DEVNAME, printf("opening %s\n", lvm_device));
 	if ((lvf = fopen(lvm_device, "r")) == NULL) {
-		DBG(DEBUG_DEVNAME, printf("%s: (%d) %s\n", lvm_device, errno,
-					  strerror(errno)));
+		DBG(DEBUG_DEVNAME, printf("%s: (%d) %m\n", lvm_device, errno));
 		return 0;
 	}
 
diff --git a/libblkid/src/verify.c b/libblkid/src/verify.c
index a0cb3fe..49cc6f1 100644
--- a/libblkid/src/verify.c
+++ b/libblkid/src/verify.c
@@ -60,8 +60,8 @@ blkid_dev blkid_verify(blkid_cache cache, blkid_dev dev)
 
 	if (stat(dev->bid_name, &st) < 0) {
 		DBG(DEBUG_PROBE,
-		    printf("blkid_verify: error %s (%d) while "
-			   "trying to stat %s\n", strerror(errno), errno,
+		    printf("blkid_verify: error %m (%d) while "
+			   "trying to stat %s\n", errno,
 			   dev->bid_name));
 	open_err:
 		if ((errno == EPERM) || (errno == EACCES) || (errno == ENOENT)) {
@@ -113,8 +113,8 @@ blkid_dev blkid_verify(blkid_cache cache, blkid_dev dev)
 
 	fd = open(dev->bid_name, O_RDONLY);
 	if (fd < 0) {
-		DBG(DEBUG_PROBE, printf("blkid_verify: error %s (%d) while "
-					"opening %s\n", strerror(errno), errno,
+		DBG(DEBUG_PROBE, printf("blkid_verify: error %m (%d) while "
+					"opening %s\n", errno,
 					dev->bid_name));
 		goto open_err;
 	}
diff --git a/libmount/src/context.c b/libmount/src/context.c
index e3158e4..47d3f85 100644
--- a/libmount/src/context.c
+++ b/libmount/src/context.c
@@ -1734,7 +1734,7 @@ int test_mount(struct libmnt_test *ts, int argc, char *argv[])
 
 	rc = mnt_context_mount(cxt);
 	if (rc)
-		printf("failed to mount %s\n", strerror(errno));
+		printf("failed to mount: %m\n");
 	else
 		printf("successfully mounted\n");
 
diff --git a/login-utils/login.c b/login-utils/login.c
index de56f2d..9662336 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -198,8 +198,7 @@ opentty(const char * tty) {
 
 	fd = open(tty, O_RDWR | O_NONBLOCK);
 	if (fd == -1) {
-		syslog(LOG_ERR, _("FATAL: can't reopen tty: %s"),
-		       strerror(errno));
+		syslog(LOG_ERR, _("FATAL: can't reopen tty: %m"));
 		sleepexit(EXIT_FAILURE);
 	}
 
diff --git a/login-utils/vipw.c b/login-utils/vipw.c
index d3ae51e..ddca49a 100644
--- a/login-utils/vipw.c
+++ b/login-utils/vipw.c
@@ -173,8 +173,7 @@ pw_lock(void) {
 	lockfd = open(orig_file, O_RDONLY, 0);
 
 	if (lockfd < 0) {
-		(void)fprintf(stderr, "%s: %s: %s\n",
-		    progname, orig_file, strerror(errno));
+		(void)fprintf(stderr, "%s: %s: %m\n", progname, orig_file);
 		unlink(tmp_file);
 		exit(EXIT_FAILURE);
 	}
diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index a850ac9..3608304 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -504,7 +504,7 @@ static int lowprobe_device(blkid_probe pr, const char *devname,
 
 	fd = open(devname, O_RDONLY);
 	if (fd < 0) {
-		fprintf(stderr, "error: %s: %s\n", devname, strerror(errno));
+		fprintf(stderr, "error: %s: %m\n", devname);
 		return 2;
 	}
 	if (blkid_probe_set_device(pr, fd, offset, size))
diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index b250b7a..7d152a8 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -223,8 +223,8 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 	fd_pidfile = open(pidfile_path, O_CREAT | O_RDWR, 0664);
 	if (fd_pidfile < 0) {
 		if (!quiet)
-			fprintf(stderr, _("Failed to open/create %s: %s\n"),
-				pidfile_path, strerror(errno));
+			fprintf(stderr, _("Failed to open/create %s: %m\n"),
+				pidfile_path);
 		exit(EXIT_FAILURE);
 	}
 	cleanup_pidfile = pidfile_path;
@@ -240,8 +240,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 		if ((errno == EAGAIN) || (errno == EINTR))
 			continue;
 		if (!quiet)
-			fprintf(stderr, _("Failed to lock %s: %s\n"),
-				pidfile_path, strerror(errno));
+			fprintf(stderr, _("Failed to lock %s: %m\n"), pidfile_path);
 		exit(EXIT_FAILURE);
 	}
 	ret = call_daemon(socket_path, 0, reply_buf, sizeof(reply_buf), 0, 0);
@@ -255,8 +254,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 
 	if ((s = socket(AF_UNIX, SOCK_STREAM, 0)) < 0) {
 		if (!quiet)
-			fprintf(stderr, _("Couldn't create unix stream "
-					  "socket: %s"), strerror(errno));
+			fprintf(stderr, _("Couldn't create unix stream socket: %m"));
 		exit(EXIT_FAILURE);
 	}
 
@@ -282,8 +280,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 		 sizeof(struct sockaddr_un)) < 0) {
 		if (!quiet)
 			fprintf(stderr,
-				_("Couldn't bind unix socket %s: %s\n"),
-				socket_path, strerror(errno));
+				_("Couldn't bind unix socket %s: %m\n"), socket_path);
 		exit(EXIT_FAILURE);
 	}
 	umask(save_umask);
@@ -291,8 +288,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 	if (listen(s, SOMAXCONN) < 0) {
 		if (!quiet)
 			fprintf(stderr, _("Couldn't listen on unix "
-					  "socket %s: %s\n"), socket_path,
-				strerror(errno));
+					  "socket %s: %m\n"), socket_path);
 		exit(EXIT_FAILURE);
 	}
 
@@ -538,8 +534,7 @@ int main(int argc, char **argv)
 		ret = call_daemon(socket_path, do_type + 2, buf,
 				  sizeof(buf), &num, &err_context);
 		if (ret < 0) {
-			printf(_("Error calling uuidd daemon (%s): %s\n"),
-			       err_context, strerror(errno));
+			printf(_("Error calling uuidd daemon (%s): %m\n"), err_context);
 			return EXIT_FAILURE;
 		}
 		if (do_type == UUIDD_OP_TIME_UUID) {
@@ -567,8 +562,7 @@ int main(int argc, char **argv)
 		ret = call_daemon(socket_path, do_type, (char *) &uu,
 				  sizeof(uu), 0, &err_context);
 		if (ret < 0) {
-			printf(_("Error calling uuidd daemon (%s): %s\n"),
-			       err_context, strerror(errno));
+			printf(_("Error calling uuidd daemon (%s): %m\n"), err_context);
 			return EXIT_FAILURE;
 		}
 		if (ret != sizeof(uu))
@@ -588,8 +582,7 @@ int main(int argc, char **argv)
 				if (!quiet)
 					fprintf(stderr,
 						_("Couldn't kill uuidd running "
-						  "at pid %d: %s\n"), do_kill,
-						strerror(errno));
+						  "at pid %d: %m\n"), do_kill);
 				return EXIT_FAILURE;
 			}
 			if (!quiet)
diff --git a/mount/fstab.c b/mount/fstab.c
index 77bf81c..a9dd4ae 100644
--- a/mount/fstab.c
+++ b/mount/fstab.c
@@ -1103,7 +1103,7 @@ main(int argc, char **argv)
 	nloops = atoi(argv[4]);
 
 	if (stat(filename, &st) < -1)
-		die(EXIT_FAILURE, "%s: %s\n", filename, strerror(errno));
+		die(EXIT_FAILURE, "%s: %m\n", filename);
 
 	fprintf(stderr, "%05d (pid=%05d): START\n", id, pid);
 
diff --git a/mount/lomount.c b/mount/lomount.c
index fad58d5..fb503c7 100644
--- a/mount/lomount.c
+++ b/mount/lomount.c
@@ -876,8 +876,7 @@ set_loop(const char *device, const char *file, unsigned long long offset,
 
 		if (errno == EBUSY) {
 			if (verbose)
-				printf(_("ioctl LOOP_SET_FD failed: %s\n"),
-							strerror(errno));
+				printf(_("ioctl LOOP_SET_FD failed: %m\n"));
 			rc = 2;
 		} else
 			perror("ioctl: LOOP_SET_FD");
diff --git a/mount/mount.c b/mount/mount.c
index e5e781f..77c5edc 100644
--- a/mount/mount.c
+++ b/mount/mount.c
@@ -782,10 +782,10 @@ check_special_mountprog(const char *spec, const char *node, const char *type, in
 			int i = 0;
 
 			if (setgid(getgid()) < 0)
-				die(EX_FAIL, _("mount: cannot set group id: %s"), strerror(errno));
+				die(EX_FAIL, _("mount: cannot set group id: %m"));
 
 			if (setuid(getuid()) < 0)
-				die(EX_FAIL, _("mount: cannot set user id: %s"), strerror(errno));
+				die(EX_FAIL, _("mount: cannot set user id: %m"));
 
 			oo = fix_opts_string (flags, extra_opts, NULL);
 			mountargs[i++] = mountprog;			/* 1 */
@@ -1471,8 +1471,7 @@ cdrom_setspeed(const char *spec) {
 			    _("mount: cannot open %s for setting speed"),
 			    spec);
 		if (ioctl(cdrom, CDROM_SELECT_SPEED, speed) < 0)
-			die(EX_FAIL, _("mount: cannot set speed: %s"),
-			    strerror(errno));
+			die(EX_FAIL, _("mount: cannot set speed: %m"));
 		close(cdrom);
 	}
 }
diff --git a/mount/umount.c b/mount/umount.c
index 64f320c..8e42fa7 100644
--- a/mount/umount.c
+++ b/mount/umount.c
@@ -128,10 +128,10 @@ check_special_umountprog(const char *node,
 				int i = 0;
 
 				if(setgid(getgid()) < 0)
-					die(EX_FAIL, _("umount: cannot set group id: %s"), strerror(errno));
+					die(EX_FAIL, _("umount: cannot set group id: %m"));
 
 				if(setuid(getuid()) < 0)
-					die(EX_FAIL, _("umount: cannot set user id: %s"), strerror(errno));
+					die(EX_FAIL, _("umount: cannot set user id: %m"));
 
 				umountargs[i++] = umountprog;
 				umountargs[i++] = xstrdup(node);
@@ -243,12 +243,10 @@ static const char *chdir_to_parent(const char *node, char **resbuf)
 	}
 
 	if (chdir(parent) == -1)
-		die (2, _("umount: failed to chdir to %s: %s"),
-					parent, strerror(errno));
+		die (2, _("umount: failed to chdir to %s: %m"), parent);
 
 	if (!getcwd(buf, sizeof(buf)))
-		die (2, _("umount: failed to obtain current directory: %s"),
-			strerror(errno));
+		die (2, _("umount: failed to obtain current directory: %m"));
 
 	if (strcmp(buf, parent) != 0)
 		die (2, _("umount: mountpoint moved (%s -> %s)"), parent, buf);
diff --git a/sys-utils/chcpu.c b/sys-utils/chcpu.c
index a5d12c7..2479de5 100644
--- a/sys-utils/chcpu.c
+++ b/sys-utils/chcpu.c
@@ -111,15 +111,13 @@ static int cpu_enable(cpu_set_t *cpu_set, size_t setsize, int enable)
 		if (enable) {
 			rc = write(fd, "1", 1);
 			if (rc == -1)
-				printf(_("CPU %d enable failed (%s)\n"), cpu,
-					strerror(errno));
+				printf(_("CPU %d enable failed (%m)\n"), cpu);
 			else
 				printf(_("CPU %d enabled\n"), cpu);
 		} else {
 			rc = write(fd, "0", 1);
 			if (rc == -1)
-				printf(_("CPU %d disable failed (%s)\n"), cpu,
-					strerror(errno));
+				printf(_("CPU %d disable failed (%m)\n"), cpu);
 			else
 				printf(_("CPU %d disabled\n"), cpu);
 		}
@@ -193,15 +191,13 @@ static int cpu_configure(cpu_set_t *cpu_set, size_t setsize, int configure)
 		if (configure) {
 			rc = write(fd, "1", 1);
 			if (rc == -1)
-				printf(_("CPU %d configure failed (%s)\n"), cpu,
-					strerror(errno));
+				printf(_("CPU %d configure failed (%m)\n"), cpu);
 			else
 				printf(_("CPU %d configured\n"), cpu);
 		} else {
 			rc = write(fd, "0", 1);
 			if (rc == -1)
-				printf(_("CPU %d deconfigure failed (%s)\n"), cpu,
-					strerror(errno));
+				printf(_("CPU %d deconfigure failed (%m)\n"), cpu);
 			else
 				printf(_("CPU %d deconfigured\n"), cpu);
 		}
diff --git a/sys-utils/ipcrm.c b/sys-utils/ipcrm.c
index e8d6ba6..30ec4a3 100644
--- a/sys-utils/ipcrm.c
+++ b/sys-utils/ipcrm.c
@@ -79,8 +79,7 @@ remove_ids(type_id type, int argc, char **argv) {
 			}
 
 			if (ret) {
-				printf (_("cannot remove id %s (%s)\n"),
-					argv[0], strerror(errno));
+				printf (_("cannot remove id %s (%m)\n"), argv[0]);
 				nb_errors ++;
 			}
 		}
diff --git a/sys-utils/readprofile.c b/sys-utils/readprofile.c
index 0e124bc..49f0cbd 100644
--- a/sys-utils/readprofile.c
+++ b/sys-utils/readprofile.c
@@ -211,8 +211,8 @@ main(int argc, char **argv) {
 			exit(1);
 		}
 		if (write(fd, &multiplier, to_write) != to_write) {
-			fprintf(stderr, _("readprofile: error writing %s: %s\n"),
-				defaultpro, strerror(errno));
+			fprintf(stderr, _("readprofile: error writing %s: %m\n"),
+				defaultpro);
 			exit(1);
 		}
 		close(fd);
@@ -225,7 +225,7 @@ main(int argc, char **argv) {
 	if (((proFd=open(proFile,O_RDONLY)) < 0)
 	    || ((int)(len=lseek(proFd,0,SEEK_END)) < 0)
 	    || (lseek(proFd,0,SEEK_SET) < 0)) {
-		fprintf(stderr,"%s: %s: %s\n",prgname,proFile,strerror(errno));
+		fprintf(stderr,"%s: %s: %m\n", prgname, proFile);
 		exit(1);
 	}
 
@@ -233,7 +233,7 @@ main(int argc, char **argv) {
 
 	rc = read(proFd,buf,len);
 	if (rc < 0 || (size_t) rc != len) {
-		fprintf(stderr,"%s: %s: %s\n",prgname,proFile,strerror(errno));
+		fprintf(stderr,"%s: %s: %m\n", prgname, proFile);
 		exit(1);
 	}
 	close(proFd);
diff --git a/term-utils/ttymsg.c b/term-utils/ttymsg.c
index b5c1973..5253f7a 100644
--- a/term-utils/ttymsg.c
+++ b/term-utils/ttymsg.c
@@ -97,7 +97,7 @@ ttymsg(struct iovec *iov, size_t iovcnt, char *line, int tmout) {
 			return (NULL);
 		if (strlen(strerror(errno)) > 1000)
 			return (NULL);
-		(void) sprintf(errbuf, "%s: %s", device, strerror(errno));
+		(void) sprintf(errbuf, "%s: %m", device);
 		errbuf[1024] = 0;
 		return (errbuf);
 	}
-- 
1.7.3.4


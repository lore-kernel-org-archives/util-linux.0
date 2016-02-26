Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:52499 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174AbcBZOvk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 26 Feb 2016 09:51:40 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1aZJk1-0000xZ-Qt
	for util-linux@vger.kernel.org; Fri, 26 Feb 2016 15:51:37 +0100
Received: from ppp37-190-56-35.pppoe.spdop.ru ([37.190.56.35])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 26 Feb 2016 15:51:37 +0100
Received: from yumkam by ppp37-190-56-35.pppoe.spdop.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 26 Feb 2016 15:51:37 +0100
To: util-linux@vger.kernel.org
From: yumkam@gmail.com (Yuriy M. Kaminskiy)
Subject: [PATCH] Proper fallback for systems that lacks O_CLOEXEC (was: [PATCH 12/14] lib: provide mkostemp fallback function)
Date: Fri, 26 Feb 2016 17:51:28 +0300
Message-ID: <m3y4a7msnj.fsf_-_@gmail.com>
References: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
	<1456456118-19584-1-git-send-email-sweet_f_a@gmx.de>
	<1456456118-19584-3-git-send-email-sweet_f_a@gmx.de>
	<m337sfocs8.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--=-=-=
Content-Type: text/plain

yumkam@gmail.com (Yuriy M. Kaminskiy)
writes:

> Ruediger Meier <sweet_f_a@gmx.de> writes:
>
>> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>>
[...]
> `O_CREAT`, etc; most notable, `O_CLOEXEC`; however, if `O_CLOEXEC` is missing
> on system, "c.h" defines it as 0, so it is silently ignored on those
> systems, instead of being emulated; so, whenever it matters, callers
> must call **both** `open(O_CLOEXEC)` and `fcntl(F_SETFD,FD_CLOEXEC)`]).

... something like attached below. In some cases it is maybe
unnecessary, but better safe than sorry.


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-Proper-fallback-for-systems-that-lacks-O_CLOEXEC.patch

>From 510a63401fbc251600648c803d9867bb27a9ce64 Mon Sep 17 00:00:00 2001
From: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Date: Fri, 26 Feb 2016 17:34:16 +0300
Subject: [PATCH] Proper fallback for systems that lacks O_CLOEXEC

... and fixes one missing O_CLOEXEC in open() and two missing fcntl(F_SETFD)
after dup().

Signed-off-by: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
---
Note: I intentionally ommited few cases when fd closed right away after open.

 disk-utils/fsck.c              | 1 +
 lib/blkdev.c                   | 1 +
 lib/fileutils.c                | 1 +
 lib/loopdev.c                  | 5 ++++-
 libblkid/src/evaluate.c        | 1 +
 libblkid/src/probe.c           | 2 ++
 libblkid/src/read.c            | 1 +
 libblkid/src/save.c            | 1 +
 libblkid/src/topology/md.c     | 1 +
 libblkid/src/verify.c          | 1 +
 libfdisk/src/context.c         | 1 +
 libmount/src/lock.c            | 2 ++
 libmount/src/monitor.c         | 1 +
 libmount/src/tab_parse.c       | 3 +++
 libmount/src/utils.c           | 1 +
 libsmartcols/samples/tree.c    | 1 +
 libuuid/src/gen_uuid.c         | 1 +
 login-utils/sulogin-consoles.c | 5 +++++
 misc-utils/blkid.c             | 1 +
 sys-utils/rtcwake.c            | 1 +
 sys-utils/wdctl.c              | 2 ++
 term-utils/agetty.c            | 3 +++
 22 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
index b8a47a1..f10b08e 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -375,6 +375,7 @@ static void lock_disk(struct fsck_instance *inst)
 	if (inst->lock >= 0) {
 		int rc = -1;
 
+		if (O_CLOEXEC == 0) fcntl(inst->lock, F_SETFD, FD_CLOEXEC);
 		/* inform users that we're waiting on the lock */
 		if (verbose &&
 		    (rc = flock(inst->lock, LOCK_EX | LOCK_NB)) != 0 &&
diff --git a/lib/blkdev.c b/lib/blkdev.c
index a57b367..66a472e 100644
--- a/lib/blkdev.c
+++ b/lib/blkdev.c
@@ -378,6 +378,7 @@ main(int argc, char **argv)
 
 	if ((fd = open(argv[1], O_RDONLY|O_CLOEXEC)) < 0)
 		err(EXIT_FAILURE, "open %s failed", argv[1]);
+	if (O_CLOEXEC == 0) fcntl(fd, F_SETFD, FD_CLOEXEC);
 
 	if (blkdev_get_size(fd, &bytes) < 0)
 		err(EXIT_FAILURE, "blkdev_get_size() failed");
diff --git a/lib/fileutils.c b/lib/fileutils.c
index bf8e60a..897e3ce 100644
--- a/lib/fileutils.c
+++ b/lib/fileutils.c
@@ -35,6 +35,7 @@ int xmkstemp(char **tmpname, const char *dir, const char *prefix)
 	old_mode = umask(077);
 	fd = mkostemp(localtmp, O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC);
 	umask(old_mode);
+	if (O_CLOEXEC == 0 && fd != -1) fcntl(fd, F_SETFD, FD_CLOEXEC);
 	if (fd == -1) {
 		free(localtmp);
 		localtmp = NULL;
diff --git a/lib/loopdev.c b/lib/loopdev.c
index 54c6200..dcee458 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -280,6 +280,8 @@ int loopcxt_get_fd(struct loopdev_cxt *lc)
 		lc->fd = open(lc->device, lc->mode | O_CLOEXEC);
 		DBG(CXT, ul_debugobj(lc, "open %s [%s]: %m", lc->device,
 				lc->flags & LOOPDEV_FL_RDWR ? "rw" : "ro"));
+		if (O_CLOEXEC == 0 && lc->fd != -1)
+			fcntl(lc->fd, F_SETFD, FD_CLOEXEC);
 	}
 	return lc->fd;
 }
@@ -1230,7 +1232,7 @@ int loopcxt_setup_device(struct loopdev_cxt *lc)
 
 	if ((file_fd = open(lc->filename, mode | O_CLOEXEC)) < 0) {
 		if (mode != O_RDONLY && (errno == EROFS || errno == EACCES))
-			file_fd = open(lc->filename, mode = O_RDONLY);
+			file_fd = open(lc->filename, (mode = O_RDONLY) | O_CLOEXEC);
 
 		if (file_fd < 0) {
 			DBG(SETUP, ul_debugobj(lc, "open backing file failed: %m"));
@@ -1238,6 +1240,7 @@ int loopcxt_setup_device(struct loopdev_cxt *lc)
 		}
 	}
 	DBG(SETUP, ul_debugobj(lc, "backing file open: OK"));
+	if (O_CLOEXEC == 0 && file_fd >= 0) fcntl(file_fd, F_SETFD, FD_CLOEXEC);
 
 	if (lc->fd != -1 && lc->mode != mode) {
 		DBG(SETUP, ul_debugobj(lc, "closing already open device (mode mismatch)"));
diff --git a/libblkid/src/evaluate.c b/libblkid/src/evaluate.c
index ffbe097..e3c2424 100644
--- a/libblkid/src/evaluate.c
+++ b/libblkid/src/evaluate.c
@@ -75,6 +75,7 @@ static int verify_tag(const char *devname, const char *name, const char *value)
 		errsv = errno;
 		goto done;
 	}
+	if (O_CLOEXEC == 0) fcntl(fd, F_SETFD, FD_CLOEXEC);
 	if (blkid_probe_set_device(pr, fd, 0, 0))
 		goto done;
 	rc = blkid_do_safeprobe(pr);
diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index 4efa2ba..e4c1102 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -221,6 +221,7 @@ blkid_probe blkid_new_probe_from_filename(const char *filename)
 	fd = open(filename, O_RDONLY|O_CLOEXEC);
 	if (fd < 0)
 		return NULL;
+	if (O_CLOEXEC == 0) fcntl(fd, F_SETFD, FD_CLOEXEC);
 
 	pr = blkid_new_probe();
 	if (!pr)
@@ -1156,6 +1157,7 @@ int blkid_do_probe(blkid_probe pr)
  *  <title>wipe all filesystems or raids from the device</title>
  *   <programlisting>
  *      fd = open(devname, O_RDWR|O_CLOEXEC);
+ *      if (O_CLOEXEC == 0) fcntl(fd, F_SETFD, FD_CLOEXEC);
  *      blkid_probe_set_device(pr, fd, 0, 0);
  *
  *      blkid_probe_enable_superblocks(pr, 1);
diff --git a/libblkid/src/read.c b/libblkid/src/read.c
index 41e564f..c5403fd 100644
--- a/libblkid/src/read.c
+++ b/libblkid/src/read.c
@@ -404,6 +404,7 @@ void blkid_read_cache(blkid_cache cache)
 	 */
 	if ((fd = open(cache->bic_filename, O_RDONLY|O_CLOEXEC)) < 0)
 		return;
+	if (O_CLOEXEC == 0) fcntl(fd, F_SETFD, FD_CLOEXEC);
 	if (fstat(fd, &st) < 0)
 		goto errout;
 	if ((st.st_mtime == cache->bic_ftime) ||
diff --git a/libblkid/src/save.c b/libblkid/src/save.c
index 5e8bbee..d7955f3 100644
--- a/libblkid/src/save.c
+++ b/libblkid/src/save.c
@@ -135,6 +135,7 @@ int blkid_flush_cache(blkid_cache cache)
 			sprintf(tmp, "%s-XXXXXX", filename);
 			fd = mkostemp(tmp, O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC);
 			if (fd >= 0) {
+				if (O_CLOEXEC == 0) fcntl(fd, F_SETFD, FD_CLOEXEC);
 				if (fchmod(fd, 0644) != 0)
 					DBG(SAVE, ul_debug("%s: fchmod failed", filename));
 				else if ((file = fdopen(fd, "w" UL_CLOEXECSTR)))
diff --git a/libblkid/src/topology/md.c b/libblkid/src/topology/md.c
index 5eba947..39b104a 100644
--- a/libblkid/src/topology/md.c
+++ b/libblkid/src/topology/md.c
@@ -102,6 +102,7 @@ static int probe_md_tp(blkid_probe pr,
 
                 if (fd == -1)
 			goto nothing;
+		if (O_CLOEXEC == 0) fcntl(fd, F_SETFD, FD_CLOEXEC);
 	}
 
 	memset(&md, 0, sizeof(md));
diff --git a/libblkid/src/verify.c b/libblkid/src/verify.c
index 06f6d53..bdb6551 100644
--- a/libblkid/src/verify.c
+++ b/libblkid/src/verify.c
@@ -133,6 +133,7 @@ blkid_dev blkid_verify(blkid_cache cache, blkid_dev dev)
 					dev->bid_name));
 		goto open_err;
 	}
+	if (O_CLOEXEC == 0) fcntl(fd, F_SETFD, FD_CLOEXEC);
 
 	if (blkid_probe_set_device(cache->probe, fd, 0, 0)) {
 		/* failed to read the device */
diff --git a/libfdisk/src/context.c b/libfdisk/src/context.c
index 1f6118c..b4c796e 100644
--- a/libfdisk/src/context.c
+++ b/libfdisk/src/context.c
@@ -541,6 +541,7 @@ int fdisk_assign_device(struct fdisk_context *cxt,
 	fd = open(fname, (readonly ? O_RDONLY : O_RDWR ) | O_CLOEXEC);
 	if (fd < 0)
 		return -errno;
+	if (O_CLOEXEC == 0) fcntl(fd, F_SETFD, FD_CLOEXEC);
 
 	cxt->readonly = readonly;
 	cxt->dev_fd = fd;
diff --git a/libmount/src/lock.c b/libmount/src/lock.c
index 0d94329..ca218eb 100644
--- a/libmount/src/lock.c
+++ b/libmount/src/lock.c
@@ -220,6 +220,7 @@ static int lock_simplelock(struct libmnt_lock *ml)
 		rc = -errno;
 		goto err;
 	}
+	if (O_CLOEXEC == 0) fcntl(ml->lockfile_fd, F_SETFD, FD_CLOEXEC);
 
 	while (flock(ml->lockfile_fd, LOCK_EX) < 0) {
 		int errsv;
@@ -449,6 +450,7 @@ static int lock_mtab(struct libmnt_lock *ml)
 				rc = -errsv;
 			goto failed;
 		}
+		if (O_CLOEXEC == 0) fcntl(ml->lockfile_fd, F_SETFD, FD_CLOEXEC);
 
 		flock.l_type = F_WRLCK;
 		flock.l_whence = SEEK_SET;
diff --git a/libmount/src/monitor.c b/libmount/src/monitor.c
index 9bc7ea3..b274c6c 100644
--- a/libmount/src/monitor.c
+++ b/libmount/src/monitor.c
@@ -458,6 +458,7 @@ static int kernel_monitor_get_fd(struct libmnt_monitor *mn,
 	me->fd = open(me->path, O_RDONLY|O_CLOEXEC);
 	if (me->fd < 0)
 		goto err;
+	if (O_CLOEXEC == 0) fcntl(me->fd, F_SETFD, FD_CLOEXEC);
 
 	return me->fd;
 err:
diff --git a/libmount/src/tab_parse.c b/libmount/src/tab_parse.c
index 4c47390..b3219cb 100644
--- a/libmount/src/tab_parse.c
+++ b/libmount/src/tab_parse.c
@@ -741,6 +741,7 @@ static int __mnt_table_parse_dir(struct libmnt_table *tb, const char *dirname)
 	dd = open(dirname, O_RDONLY|O_CLOEXEC|O_DIRECTORY);
 	if (dd < 0)
 	        return -errno;
+	if (O_CLOEXEC == 0) fcntl(dd, F_SETFD, FD_CLOEXEC);
 
 	n = scandirat(dd, ".", &namelist, mnt_table_parse_dir_filter, versionsort);
 	if (n <= 0) {
@@ -759,6 +760,7 @@ static int __mnt_table_parse_dir(struct libmnt_table *tb, const char *dirname)
 
 		f = fopen_at(dd, ".", d->d_name, O_RDONLY|O_CLOEXEC, "r" UL_CLOEXECSTR);
 		if (f) {
+			if (O_CLOEXEC == 0) fcntl(fileno(f), F_SETFD, FD_CLOEXEC);
 			mnt_table_parse_stream(tb, f, d->d_name);
 			fclose(f);
 		}
@@ -800,6 +802,7 @@ static int __mnt_table_parse_dir(struct libmnt_table *tb, const char *dirname)
 		f = fopen_at(dirfd(dir), _PATH_MNTTAB_DIR, d->d_name,
 				O_RDONLY|O_CLOEXEC, "r" UL_CLOEXECSTR);
 		if (f) {
+			if (O_CLOEXEC == 0) fcntl(fileno(f), F_SETFD, FD_CLOEXEC);
 			mnt_table_parse_stream(tb, f, d->d_name);
 			fclose(f);
 		}
diff --git a/libmount/src/utils.c b/libmount/src/utils.c
index 39f6c85..98820fd 100644
--- a/libmount/src/utils.c
+++ b/libmount/src/utils.c
@@ -943,6 +943,7 @@ int mnt_open_uniq_filename(const char *filename, char **name)
 		fd = -errno;
 	umask(oldmode);
 
+	if (O_CLOEXEC == 0 && fd >= 0) fcntl(fd, F_SETFD, FD_CLOEXEC);
 	if (fd >= 0 && name)
 		*name = n;
 	else
diff --git a/libsmartcols/samples/tree.c b/libsmartcols/samples/tree.c
index 7f41f9e..1e262c6 100644
--- a/libsmartcols/samples/tree.c
+++ b/libsmartcols/samples/tree.c
@@ -94,6 +94,7 @@ static int add_line_from_stat(struct libscols_table *tb,
 		else
 			fd = open(name, O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC);
 		if (fd >= 0) {
+			if (O_CLOEXEC == 0) fcntl(fd, F_SETFD, FD_CLOEXEC);
 			rc = add_children(tb, ln, fd);
 			close(fd);
 		}
diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index 4d60997..c8c1e18 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -236,6 +236,7 @@ static int get_clock(uint32_t *clock_high, uint32_t *clock_low,
 		state_fd = open(LIBUUID_CLOCK_FILE, O_RDWR|O_CREAT|O_CLOEXEC, 0660);
 		(void) umask(save_umask);
 		if (state_fd != -1) {
+			if (O_CLOEXEC == 0) fcntl(state_fd, F_SETFD, FD_CLOEXEC);
 			state_f = fdopen(state_fd, "r+" UL_CLOEXECSTR);
 			if (!state_f) {
 				close(state_fd);
diff --git a/login-utils/sulogin-consoles.c b/login-utils/sulogin-consoles.c
index 1b05b38..36c2f58 100644
--- a/login-utils/sulogin-consoles.c
+++ b/login-utils/sulogin-consoles.c
@@ -476,6 +476,7 @@ static int detect_consoles_from_cmdline(struct list_head *consoles)
 			continue;
 		}
 		free(name);
+		if (O_CLOEXEC == 0) fcntl(fd, F_SETFD, FD_CLOEXEC);
 #ifdef TIOCGDEV
 		if (ioctl (fd, TIOCGDEV, &devnum) < 0) {
 			close(fd);
@@ -537,6 +538,8 @@ static int detect_consoles_from_tiocgdev(struct list_head *consoles,
 
 	if (fd < 0)
 		goto done;
+	/* XXX dup() clears close-on-exec */
+	/*if (O_CLOEXEC == 0) */fcntl(fd, F_SETFD, FD_CLOEXEC);
 	if (ioctl (fd, TIOCGDEV, &devnum) < 0)
 		goto done;
 
@@ -620,6 +623,8 @@ int detect_consoles(const char *device, int fallback, struct list_head *consoles
 		close(fd);
 		goto fallback;
 #endif
+		/* XXX dup() clears close-on-exec */
+		/*if (O_CLOEXEC == 0) */fcntl(fd, F_SETFD, FD_CLOEXEC);
 		DBG(dbgprint("trying device/fallback file descriptor"));
 
 		if (fstat(fd, &st) < 0) {
diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 4ecbb5d..a4f05df 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -489,6 +489,7 @@ static int lowprobe_device(blkid_probe pr, const char *devname,
 		fprintf(stderr, "error: %s: %m\n", devname);
 		return BLKID_EXIT_NOTFOUND;
 	}
+	if (O_CLOEXEC == 0) fcntl(fd, F_SETFD, FD_CLOEXEC);
 	if (blkid_probe_set_device(pr, fd, offset, size))
 		goto done;
 
diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index 842ea50..a89220c 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -374,6 +374,7 @@ static int open_dev_rtc(const char *devname)
 	fd = open(devpath, O_RDONLY | O_CLOEXEC);
 	if (fd < 0)
 		err(EXIT_FAILURE, _("%s: unable to find device"), devpath);
+	if (O_CLOEXEC == 0) fcntl(fd, F_SETFD, FD_CLOEXEC);
 	free(devpath);
 	return fd;
 }
diff --git a/sys-utils/wdctl.c b/sys-utils/wdctl.c
index 095d8ed..e09f031 100644
--- a/sys-utils/wdctl.c
+++ b/sys-utils/wdctl.c
@@ -313,6 +313,7 @@ static int set_watchdog(struct wdinfo *wd, int timeout)
 	sigprocmask(SIG_BLOCK, &sigs, &oldsigs);
 
 	fd = open(wd->device, O_WRONLY|O_CLOEXEC);
+	/* Static_assert(O_CLOEXEC != 0); */
 
 	if (fd < 0) {
 		if (errno == EBUSY)
@@ -369,6 +370,7 @@ static int read_watchdog(struct wdinfo *wd)
 	sigprocmask(SIG_BLOCK, &sigs, &oldsigs);
 
 	fd = open(wd->device, O_WRONLY|O_CLOEXEC);
+	/* Static_assert(O_CLOEXEC != 0); */
 
 	if (fd < 0) {
 		if (errno == EBUSY)
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index cd57c67..812875a 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -1623,6 +1623,8 @@ static int wait_for_term_input(int fd)
 					O_CREAT|O_CLOEXEC|O_RDONLY,
 					S_IRUSR|S_IWUSR);
 
+		/* Static_assert(O_CLOEXEC != 0); */
+
 		/* initialize reload trigger inotify stuff */
 		if (reload_fd >= 0) {
 			inotify_fd = inotify_init1(IN_NONBLOCK | IN_CLOEXEC);
@@ -2623,6 +2625,7 @@ static void reload_agettys(void)
 #ifdef AGETTY_RELOAD
 	int fd = open(AGETTY_RELOAD_FILENAME, O_CREAT|O_CLOEXEC|O_WRONLY,
 					      S_IRUSR|S_IWUSR);
+	/* Static_assert(O_CLOEXEC != 0); */
 	if (fd < 0)
 		err(EXIT_FAILURE, _("cannot open %s"), AGETTY_RELOAD_FILENAME);
 
-- 
2.1.4


--=-=-=--


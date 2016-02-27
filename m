Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:44753 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756331AbcB0Q1l (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 27 Feb 2016 11:27:41 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1aZhiU-0005by-DJ
	for util-linux@vger.kernel.org; Sat, 27 Feb 2016 17:27:38 +0100
Received: from ppp37-190-56-35.pppoe.spdop.ru ([37.190.56.35])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sat, 27 Feb 2016 17:27:38 +0100
Received: from yumkam by ppp37-190-56-35.pppoe.spdop.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sat, 27 Feb 2016 17:27:38 +0100
To: util-linux@vger.kernel.org
From: yumkam@gmail.com (Yuriy M. Kaminskiy)
Subject: [PATCH 3/3] snprintf: safer (and uniform) handling of return value
Date: Sat, 27 Feb 2016 19:27:29 +0300
Message-ID: <m3io1am83y.fsf_-_@gmail.com>
References: <m3r3fymc4d.fsf@gmail.com> <m3mvqmm8p7.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/x-diff
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>From aa9e84c4c9a7e35e76a4856de98c73c12318fa44 Mon Sep 17 00:00:00 2001
From: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Date: Fri, 26 Feb 2016 16:05:29 +0300
Subject: [PATCH 3/3] snprintf: safer (and uniform) handling of return value

When `rc` is `INT_MAX`, `rc + 1` result in signed integer overflow.
---
Note: likely impossible to trigger, so this only fixes "formal correctness".

 disk-utils/fsck.c      |  2 +-
 lib/at.c               |  6 +++---
 lib/cpuset.c           |  7 ++-----
 lib/sysfs.c            | 12 ++++++------
 libfdisk/src/ask.c     |  8 ++------
 login-utils/login.c    |  2 +-
 login-utils/lslogins.c |  2 +-
 misc-utils/cal.c       |  7 ++++++-
 sys-utils/lscpu.c      |  8 ++++++--
 sys-utils/mountpoint.c |  2 +-
 term-utils/agetty.c    |  4 ++--
 term-utils/ttymsg.c    |  8 ++++----
 term-utils/wall.c      |  4 ++--
 13 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
index 83053cd..f859055 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -316,7 +316,7 @@ static int is_irrotational_disk(dev_t disk)
 			"/sys/dev/block/%d:%d/queue/rotational",
 			major(disk), minor(disk));
 
-	if (rc < 0 || (unsigned int) (rc + 1) > sizeof(path))
+	if (rc < 0 || (unsigned int) rc >= sizeof(path))
 		return 0;
 
 	f = fopen(path, "r");
diff --git a/lib/at.c b/lib/at.c
index f7074bb..4086a25 100644
--- a/lib/at.c
+++ b/lib/at.c
@@ -31,7 +31,7 @@ int fstat_at(int dir __attribute__ ((__unused__)), const char *dirname,
 		int len;
 
 		len = snprintf(path, sizeof(path), "%s/%s", dirname, filename);
-		if (len < 0 || len + 1 > sizeof(path))
+		if (len < 0 || (size_t)len >= sizeof(path))
 			return -1;
 
 		return nofollow ? lstat(path, st) : stat(path, st);
@@ -56,7 +56,7 @@ int open_at(int dir __attribute__((__unused__)), const char *dirname,
 		int len;
 
 		len = snprintf(path, sizeof(path), "%s/%s", dirname, filename);
-		if (len < 0 || len + 1 > sizeof(path))
+		if (len < 0 || (size_t)len >= sizeof(path))
 			return -1;
 
 		return open(path, flags);
@@ -91,7 +91,7 @@ ssize_t readlink_at(int dir __attribute__((__unused__)), const char *dirname,
 		int len;
 
 		len = snprintf(path, sizeof(path), "%s/%s", dirname, pathname);
-		if (len < 0 || len + 1 > sizeof(path))
+		if (len < 0 || (size_t)len >= sizeof(path))
 			return -1;
 
 		return readlink(path, buf, bufsiz);
diff --git a/lib/cpuset.c b/lib/cpuset.c
index 41c0eed..7445ab4 100644
--- a/lib/cpuset.c
+++ b/lib/cpuset.c
@@ -177,13 +177,10 @@ char *cpulist_create(char *str, size_t len,
 				rlen = snprintf(ptr, len, "%zu-%zu,", i, i + run);
 				i += run;
 			}
-			if (rlen < 0 || (size_t) rlen + 1 > len)
+			if (rlen < 0 || (size_t) rlen >= len)
 				return NULL;
 			ptr += rlen;
-			if (rlen > 0 && len > (size_t) rlen)
-				len -= rlen;
-			else
-				len = 0;
+			len -= rlen;
 		}
 	}
 	ptr -= entry_made;
diff --git a/lib/sysfs.c b/lib/sysfs.c
index 9d76148..b6e0b72 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -26,7 +26,7 @@ char *sysfs_devno_attribute_path(dev_t devno, char *buf,
 		len = snprintf(buf, bufsiz, _PATH_SYS_DEVBLOCK "/%d:%d",
 			major(devno), minor(devno));
 
-	return (len < 0 || (size_t) len + 1 > bufsiz) ? NULL : buf;
+	return (len < 0 || (size_t) len >= bufsiz) ? NULL : buf;
 }
 
 int sysfs_devno_has_attribute(dev_t devno, const char *attr)
@@ -82,7 +82,7 @@ dev_t sysfs_devname_to_devno(const char *name, const char *parent)
 				_PATH_SYS_BLOCK "/%s/%s/dev", _parent, _name);
 		free(_name);
 		free(_parent);
-		if (len < 0 || (size_t) len + 1 > sizeof(buf))
+		if (len < 0 || (size_t) len >= sizeof(buf))
 			return 0;
 		path = buf;
 
@@ -100,7 +100,7 @@ dev_t sysfs_devname_to_devno(const char *name, const char *parent)
 		len = snprintf(buf, sizeof(buf),
 				_PATH_SYS_BLOCK "/%s/dev", _name);
 		free(_name);
-		if (len < 0 || (size_t) len + 1 > sizeof(buf))
+		if (len < 0 || (size_t) len >= sizeof(buf))
 			return 0;
 		path = buf;
 	}
@@ -463,7 +463,7 @@ int sysfs_write_u64(struct sysfs_cxt *cxt, const char *attr, uint64_t num)
 		return -errno;
 
 	len = snprintf(buf, sizeof(buf), "%" PRIu64, num);
-	if (len < 0 || (size_t) len + 1 > sizeof(buf))
+	if (len < 0 || (size_t) len >= sizeof(buf))
 		rc = len < 0 ? -errno : -E2BIG;
 	else
 		rc = write_all(fd, buf, len);
@@ -930,7 +930,7 @@ static char *sysfs_scsi_host_attribute_path(struct sysfs_cxt *cxt,
 		len = snprintf(buf, bufsz, _PATH_SYS_CLASS "/%s_host/host%d",
 				type, host);
 
-	return (len < 0 || (size_t) len + 1 > bufsz) ? NULL : buf;
+	return (len < 0 || (size_t) len >= bufsz) ? NULL : buf;
 }
 
 char *sysfs_scsi_host_strdup_attribute(struct sysfs_cxt *cxt,
@@ -979,7 +979,7 @@ static char *sysfs_scsi_attribute_path(struct sysfs_cxt *cxt,
 	else
 		len = snprintf(buf, bufsz, _PATH_SYS_SCSI "/devices/%d:%d:%d:%d",
 				h,c,t,l);
-	return (len < 0 || (size_t) len + 1 > bufsz) ? NULL : buf;
+	return (len < 0 || (size_t) len >= bufsz) ? NULL : buf;
 }
 
 int sysfs_scsi_has_attribute(struct sysfs_cxt *cxt, const char *attr)
diff --git a/libfdisk/src/ask.c b/libfdisk/src/ask.c
index d81ebd7..611208a 100644
--- a/libfdisk/src/ask.c
+++ b/libfdisk/src/ask.c
@@ -383,15 +383,11 @@ static char *mk_string_list(char *ptr, size_t *len, size_t *begin,
 			snprintf(ptr, *len, "%c-%c,", tochar(*begin), tochar(*begin + *run)) :
 			snprintf(ptr, *len, "%zu-%zu,", *begin, *begin + *run);
 
-	if (rlen < 0 || (size_t) rlen + 1 > *len)
+	if (rlen < 0 || (size_t) rlen >= *len)
 		return NULL;
 
 	ptr += rlen;
-
-	if (rlen > 0 && *len > (size_t) rlen)
-		*len -= rlen;
-	else
-		*len = 0;
+	*len -= rlen;
 
 	if (cur == -1 && *begin) {
 		/* end of the list */
diff --git a/login-utils/login.c b/login-utils/login.c
index 6f51039..e48625f 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -1056,7 +1056,7 @@ static void init_environ(struct login_context *cxt)
 
 	/* mailx will give a funny error msg if you forget this one */
 	len = snprintf(tmp, sizeof(tmp), "%s/%s", _PATH_MAILDIR, pwd->pw_name);
-	if (len > 0 && (size_t) len + 1 <= sizeof(tmp))
+	if (len > 0 && (size_t) len < sizeof(tmp))
 		setenv("MAIL", tmp, 0);
 
 	/* LOGNAME is not documented in login(1) but HP-UX 6.5 does it. We'll
diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index f9b9d40..40a1343 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -397,7 +397,7 @@ again:
 			x = snprintf(p, len, "%s,", grp->gr_name);
 		}
 
-		if (x < 0 || (size_t) x + 1 > len) {
+		if (x < 0 || (size_t) x >= len) {
 			size_t cur = p - res;
 
 			maxlen *= 2;
diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index b7f3827..c687c6c 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -514,10 +514,15 @@ static void headers_init(struct cal_control *ctl)
 	size_t i, wd;
 	char *cur_dh = day_headings;
 	char tmp[FMT_ST_CHARS];
-	size_t year_len;
+	int year_len;
 
 	year_len = snprintf(tmp, sizeof(tmp), "%d", ctl->req.year);
 
+	if (year_len < 0 || (size_t)year_len >= sizeof(tmp)) {
+		/* XXX impossible error */
+		return;
+	}
+
 	for (i = 0; i < DAYS_IN_WEEK; i++) {
 		size_t space_left;
 		wd = (i + ctl->weekstart) % DAYS_IN_WEEK;
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 318249f..fc32762 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -1273,12 +1273,14 @@ get_cell_data(struct lscpu_desc *desc, int idx, int col,
 			if (cpuset_ary_isset(cpu, ca->sharedmaps,
 					     ca->nsharedmaps, setsize, &i) == 0) {
 				int x = snprintf(p, sz, "%zu", i);
-				if (x <= 0 || (size_t) x + 2 >= sz)
+				if (x < 0 || (size_t) x >= sz)
 					return NULL;
 				p += x;
 				sz -= x;
 			}
 			if (j != 0) {
+				if (sz < 2)
+					return NULL;
 				*p++ = mod->compat ? ',' : ':';
 				*p = '\0';
 				sz--;
@@ -1346,11 +1348,13 @@ get_cell_header(struct lscpu_desc *desc, int col,
 
 		for (i = desc->ncaches - 1; i >= 0; i--) {
 			int x = snprintf(p, sz, "%s", desc->caches[i].name);
-			if (x <= 0 || (size_t) x + 2 > sz)
+			if (x < 0 || (size_t) x >= sz)
 				return NULL;
 			sz -= x;
 			p += x;
 			if (i > 0) {
+				if (sz < 2)
+					return NULL;
 				*p++ = mod->compat ? ',' : ':';
 				*p = '\0';
 				sz--;
diff --git a/sys-utils/mountpoint.c b/sys-utils/mountpoint.c
index a43bfd6..ad9c1da 100644
--- a/sys-utils/mountpoint.c
+++ b/sys-utils/mountpoint.c
@@ -71,7 +71,7 @@ static int dir_to_device(struct mountpoint_control *ctl)
 		len = snprintf(buf, sizeof(buf), "%s/..", cn ? cn : ctl->path);
 		free(cn);
 
-		if (len < 0 || (size_t) len + 1 > sizeof(buf))
+		if (len < 0 || (size_t) len >= sizeof(buf))
 			return -1;
 		if (stat(buf, &pst) !=0)
 			return -1;
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 8a70651..3896ea2 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -1001,8 +1001,8 @@ static void open_tty(char *tty, struct termios *tp, struct options *op)
 		if ((gr = getgrnam("tty")))
 			gid = gr->gr_gid;
 
-		if (((len = snprintf(buf, sizeof(buf), "/dev/%s", tty)) >=
-		     (int)sizeof(buf)) || (len < 0))
+		len = snprintf(buf, sizeof(buf), "/dev/%s", tty);
+		if (len < 0 || (size_t)len >= sizeof(buf))
 			log_err(_("/dev/%s: cannot open as standard input: %m"), tty);
 
 		/* Open the tty as standard input. */
diff --git a/term-utils/ttymsg.c b/term-utils/ttymsg.c
index 18a723f..2aab69f 100644
--- a/term-utils/ttymsg.c
+++ b/term-utils/ttymsg.c
@@ -90,7 +90,7 @@ ttymsg(struct iovec *iov, size_t iovcnt, char *line, int tmout) {
 	   also wrong since people use /dev/pts/xxx. */
 
 	len = snprintf(device, sizeof(device), "%s%s", _PATH_DEV, line);
-	if (len < 0 || len + 1 > (ssize_t) sizeof(device)) {
+	if (len < 0 || (size_t)len >= sizeof(device)) {
 		snprintf(errbuf, sizeof(errbuf), _("excessively long line arg"));
 		return errbuf;
 	}
@@ -104,7 +104,7 @@ ttymsg(struct iovec *iov, size_t iovcnt, char *line, int tmout) {
 			return NULL;
 
 		len = snprintf(errbuf, sizeof(errbuf), "%s: %m", device);
-		if (len < 0 || len + 1 > (ssize_t) sizeof(errbuf))
+		if (len < 0 || (size_t)len >= sizeof(errbuf))
 			snprintf(errbuf, sizeof(errbuf), _("open failed"));
 		return errbuf;
 	}
@@ -145,7 +145,7 @@ ttymsg(struct iovec *iov, size_t iovcnt, char *line, int tmout) {
 			cpid = fork();
 			if (cpid < 0) {
 				len = snprintf(errbuf, sizeof(errbuf), _("fork: %m"));
-				if (len < 0 || len + 1 > (ssize_t) sizeof(errbuf))
+				if (len < 0 || (size_t)len >= sizeof(errbuf))
 					snprintf(errbuf, sizeof(errbuf), _("cannot fork"));
 				close(fd);
 				return errbuf;
@@ -177,7 +177,7 @@ ttymsg(struct iovec *iov, size_t iovcnt, char *line, int tmout) {
 			_exit(EXIT_FAILURE);
 
 		len = snprintf(errbuf, sizeof(errbuf), "%s: %m", device);
-		if (len < 0 || len + 1 > (ssize_t) sizeof(errbuf))
+		if (len < 0 || (size_t)len >= sizeof(errbuf))
 			snprintf(errbuf, sizeof(errbuf),
 					_("%s: BAD ERROR, message is "
 					  "far too long"), device);
diff --git a/term-utils/wall.c b/term-utils/wall.c
index 7d0dfe7..1253d32 100644
--- a/term-utils/wall.c
+++ b/term-utils/wall.c
@@ -217,8 +217,8 @@ static void buf_printf(struct buffer *bs, const char *fmt, ...)
 	rc = vsnprintf(bs->data + bs->used, limit, fmt, ap);
 	va_end(ap);
 
-	if (rc > 0 && (size_t) rc + 1 > limit) {	/* not enoght, enlarge */
-		buf_enlarge(bs, rc + 1);
+	if (rc >= 0 && (size_t) rc >= limit) {	/* not enoght, enlarge */
+		buf_enlarge(bs, (size_t)rc + 1);
 		limit = bs->sz - bs->used;
 		va_start(ap, fmt);
 		rc = vsnprintf(bs->data  + bs->used, limit, fmt, ap);;
-- 
2.1.4



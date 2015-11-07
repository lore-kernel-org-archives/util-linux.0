Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-io0-f170.google.com ([209.85.223.170]:35614 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326AbbKGAke (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 6 Nov 2015 19:40:34 -0500
Received: by ioc74 with SMTP id 74so73086246ioc.2
        for <util-linux@vger.kernel.org>; Fri, 06 Nov 2015 16:40:34 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: util-linux@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH 1/2] losetup: support ioctl cmd of LOOP_SET_DIRECT_IO
Date: Sat,  7 Nov 2015 08:40:17 +0800
Message-Id: <1446856818-26532-2-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1446856818-26532-1-git-send-email-tom.leiming@gmail.com>
References: <1446856818-26532-1-git-send-email-tom.leiming@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>From v4.4, linux kernel starts to support direct I/O and
AIO to backing file for loop driver, so allow losetup to
enable the feature by using LOOP_SET_DIRECT_IO ioctl cmd.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 include/loopdev.h   |  2 ++
 lib/loopdev.c       | 18 ++++++++++++++++++
 sys-utils/losetup.c | 24 +++++++++++++++++++++---
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/include/loopdev.h b/include/loopdev.h
index 573a569..9a7f6ba 100644
--- a/include/loopdev.h
+++ b/include/loopdev.h
@@ -23,6 +23,7 @@
 #define LOOP_GET_STATUS64	0x4C05
 /* #define LOOP_CHANGE_FD	0x4C06 */
 #define LOOP_SET_CAPACITY	0x4C07
+#define LOOP_SET_DIRECT_IO	0x4C08
 
 /* /dev/loop-control interface */
 #ifndef LOOP_CTL_ADD
@@ -164,6 +165,7 @@ extern int loopcxt_next(struct loopdev_cxt *lc);
 extern int loopcxt_setup_device(struct loopdev_cxt *lc);
 extern int loopcxt_delete_device(struct loopdev_cxt *lc);
 extern int loopcxt_set_capacity(struct loopdev_cxt *lc);
+extern int loopcxt_set_dio(struct loopdev_cxt *lc, unsigned long use_dio);
 
 int loopcxt_set_offset(struct loopdev_cxt *lc, uint64_t offset);
 int loopcxt_set_sizelimit(struct loopdev_cxt *lc, uint64_t sizelimit);
diff --git a/lib/loopdev.c b/lib/loopdev.c
index fe047cd..ff99dd4 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -1315,6 +1315,24 @@ int loopcxt_set_capacity(struct loopdev_cxt *lc)
 	return 0;
 }
 
+int loopcxt_set_dio(struct loopdev_cxt *lc, unsigned long use_dio)
+{
+	int fd = loopcxt_get_fd(lc);
+
+	if (fd < 0)
+		return -EINVAL;
+
+	/* Kernels prior to v4.4 don't support this ioctl */
+	if (ioctl(fd, LOOP_SET_DIRECT_IO, use_dio) < 0) {
+		int rc = -errno;
+		DBG(CXT, ul_debugobj(lc, "LOOP_SET_DIRECT_IO failed: %m"));
+		return rc;
+	}
+
+	DBG(CXT, ul_debugobj(lc, "direct io set"));
+	return 0;
+}
+
 int loopcxt_delete_device(struct loopdev_cxt *lc)
 {
 	int fd = loopcxt_get_fd(lc);
diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index a68b222..8403621 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -35,6 +35,7 @@ enum {
 	A_SHOW_ONE,		/* print info about one device */
 	A_FIND_FREE,		/* find first unused */
 	A_SET_CAPACITY,		/* set device capacity */
+	A_SET_DIRECT_IO,	/* set accessing backing file by direct io */
 };
 
 enum {
@@ -393,6 +394,7 @@ static void usage(FILE *out)
 	fputs(_("     --sizelimit <num>         device is limited to <num> bytes of the file\n"), out);
 	fputs(_(" -P, --partscan                create a partitioned loop device\n"), out);
 	fputs(_(" -r, --read-only               set up a read-only loop device\n"), out);
+	fputs(_("     --direct-io               open backing file with O_DIRECT\n"), out);
 	fputs(_("     --show                    print device name after setup (with -f)\n"), out);
 	fputs(_(" -v, --verbose                 verbose mode\n"), out);
 
@@ -446,11 +448,13 @@ int main(int argc, char **argv)
 	int res = 0, showdev = 0, lo_flags = 0;
 	char *outarg = NULL;
 	int list = 0;
+	unsigned long use_dio = 0;
 
 	enum {
 		OPT_SIZELIMIT = CHAR_MAX + 1,
 		OPT_SHOW,
-		OPT_RAW
+		OPT_RAW,
+		OPT_DIO
 	};
 	static const struct option longopts[] = {
 		{ "all", 0, 0, 'a' },
@@ -468,6 +472,7 @@ int main(int argc, char **argv)
 		{ "sizelimit", 1, 0, OPT_SIZELIMIT },
 		{ "partscan", 0, 0, 'P' },
 		{ "read-only", 0, 0, 'r' },
+		{ "direct-io", 1, 0, OPT_DIO },
 		{ "raw", 0, 0, OPT_RAW },
 		{ "show", 0, 0, OPT_SHOW },
 		{ "verbose", 0, 0, 'v' },
@@ -557,6 +562,10 @@ int main(int argc, char **argv)
 		case OPT_SHOW:
 			showdev = 1;
 			break;
+		case OPT_DIO:
+			act = A_SET_DIRECT_IO;
+			use_dio = strtoul_or_err(optarg, _("failed to parse dio"));
+			break;
 		case 'v':
 			break;
 		case 'V':
@@ -606,11 +615,14 @@ int main(int argc, char **argv)
 		 */
 		act = A_SHOW;
 
-	if (!act && optind + 1 == argc) {
+	if ((!act || act == A_SET_DIRECT_IO) && optind + 1 == argc) {
 		/*
 		 * losetup [--list] <device>
+		 * OR
+		 * losetup --direct-io DIO <device>
 		 */
-		act = A_SHOW_ONE;
+		if (!act)
+			act = A_SHOW_ONE;
 		if (!is_loopdev(argv[optind]) ||
 		    loopcxt_set_device(&lc, argv[optind]))
 			err(EXIT_FAILURE, _("%s: failed to use device"),
@@ -747,6 +759,12 @@ int main(int argc, char **argv)
 			warn(_("%s: set capacity failed"),
 			        loopcxt_get_device(&lc));
 		break;
+	case A_SET_DIRECT_IO:
+		res = loopcxt_set_dio(&lc, use_dio);
+		if (res)
+			warn(_("%s: set direct io failed"),
+			        loopcxt_get_device(&lc));
+		break;
 	default:
 		usage(stderr);
 		break;
-- 
1.9.1


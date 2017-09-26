Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:44260 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966668AbdIZOOx (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 26 Sep 2017 10:14:53 -0400
To: util-linux@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] losetup: Add support for logical block size
Message-ID: <ea2d1f7c-ca7b-331f-06c6-54e122a74382@suse.cz>
Date: Tue, 26 Sep 2017 16:14:51 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Kernel since 4.14 supports setting of logical block size[1]. It allows to
create loop devices that report logical block size different from 512.

Add support for this feature to losetup.

References:
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/block/loop.c?id=89e4fdecb51cf5535867026274bc97de9480ade5

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
 include/loopdev.h   |  4 ++++
 lib/loopdev.c       | 46 ++++++++++++++++++++++++++++++++++++++++++++
 sys-utils/losetup.8 |  3 +++
 sys-utils/losetup.c | 55 ++++++++++++++++++++++++++++++++++++++++-------------
 4 files changed, 95 insertions(+), 13 deletions(-)

diff --git a/include/loopdev.h b/include/loopdev.h
index 953d2db89..20cf9b183 100644
--- a/include/loopdev.h
+++ b/include/loopdev.h
@@ -24,6 +24,7 @@
 /* #define LOOP_CHANGE_FD	0x4C06 */
 #define LOOP_SET_CAPACITY	0x4C07
 #define LOOP_SET_DIRECT_IO	0x4C08
+#define LOOP_SET_BLOCK_SIZE	0x4C09
 
 /* /dev/loop-control interface */
 #ifndef LOOP_CTL_ADD
@@ -55,6 +56,7 @@ struct loop_info64 {
 	uint64_t	lo_rdevice;
 	uint64_t	lo_offset;
 	uint64_t	lo_sizelimit; /* bytes, 0 == max available */
+	uint64_t	lo_blocksize;
 	uint32_t	lo_number;
 	uint32_t	lo_encrypt_type;
 	uint32_t	lo_encrypt_key_size;
@@ -173,11 +175,13 @@ int loopcxt_set_offset(struct loopdev_cxt *lc, uint64_t offset);
 int loopcxt_set_sizelimit(struct loopdev_cxt *lc, uint64_t sizelimit);
 int loopcxt_set_flags(struct loopdev_cxt *lc, uint32_t flags);
 int loopcxt_set_backing_file(struct loopdev_cxt *lc, const char *filename);
+int loopcxt_set_blocksize(struct loopdev_cxt *lc, uint64_t blocksize);
 
 extern char *loopcxt_get_backing_file(struct loopdev_cxt *lc);
 extern int loopcxt_get_backing_devno(struct loopdev_cxt *lc, dev_t *devno);
 extern int loopcxt_get_backing_inode(struct loopdev_cxt *lc, ino_t *ino);
 extern int loopcxt_get_offset(struct loopdev_cxt *lc, uint64_t *offset);
+extern int loopcxt_get_blocksize(struct loopdev_cxt *lc, uint64_t *blocksize);
 extern int loopcxt_get_sizelimit(struct loopdev_cxt *lc, uint64_t *size);
 extern int loopcxt_get_encrypt_type(struct loopdev_cxt *lc, uint32_t *type);
 extern const char *loopcxt_get_crypt_name(struct loopdev_cxt *lc);
diff --git a/lib/loopdev.c b/lib/loopdev.c
index 8c653a361..4863219c5 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -735,6 +735,34 @@ int loopcxt_get_offset(struct loopdev_cxt *lc, uint64_t *offset)
 	return rc;
 }
 
+/*
+ * @lc: context
+ * @blocksize: returns logical blocksize for the given device
+ *
+ * Returns: <0 on error, 0 on success
+ */
+int loopcxt_get_blocksize(struct loopdev_cxt *lc, uint64_t *blocksize)
+{
+	struct sysfs_cxt *sysfs = loopcxt_get_sysfs(lc);
+	int rc = -EINVAL;
+
+	if (sysfs)
+		rc = sysfs_read_u64(sysfs, "queue/logical_block_size", blocksize);
+
+	if (rc && loopcxt_ioctl_enabled(lc)) {
+		struct loop_info64 *lo = loopcxt_get_info(lc);
+		if (lo) {
+			if (blocksize)
+				*blocksize = lo->lo_blocksize;
+			rc = 0;
+		} else
+			rc = -errno;
+	}
+
+	DBG(CXT, ul_debugobj(lc, "get_blocksize [rc=%d]", rc));
+	return rc;
+}
+
 /*
  * @lc: context
  * @sizelimit: returns size limit for the given device
@@ -1398,6 +1426,24 @@ int loopcxt_set_dio(struct loopdev_cxt *lc, unsigned long use_dio)
 	return 0;
 }
 
+int loopcxt_set_blocksize(struct loopdev_cxt *lc, unsigned long blocksize)
+{
+	int fd = loopcxt_get_fd(lc);
+
+	if (fd < 0)
+		return -EINVAL;
+
+	/* Kernels prior to v4.14 don't support this ioctl */
+	if (ioctl(fd, LOOP_SET_BLOCK_SIZE, blocksize) < 0) {
+		int rc = -errno;
+		DBG(CXT, ul_debugobj(lc, "LOOP_SET_BLOCK_SIZE failed: %m"));
+		return rc;
+	}
+
+	DBG(CXT, ul_debugobj(lc, "logical block size set"));
+	return 0;
+}
+
 int loopcxt_delete_device(struct loopdev_cxt *lc)
 {
 	int fd = loopcxt_get_fd(lc);
diff --git a/sys-utils/losetup.8 b/sys-utils/losetup.8
index 98a8e70d6..41aedd8e5 100644
--- a/sys-utils/losetup.8
+++ b/sys-utils/losetup.8
@@ -116,6 +116,9 @@ The data start is moved \fIoffset\fP bytes into the specified file or device.
 .IP "\fB\-\-sizelimit \fIsize\fP"
 The data end is set to no more than \fIsize\fP bytes after the data start.
 .TP
+.BR \-b , " \-\-logical-blocksize " \fIsize
+Set the logical block size of the loop device in bytes.
+.TP
 .BR \-c , " \-\-set\-capacity " \fIloopdev
 Force the loop driver to reread the size of the file associated with the
 specified loop device.
diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index bbff98389..7837f5833 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -36,6 +36,7 @@ enum {
 	A_FIND_FREE,		/* find first unused */
 	A_SET_CAPACITY,		/* set device capacity */
 	A_SET_DIRECT_IO,	/* set accessing backing file by direct io */
+	A_SET_BLOCKSIZE,	/* set logical block size of the loop device */
 };
 
 enum {
@@ -50,6 +51,7 @@ enum {
 	COL_RO,
 	COL_SIZELIMIT,
 	COL_DIO,
+	COL_BLOCKSIZE,
 };
 
 /* basic output flags */
@@ -76,6 +78,7 @@ static struct colinfo infos[] = {
 	[COL_SIZELIMIT]   = { "SIZELIMIT",    5, SCOLS_FL_RIGHT, N_("size limit of the file in bytes")},
 	[COL_MAJMIN]      = { "MAJ:MIN",      3, 0, N_("loop device major:minor number")},
 	[COL_DIO]         = { "DIO",          1, SCOLS_FL_RIGHT, N_("access backing file with direct-io")},
+	[COL_BLOCKSIZE]   = { "BLOCKSIZE",    4, SCOLS_FL_RIGHT, N_("logical block size in bytes")},
 };
 
 static int columns[ARRAY_SIZE(infos) * 2] = {-1};
@@ -136,6 +139,8 @@ static int printf_loopdev(struct loopdev_cxt *lc)
 
 		if (loopcxt_get_sizelimit(lc, &x) == 0 && x)
 				printf(_(", sizelimit %ju"), x);
+		if (loopcxt_get_blocksize(lc, &x) == 0 && x)
+				printf(_(", blocksize %ju"), x);
 		printf("\n");
 		return 0;
 	}
@@ -157,6 +162,8 @@ static int printf_loopdev(struct loopdev_cxt *lc)
 		if (e && *e)
 			printf(_(", encryption %s (type %u)"), e, type);
 	}
+	if (loopcxt_get_blocksize(lc, &x) == 0 && x)
+			printf(_(", blocksize %ju"), x);
 	printf("\n");
 	return 0;
 }
@@ -280,6 +287,10 @@ static int set_scols_data(struct loopdev_cxt *lc, struct libscols_line *ln)
 		case COL_PARTSCAN:
 			p = loopcxt_is_partscan(lc) ? "1" : "0";
 			break;
+		case COL_BLOCKSIZE:
+			if (loopcxt_get_blocksize(lc, &x) == 0)
+				xasprintf(&np, "%jd", x);
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -404,6 +415,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_(" -o, --offset <num>            start at offset <num> into file\n"), out);
 	fputs(_("     --sizelimit <num>         device is limited to <num> bytes of the file\n"), out);
+	fputs(_(" -b  --logical-blocksize <size> set the logical block size to <size>\n"), out);
 	fputs(_(" -P, --partscan                create a partitioned loop device\n"), out);
 	fputs(_(" -r, --read-only               set up a read-only loop device\n"), out);
 	fputs(_("     --direct-io[=<on|off>]    open backing file with O_DIRECT\n"), out);
@@ -566,11 +578,11 @@ int main(int argc, char **argv)
 	struct loopdev_cxt lc;
 	int act = 0, flags = 0, no_overlap = 0, c;
 	char *file = NULL;
-	uint64_t offset = 0, sizelimit = 0;
+	uint64_t offset = 0, sizelimit = 0, blocksize = 0;
 	int res = 0, showdev = 0, lo_flags = 0;
 	char *outarg = NULL;
 	int list = 0;
-	unsigned long use_dio = 0, set_dio = 0;
+	unsigned long use_dio = 0, set_dio = 0, set_blocksize = 0;
 
 	enum {
 		OPT_SIZELIMIT = CHAR_MAX + 1,
@@ -589,6 +601,7 @@ int main(int argc, char **argv)
 		{ "associated",   required_argument, NULL, 'j'           },
 		{ "json",         no_argument,       NULL, 'J'           },
 		{ "list",         no_argument,       NULL, 'l'           },
+		{ "logical-blocksize", required_argument, NULL, 'b'      },
 		{ "noheadings",   no_argument,       NULL, 'n'           },
 		{ "offset",       required_argument, NULL, 'o'           },
 		{ "output",       required_argument, NULL, 'O'           },
@@ -620,7 +633,7 @@ int main(int argc, char **argv)
 	if (loopcxt_init(&lc, 0))
 		err(EXIT_FAILURE, _("failed to initialize loopcxt"));
 
-	while ((c = getopt_long(argc, argv, "ac:d:Dfhj:JlLno:O:PrvV",
+	while ((c = getopt_long(argc, argv, "ab:c:d:Dfhj:JlLno:O:PrvV",
 				longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
@@ -629,6 +642,10 @@ int main(int argc, char **argv)
 		case 'a':
 			act = A_SHOW;
 			break;
+		case 'b':
+			set_blocksize = 1;
+			blocksize = strtosize_or_err(optarg, _("failed to parse logical block size"));
+			break;
 		case 'c':
 			act = A_SET_CAPACITY;
 			if (!is_loopdev(optarg) ||
@@ -727,6 +744,7 @@ int main(int argc, char **argv)
 		columns[ncolumns++] = COL_RO;
 		columns[ncolumns++] = COL_BACK_FILE;
 		columns[ncolumns++] = COL_DIO;
+		columns[ncolumns++] = COL_BLOCKSIZE;
 	}
 
 	if (act == A_FIND_FREE && optind < argc) {
@@ -747,12 +765,14 @@ int main(int argc, char **argv)
 		/*
 		 * losetup [--list] <device>
 		 * OR
-		 * losetup --direct-io[=off] <device>
+		 * losetup {--direct-io[=off]|--logical-blocksize=size}... <device>
 		 */
-		if (!set_dio)
+		if (!(set_dio || set_blocksize))
 			act = A_SHOW_ONE;
-		else
+		if (set_dio)
 			act = A_SET_DIRECT_IO;
+		if (set_blocksize)
+			act = A_SET_BLOCKSIZE;
 		if (!is_loopdev(argv[optind]) ||
 		    loopcxt_set_device(&lc, argv[optind]))
 			err(EXIT_FAILURE, _("%s: failed to use device"),
@@ -799,8 +819,8 @@ int main(int argc, char **argv)
 			if (showdev)
 				printf("%s\n", loopcxt_get_device(&lc));
 			warn_size(file, sizelimit);
-			if (set_dio)
-				goto lo_set_dio;
+			if (set_dio || set_blocksize)
+				goto lo_set_post;
 		}
 		break;
 	case A_DELETE:
@@ -853,11 +873,20 @@ int main(int argc, char **argv)
 			        loopcxt_get_device(&lc));
 		break;
 	case A_SET_DIRECT_IO:
- lo_set_dio:
-		res = loopcxt_set_dio(&lc, use_dio);
-		if (res)
-			warn(_("%s: set direct io failed"),
-			        loopcxt_get_device(&lc));
+	case A_SET_BLOCKSIZE:
+ lo_set_post:
+		if (set_dio) {
+			res = loopcxt_set_dio(&lc, use_dio);
+			if (res)
+				warn(_("%s: set direct io failed"),
+				        loopcxt_get_device(&lc));
+		}
+		if (set_blocksize) {
+			res = loopcxt_set_blocksize(&lc, blocksize);
+			if (res)
+				warn(_("%s: set logical block size"),
+				        loopcxt_get_device(&lc));
+		}
 		break;
 	default:
 		warnx(_("bad usage"));
-- 
2.14.1

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

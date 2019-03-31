Return-Path: <SRS0=oG/1=SC=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028B2C43381
	for <util-linux@archiver.kernel.org>; Sun, 31 Mar 2019 06:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A453120882
	for <util-linux@archiver.kernel.org>; Sun, 31 Mar 2019 06:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="KYgTNarJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbfCaGf6 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:35:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44551 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCaGf5 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 31 Mar 2019 02:35:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so2966552pfm.11
        for <util-linux@vger.kernel.org>; Sat, 30 Mar 2019 23:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=bRVHZHwr7jCKJcy1uMQxjK5/znSWtbh7oiMrJC6eS38=;
        b=KYgTNarJrwYUVszM5JJAH81x3fWafsHDUf8950kJyDobNHVvXwbw5Qg4vvnh3BhLKy
         7eZw0bi59cBZkl6MMEiDJuMJVHomZ8uDQew0dluEnYzUuZvrTfCK79fb5UpfiHpDQKhh
         yE+jHodAukI4zJlWqTrk9uPmt4zcJUIQ5TG4yWXYvof2LJFeWDwUJOTL3pVS+DrjPU0I
         nTYBZoi/wWInROZbqB9YkavQhSrEcbC8IRFSW4xoUb1Txbv5DPehCvxBMx86DGO6r5lj
         NbSIMy8SNyAfZRULI4HLez/H+Exn5H2nQIUcbfqIkKGVwhEaBoWud1Vjpuxt/s2GHaQb
         deRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bRVHZHwr7jCKJcy1uMQxjK5/znSWtbh7oiMrJC6eS38=;
        b=amVeukSZ8jZoipMkQoNoIUr6VKmDjYn14spxudUSeQdYLu7iq4KVN1j0WgzzzyvPvM
         RyQ3NoLFMzpHCF8vwav6K6hriEWyYkNnFr7iltwmRdcVp8nItwMh9A/7OHu3wB7ikKyR
         Fv2SY/j2QZJTuF5ADcJD/D6gGE0fEpftPemc0NLzedvR9Dg0qagEwNUO2N49HtDyHIFB
         wX08doevnnJ6UNmZX/dgOiA1uADdNSTw3tfCQ19vQqve9oA1D9nEMA2icHVRqYQj1e6H
         wW1eBCBlXDYvQSNxqp4ic0U6TWHCYPy8Y/+6KPMxGhhTuNyEbdZP5SMPVPGjDUnsx8Jq
         mTug==
X-Gm-Message-State: APjAAAVBP1YIiHltkVrZKsB/QNNOf6TvIKbTf8jkaVRb8mL09Bh02qRW
        rfj1w3LCSUBorWEIsdaaett9Xg==
X-Google-Smtp-Source: APXvYqw+9ajn3D1Q9qFlY77kOtUQt8LEpJNz4rObtvuvSOfy8doolZgQQzdb6TUJiyje2ut4mpAruQ==
X-Received: by 2002:a63:8548:: with SMTP id u69mr54220917pgd.85.1554014156607;
        Sat, 30 Mar 2019 23:35:56 -0700 (PDT)
Received: from always-ThinkPad-T480.bytedance.net ([203.12.205.218])
        by smtp.gmail.com with ESMTPSA id m10sm7576113pgq.42.2019.03.30.23.35.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Mar 2019 23:35:55 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     kzak@redhat.com
Cc:     util-linux@vger.kernel.org, pizhenwei@bytedance.com
Subject: [PATCH] fiemap : add fiemap misc tool
Date:   Sun, 31 Mar 2019 14:35:51 +0800
Message-Id: <1554014151-12743-1-git-send-email-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.7.4
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Add fiemap to dump file extent mappings. Typically we can recognize a
file is sparse or not.

For example :
 #./fiemap /var/log/syslog /var/log/syslog.2.gz
File /var/log/syslog has 19 extents :
  	Logical          Physical         Length           Flag
0:	0000000000000000 00000010d63a8000 0000000000001000 0000
1:	0000000000001000 00000010d63c4000 0000000000001000 0000
2:	0000000000002000 00000010d63d6000 0000000000001000 0000
3:	0000000000003000 00000010d723e000 0000000000001000 0000
4:	0000000000004000 000000076c377000 0000000000001000 0000
5:	0000000000005000 00000010d550f000 0000000000001000 0000
6:	0000000000006000 00000010d7290000 0000000000001000 0000
7:	0000000000007000 00000010d57c9000 0000000000001000 0000
8:	0000000000008000 00000010d57f5000 0000000000001000 0000
9:	0000000000009000 000000076d6b3000 0000000000001000 0000
10:	000000000000a000 00000010d558d000 0000000000001000 0000
11:	000000000000b000 00000010d77ff000 0000000000001000 0000
12:	000000000000c000 00000010d67fb000 0000000000001000 0000
13:	000000000000d000 00000010d73fc000 0000000000001000 0000
14:	000000000000e000 00000005d2bb2000 0000000000001000 0000
15:	000000000000f000 00000007705a1000 0000000000001000 0000
16:	0000000000010000 0000000c8bf10000 0000000000010000 0000
17:	0000000000020000 0000001070020000 0000000000060000 0000
18:	0000000000080000 00000011aa580000 0000000000014000 0001

File /var/log/syslog.2.gz has 1 extents :
  	Logical          Physical         Length           Flag
0:	0000000000000000 0000000995c40000 0000000000023000 0001

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 configure.ac             |   4 +-
 misc-utils/Makemodule.am |   5 ++
 misc-utils/fiemap.c      | 152 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+), 1 deletion(-)
 create mode 100644 misc-utils/fiemap.c

diff --git a/configure.ac b/configure.ac
index bbf07db..98c3f42 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1769,6 +1769,9 @@ UL_REQUIRES_LINUX([fincore])
 UL_REQUIRES_BUILD([fincore], [libsmartcols])
 AM_CONDITIONAL([BUILD_FINCORE], [test "x$build_fincore" = xyes])
 
+UL_BUILD_INIT([fiemap], [yes])
+AM_CONDITIONAL([BUILD_FIEMAP], [test "x$build_fiemap" = xyes])
+
 UL_BUILD_INIT([fsfreeze], [check])
 UL_REQUIRES_LINUX([fsfreeze])
 AM_CONDITIONAL([BUILD_FSFREEZE], [test "x$build_fsfreeze" = xyes])
@@ -1820,7 +1823,6 @@ AM_CONDITIONAL([BUILD_HEXDUMP], [test "x$build_hexdump" = xyes])
 UL_BUILD_INIT([rev], [yes])
 AM_CONDITIONAL([BUILD_REV], [test "x$build_rev" = xyes])
 
-
 AC_ARG_ENABLE([tunelp],
   AS_HELP_STRING([--enable-tunelp], [build tunelp]),
   [], [UL_DEFAULT_ENABLE([tunelp], [no])]
diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
index f56a819..8bdc6fa 100644
--- a/misc-utils/Makemodule.am
+++ b/misc-utils/Makemodule.am
@@ -228,3 +228,8 @@ hardlink_CFLAGS += $(PCRE_CFLAGS)
 endif
 dist_man_MANS += misc-utils/hardlink.1
 endif
+
+if BUILD_FIEMAP
+usrbin_exec_PROGRAMS += fiemap
+fiemap_SOURCES = misc-utils/fiemap.c
+endif
diff --git a/misc-utils/fiemap.c b/misc-utils/fiemap.c
new file mode 100644
index 0000000..bcc807e
--- /dev/null
+++ b/misc-utils/fiemap.c
@@ -0,0 +1,152 @@
+/*
+ * Copyright (C) 2019 zhenwei pi <pizhenwei@bytedance.com>
+ *
+ * This file may be redistributed under the terms of the GNU Public
+ * License.
+ */
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <sys/ioctl.h>
+#include <linux/fs.h>
+
+#include "c.h"
+#include "nls.h"
+#include "closestream.h"
+
+#ifdef FS_IOC_FIEMAP
+#include <linux/fiemap.h>
+
+static struct fiemap *read_fiemap(int fd)
+{
+	struct fiemap *fiemap;
+	int extents_size;
+
+	if ((fiemap = (struct fiemap*)malloc(sizeof(struct fiemap))) == NULL) {
+		err(EXIT_FAILURE, _("malloc"));	
+	}
+
+	memset(fiemap, 0, sizeof(struct fiemap));
+
+	fiemap->fm_start = 0;
+	fiemap->fm_length = ~0;
+	fiemap->fm_flags = 0;
+	fiemap->fm_extent_count = 0;
+	fiemap->fm_mapped_extents = 0;
+
+	/* count how many extents there are */
+	if (ioctl(fd, FS_IOC_FIEMAP, fiemap) < 0) {
+		err(EXIT_FAILURE, _("fiemap ioctl() failed"));
+	}
+
+	/* read in the extents */
+	extents_size = sizeof(struct fiemap_extent) * 
+		(fiemap->fm_mapped_extents);
+
+	/* resize fiemaps for all extents */
+	if ((fiemap = (struct fiemap*)realloc(fiemap,sizeof(struct fiemap) + 
+					extents_size)) == NULL) {
+		err(EXIT_FAILURE, _("realloc for extents memory"));
+	}
+
+	memset(fiemap->fm_extents, 0, extents_size);
+	fiemap->fm_extent_count = fiemap->fm_mapped_extents;
+	fiemap->fm_mapped_extents = 0;
+
+	if (ioctl(fd, FS_IOC_FIEMAP, fiemap) < 0) {
+		err(EXIT_FAILURE, _("ioctl() FS_IOC_FIEMAP failed"));
+		return NULL;
+	}
+
+	return fiemap;
+}
+
+static void show_fiemap(struct fiemap *fiemap, char *filename)
+{
+	unsigned int i = 0;
+
+	printf("File %s has %d extents :\n", filename, fiemap->fm_mapped_extents);
+	printf("#\tLogical          Physical         Length           Flag\n");
+	for (i = 0; i < fiemap->fm_mapped_extents; i++) {
+		printf("%d:\t%-16.16llx %-16.16llx %-16.16llx %-4.4x\n", i,
+				fiemap->fm_extents[i].fe_logical,
+				fiemap->fm_extents[i].fe_physical,
+				fiemap->fm_extents[i].fe_length,
+				fiemap->fm_extents[i].fe_flags);
+	}
+
+	printf("\n");
+}
+#else
+static struct fiemap *read_fiemap(int fd)
+{
+	return NULL;
+}
+
+static void show_fiemap(struct fiemap *fiemap, char *filename)
+{
+}
+#endif
+
+static void __attribute__((__noreturn__)) usage(void)
+{
+	FILE *out = stdout;
+	fputs(USAGE_HEADER, out);
+	fprintf(out, _(" %s <file>...\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	exit(EXIT_SUCCESS);
+}
+
+int main(int argc, char **argv)
+{
+	int c;
+	static const struct option longopts[] = {
+		{ "version",    no_argument, NULL, 'V' },
+		{ "help",       no_argument, NULL, 'h' },
+		{ NULL, 0, NULL, 0 },
+	};
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	atexit(close_stdout);
+
+	while ((c = getopt_long (argc, argv, "Vh", longopts, NULL)) != -1) {
+		switch (c) {
+			case 'V':
+				printf(UTIL_LINUX_VERSION);
+				return EXIT_SUCCESS;
+			case 'h':
+				usage();
+			default:
+				errtryhelp(EXIT_FAILURE);
+		}
+	}
+
+	if (optind == argc) {
+		warnx(_("no file specified"));
+		errtryhelp(EXIT_FAILURE);
+	}
+
+	for(; optind < argc; optind++) {
+		int fd = 0;
+
+		if ((fd = open(argv[optind], O_RDONLY)) < 0) {
+			err(EXIT_FAILURE, _("open file failed"));
+		} else {
+			struct fiemap *fiemap = NULL;
+
+			if ((fiemap = read_fiemap(fd)) != NULL) {
+				show_fiemap(fiemap, argv[optind]);
+				free(fiemap);
+			}
+			close(fd);
+		}
+	}
+
+	return 0;
+}
-- 
2.7.4


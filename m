Return-Path: <SRS0=vf6E=77=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A099C433E0
	for <util-linux@archiver.kernel.org>; Thu, 18 Jun 2020 10:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6729F207DD
	for <util-linux@archiver.kernel.org>; Thu, 18 Jun 2020 10:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlihRPUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgFRKup (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:50:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47768 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729369AbgFRKum (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 18 Jun 2020 06:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592477441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pZlP5uqXLmMQ2/RV4p90WxGhQgAOGhEy40bZAAH8tuc=;
        b=FlihRPUUzrR+OgchcoTtd0jWE4EgBb1X0P7MVaFTRZG4vPsdmDe6ADo2cHH7pwPQS+1H6j
        mO95OgaIZ7UeFe9J/ZPBOrAaLxf0NxA4/7Z8MuWHeYGBiJbSAFefmN7j5luNYYKQH3Mg+2
        97xrXHzvfpDOVUd02uoUSst7wNbd6Ek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-wU-rDb5hONiWD4n8ZXJxaw-1; Thu, 18 Jun 2020 06:50:38 -0400
X-MC-Unique: wU-rDb5hONiWD4n8ZXJxaw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC37E8005AD
        for <util-linux@vger.kernel.org>; Thu, 18 Jun 2020 10:50:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECBC65D9E4;
        Thu, 18 Jun 2020 10:50:36 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     util-linux@vger.kernel.org
Cc:     kzak@redhat.com
Subject: [PATCH v2] blkdiscard: Refuse to proceed if signatures are found
Date:   Thu, 18 Jun 2020 12:50:34 +0200
Message-Id: <20200618105034.13498-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Currently the blkdiscard has the ability to wipe out entere device in a
matter of seconds. This is fine as long as it's intentional, it is
potentially catastrophic if it's not.

With this commit blkdiscard will check for existing signatures on the
device and refuse to continue if any are found unless the operation is
forced with the -f option.

In an attempt to avoid breaking existing automation scripts the force is
only required when stdin refers to a terminal.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
v2: Rename function to probe_device, use switch and free probe if no
    signature was found

 sys-utils/Makemodule.am |  2 +-
 sys-utils/blkdiscard.c  | 59 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 5855e1cc1..b5f6c1b1b 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -165,7 +165,7 @@ if BUILD_BLKDISCARD
 sbin_PROGRAMS += blkdiscard
 dist_man_MANS += sys-utils/blkdiscard.8
 blkdiscard_SOURCES = sys-utils/blkdiscard.c lib/monotonic.c
-blkdiscard_LDADD = $(LDADD) libcommon.la $(REALTIME_LIBS)
+blkdiscard_LDADD = $(LDADD) libblkid.la libcommon.la $(REALTIME_LIBS)
 endif
 
 if BUILD_BLKZONE
diff --git a/sys-utils/blkdiscard.c b/sys-utils/blkdiscard.c
index e83f69b11..2dd4638aa 100644
--- a/sys-utils/blkdiscard.c
+++ b/sys-utils/blkdiscard.c
@@ -37,6 +37,7 @@
 #include <sys/stat.h>
 #include <sys/time.h>
 #include <linux/fs.h>
+#include <blkid/blkid.h>
 
 #include "nls.h"
 #include "strutils.h"
@@ -106,6 +107,41 @@ static void __attribute__((__noreturn__)) usage(void)
 	exit(EXIT_SUCCESS);
 }
 
+/*
+ * Check existing signature on the open fd
+ * Returns	0  signature found
+ * 		1  no signature
+ * 		<0 error
+ */
+static int probe_device(int fd, char *path)
+{
+	const char *type;
+	blkid_probe pr = NULL;
+	int ret = -1;
+
+	pr = blkid_new_probe();
+	if (!pr || blkid_probe_set_device(pr, fd, 0, 0))
+		return ret;
+
+	blkid_probe_enable_superblocks(pr, TRUE);
+	blkid_probe_enable_partitions(pr, TRUE);
+
+	ret = blkid_do_fullprobe(pr);
+	if (ret)
+		goto out;
+
+	if (!blkid_probe_lookup_value(pr, "TYPE", &type, NULL)) {
+		warnx("%s contains existing file system (%s).",path ,type);
+	} else if (!blkid_probe_lookup_value(pr, "PTTYPE", &type, NULL)) {
+		warnx("%s contains existing partition (%s).",path ,type);
+	} else {
+		warnx("%s contains existing signature.", path);
+	}
+
+out:
+	blkid_free_probe(pr);
+	return ret;
+}
 
 int main(int argc, char **argv)
 {
@@ -184,7 +220,7 @@ int main(int argc, char **argv)
 		errtryhelp(EXIT_FAILURE);
 	}
 
-	fd = open(path, O_WRONLY | (force ? 0 : O_EXCL));
+	fd = open(path, O_RDWR | (force ? 0 : O_EXCL));
 	if (fd < 0)
 		err(EXIT_FAILURE, _("cannot open %s"), path);
 
@@ -217,6 +253,27 @@ int main(int argc, char **argv)
 		errx(EXIT_FAILURE, _("%s: length %" PRIu64 " is not aligned "
 			 "to sector size %i"), path, range[1], secsize);
 
+	 /* Check for existing signatures on the device */
+	switch(probe_device(fd, path)) {
+	case 0: /* signature detected */
+		/*
+		 * Only require force in interactive mode to avoid
+		 * breaking existing scripts
+		 */
+		if (!force && isatty(STDIN_FILENO)) {
+			errx(EXIT_FAILURE,
+			     _("This is destructive operation, data will " \
+			       "be lost! Use the -f option to override."));
+		}
+		warnx(_("Operation forced, data will be lost!"));
+		break;
+	case 1: /* no signature */
+		break;
+	default: /* error */
+		err(EXIT_FAILURE, _("failed to probe the device"));
+		break;
+	}
+
 	stats[0] = range[0], stats[1] = 0;
 	gettime_monotonic(&last);
 
-- 
2.21.3


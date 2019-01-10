Return-Path: <SRS0=LbFG=PS=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4184BC43387
	for <util-linux@archiver.kernel.org>; Thu, 10 Jan 2019 21:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E3720874
	for <util-linux@archiver.kernel.org>; Thu, 10 Jan 2019 21:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e61ZWuai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbfAJVzY (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:55:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44493 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbfAJVzY (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 10 Jan 2019 16:55:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so5899532pfh.11
        for <util-linux@vger.kernel.org>; Thu, 10 Jan 2019 13:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jztEJNzSXpbeHqlhMG5B4v1LleX8y/GgbCDlvl7Y290=;
        b=e61ZWuai8mvaV1eZRZtYvhR9zIU7YXx5nW3JfU6hT/K4eI3ST9+UPPUSbNSsOxr4ZZ
         /3GISSwkZVQIxPp6wrLXogLeWgNsFOvMtAdE7nXwAMJ4WTb3aQMHND8koOj9Bza+Zf0h
         zXSctKZ3rmAyWjx00CLS8P4cNKf2xYZMY/ZNIAJiutNmPnk+iF2WLjw2FR2CZZ7f5A7U
         d7MdK/YZFxWmwfTlJACnFvKIKkt0713qrMfMEejHgFFS7TR+EEClH2ba5cSW08EqLw3M
         FkE9T2LKtCQcHJpNuD5V0SNn7W0eLu3RSLPJK2IQK2LB9CVST4tpU+dIt/n5jChou6al
         quCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jztEJNzSXpbeHqlhMG5B4v1LleX8y/GgbCDlvl7Y290=;
        b=dUc3ONl73O9JJB0GTxxtLVeOoIqQID7m4rOia3yTQIEgqM7EfDewkq6Eo+FdGYEexd
         rzXATfKd+EfR6U/Czkbhz8JRPHq06UUdey6n0nzZFWqi3G5FvMwIYDtoNg9qSmrThMpO
         mOYxiM6JacbOjZSEjuBEpOuCRXTmN3dY1lmBsJL9a216JR1eUCd6lXkvLmeVcnf+Tfn6
         UIm4XCvq6k4/5Td/zqZXWnkMcsLCGv9GRKshaKAdQyOXQhGenkSfwRt++Z6qNdSzwWr2
         IBlXj1yF6KDxSwJ8R/pL6yTQUruZpOddXJHYcf4h2pHdwGfnfKvUPHPFM5gLaOoTuyjB
         5s7g==
X-Gm-Message-State: AJcUukcC4dLUDujnoZMVQSdlHKAD7SZOEz81u/flzchDYDmOFHEn4UME
        Zsce/zbrt/B0XYEE3lgIYBeaqU5W
X-Google-Smtp-Source: ALg8bN7pkOpMZOVJQMvAI+yE4l4Jj9YsX9t7BsTqj4WRBWXDm7RDex5shBLwg4kFLpWq2KG/HcMNdg==
X-Received: by 2002:a62:4bcf:: with SMTP id d76mr12462923pfj.170.1547157322865;
        Thu, 10 Jan 2019 13:55:22 -0800 (PST)
Received: from jeffrey-Ubuntu-iMac (c-67-160-212-164.hsd1.ca.comcast.net. [67.160.212.164])
        by smtp.gmail.com with ESMTPSA id x12sm96464464pgr.55.2019.01.10.13.55.21
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 13:55:21 -0800 (PST)
Date:   Thu, 10 Jan 2019 13:55:19 -0800
From:   Jeffrey Ferreira <jeffpferreira@gmail.com>
To:     util-linux@vger.kernel.org
Subject: [PATCH] losetup: set blocksize before partition scan
Message-ID: <20190110215515.GA28589@jeffrey-Ubuntu-iMac>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

When creating a loop device the user may use the --partscan option to
request that the kernel scan for partitions. To correctly scan for
partitions the kernel must first have the correct blocksize.

Also, update an error message to add --partscan to the list of options
only allowed during loop device setup.

Signed-off-by: Jeffrey Ferreira <jeffpferreira@gmail.com>
---
 disk-utils/partx.c             |  2 +-
 include/loopdev.h              |  2 +-
 lib/loopdev.c                  | 13 ++++++++++++-
 libmount/src/context_loopdev.c |  2 +-
 sys-utils/losetup.c            | 11 ++++++-----
 5 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/disk-utils/partx.c b/disk-utils/partx.c
index e10efa96a..0cf7b3330 100644
--- a/disk-utils/partx.c
+++ b/disk-utils/partx.c
@@ -125,7 +125,7 @@ static void assoc_loopdev(const char *fname)
 	if (loopcxt_set_backing_file(&lc, fname))
 		err(EXIT_FAILURE, _("%s: failed to set backing file"), fname);
 
-	rc = loopcxt_setup_device(&lc);
+	rc = loopcxt_setup_device(&lc, 0);
 
 	if (rc == -EBUSY)
 		err(EXIT_FAILURE, _("%s: failed to set up loop device"), fname);
diff --git a/include/loopdev.h b/include/loopdev.h
index 3f2cec5f5..b62df00b1 100644
--- a/include/loopdev.h
+++ b/include/loopdev.h
@@ -163,7 +163,7 @@ extern int loopcxt_init_iterator(struct loopdev_cxt *lc, int flags);
 extern int loopcxt_deinit_iterator(struct loopdev_cxt *lc);
 extern int loopcxt_next(struct loopdev_cxt *lc);
 
-extern int loopcxt_setup_device(struct loopdev_cxt *lc);
+extern int loopcxt_setup_device(struct loopdev_cxt *lc, uint64_t blocksize);
 extern int loopcxt_set_status(struct loopdev_cxt *lc);
 extern int loopcxt_delete_device(struct loopdev_cxt *lc);
 extern int loopcxt_set_capacity(struct loopdev_cxt *lc);
diff --git a/lib/loopdev.c b/lib/loopdev.c
index de0d50ba2..ad56895f8 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -1256,7 +1256,7 @@ static int loopcxt_check_size(struct loopdev_cxt *lc, int file_fd)
  *
  * Returns: <0 on error, 0 on success.
  */
-int loopcxt_setup_device(struct loopdev_cxt *lc)
+int loopcxt_setup_device(struct loopdev_cxt *lc, uint64_t blocksize)
 {
 	int file_fd, dev_fd, mode = O_RDWR, rc = -1, cnt = 0;
 	int errsv = 0;
@@ -1331,6 +1331,17 @@ int loopcxt_setup_device(struct loopdev_cxt *lc)
 
 	DBG(SETUP, ul_debugobj(lc, "LOOP_SET_FD: OK"));
 
+	if (blocksize > 0) {
+		if (ioctl(dev_fd, LOOP_SET_BLOCK_SIZE, (unsigned long) blocksize) < 0) {
+			rc = -errno;
+			errsv = errno;
+			DBG(SETUP, ul_debugobj(lc, "LOOP_SET_BLOCK_SIZE failed: %m"));
+			goto err;
+		}
+
+		DBG(SETUP, ul_debugobj(lc, "LOOP_SET_BLOCK_SIZE: OK"));
+	}
+
 	if (ioctl(dev_fd, LOOP_SET_STATUS64, &lc->info)) {
 		rc = -errno;
 		errsv = errno;
diff --git a/libmount/src/context_loopdev.c b/libmount/src/context_loopdev.c
index c5fc80d77..b916d03b3 100644
--- a/libmount/src/context_loopdev.c
+++ b/libmount/src/context_loopdev.c
@@ -336,7 +336,7 @@ int mnt_context_setup_loopdev(struct libmnt_context *cxt)
 		}
 
 		/* setup the device */
-		rc = loopcxt_setup_device(&lc);
+		rc = loopcxt_setup_device(&lc, 0);
 		if (!rc)
 			break;		/* success */
 
diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index 7d14f566c..ae23b3507 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -468,8 +468,8 @@ static void warn_size(const char *filename, uint64_t size)
 }
 
 static int create_loop(struct loopdev_cxt *lc,
-		       int nooverlap, int lo_flags, int flags,
-		       const char *file, uint64_t offset, uint64_t sizelimit)
+		       int nooverlap, int lo_flags, int flags, const char *file,
+		       uint64_t offset, uint64_t sizelimit, uint64_t blocksize)
 {
 	int hasdev = loopcxt_has_device(lc);
 	int rc = 0;
@@ -562,7 +562,7 @@ static int create_loop(struct loopdev_cxt *lc,
 			break;
 		}
 		errno = 0;
-		rc = loopcxt_setup_device(lc);
+		rc = loopcxt_setup_device(lc, blocksize);
 		if (rc == 0)
 			break;			/* success */
 		if (errno == EBUSY && !hasdev)
@@ -819,7 +819,7 @@ int main(int argc, char **argv)
 	    (sizelimit || lo_flags || showdev))
 		errx(EXIT_FAILURE,
 			_("the options %s are allowed during loop device setup only"),
-			"--{sizelimit,read-only,show}");
+			"--{sizelimit,partscan,read-only,show}");
 
 	if ((flags & LOOPDEV_FL_OFFSET) &&
 	    act != A_CREATE && (act != A_SHOW || !file))
@@ -831,7 +831,8 @@ int main(int argc, char **argv)
 
 	switch (act) {
 	case A_CREATE:
-		res = create_loop(&lc, no_overlap, lo_flags, flags, file, offset, sizelimit);
+		res = create_loop(&lc, no_overlap, lo_flags, flags, file,
+		                  offset, sizelimit, blocksize);
 		if (res == 0) {
 			if (showdev)
 				printf("%s\n", loopcxt_get_device(&lc));
-- 
2.17.1


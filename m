Return-Path: <SRS0=Xeup=SQ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD70FC10F11
	for <util-linux@archiver.kernel.org>; Sun, 14 Apr 2019 03:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE8C2147A
	for <util-linux@archiver.kernel.org>; Sun, 14 Apr 2019 03:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgnQMciP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfDNDcF (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 13 Apr 2019 23:32:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35401 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfDNDcF (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2019 23:32:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id g8so7003425pgf.2
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2019 20:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TH5JDgTJn7dafgbLVzlVudNh33BB7U7vb3jPqvDGdx0=;
        b=AgnQMciP+RG0MIeqe2wfynR7R17uHgd5vK3j6u0XxiVFvCsY8DucIa5dgZDHTkaX5d
         bdvpdsAnxpwA13Ea8WWa9dOTY45kM7R6fjy+Ap+KCXEA25q4L3ui+UH3rP4tJblB7EIg
         rRUT5DnVOWj5c7kmitw449zW81ysSE7mbx7NUrdHctB60DL4WwXk3ulv1jBRn5KM4pta
         NlN9uZ1NNZOefPcvgl8lW8fkM4o5JCb3GytLilBepDiZKWs7kPnGXeB+C+QV/C+isRtP
         FH/vVceNf/KhpRYg/+hPUtvO/mPyJOX+qhp9l1eR+qkM++zp2Hevj6TyuptBY//8w2dt
         X9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TH5JDgTJn7dafgbLVzlVudNh33BB7U7vb3jPqvDGdx0=;
        b=X2fInL4cY4XAB2YkxcJUIBTFL1xiwY1e4XJO1st+u1uAh02cqmdZDiOXFmiCk8hbF3
         rr3OvqM98x7KXVvzAExmvsFoH9NNAGSnNhqidBPct0X5N9nG9S/gBUU0GQiYGOICdCHD
         bocpD3m85IKUJ1n4EN9gLh3Qwq1g1ffO/xdbVEXa9Y3Ky6wn13mOfuCWHDTGcNLTeiaf
         UNlB9Y30nvyU1rhkfdr/Rswd0u0XFyF38Pk3OjhEhOZk4g89mjUbcB68Kun7U5uElT8D
         5A6nYmxhewYQyTExOi4FG0GJgiv7UV0DJR0FbzGEkL3TgOAV0tkmLsgU+fgR3kftgoIQ
         /+nA==
X-Gm-Message-State: APjAAAWBD/Zv+y33dqQN5hbPcG1KLkyfz3Lc3fLUb5q2EG3sGFgkJIk8
        e5ZeR0Kz2mY1UYCOs4ZoBUg4Spzw
X-Google-Smtp-Source: APXvYqxqIlyET0BjeSiivUgITN6+UWzg0euGpm2g0mpCZ/iTRMfBr1Zs2UPZngEySGH7tDgfALguag==
X-Received: by 2002:a65:5941:: with SMTP id g1mr64268538pgu.51.1555212724487;
        Sat, 13 Apr 2019 20:32:04 -0700 (PDT)
Received: from localhost.localdomain (fs276ec80e.tkyc203.ap.nuro.jp. [39.110.200.14])
        by smtp.gmail.com with ESMTPSA id u63sm33931206pgd.16.2019.04.13.20.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 20:32:03 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
X-Google-Original-From: Wang Shilong <wshilong1991@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Shuichi Ihara <sihara@ddn.com>
Subject: [PATCH] fstrim: get realpath before trim ioctl
Date:   Sun, 14 Apr 2019 12:31:56 +0900
Message-Id: <1555212716-22911-1-git-send-email-wshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Original motivation is we want to run fstrim command
on Lustre[1] osd server mount point directly, however
our server mount point doesn't export osd directory
to users, and it will cause following command fail:

 $fstrim -v /mnt/mds/

But following succeed:

 $fstrim -v /mnt/mds

We could improve this a bit by getting realpath
before trapping kernel, this also give benifits
to normal use cases.

Cc: Andreas Dilger <adilger@dilger.ca>
Cc: Shuichi Ihara <sihara@ddn.com>
[1] http://wiki.lustre.org/Main_Page
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 sys-utils/fstrim.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sys-utils/fstrim.c b/sys-utils/fstrim.c
index 175717114..830556458 100644
--- a/sys-utils/fstrim.c
+++ b/sys-utils/fstrim.c
@@ -67,14 +67,20 @@ struct fstrim_control {
 /* returns: 0 = success, 1 = unsupported, < 0 = error */
 static int fstrim_filesystem(struct fstrim_control *ctl, const char *path, const char *devname)
 {
-	int fd, rc;
+	int fd = -1, rc;
 	struct stat sb;
 	struct fstrim_range range;
+	char *rpath = realpath(path, NULL);
 
+	if (!rpath) {
+		warn(_("cannot get realpath: %s"), path);
+		rc = -errno;
+		goto done;
+	}
 	/* kernel modifies the range */
 	memcpy(&range, &ctl->range, sizeof(range));
 
-	fd = open(path, O_RDONLY);
+	fd = open(rpath, O_RDONLY);
 	if (fd < 0) {
 		warn(_("cannot open %s"), path);
 		rc = -errno;
@@ -129,6 +135,7 @@ static int fstrim_filesystem(struct fstrim_control *ctl, const char *path, const
 done:
 	if (fd >= 0)
 		close(fd);
+	free(rpath);
 	return rc;
 }
 
-- 
2.21.0


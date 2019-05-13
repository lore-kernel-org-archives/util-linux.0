Return-Path: <SRS0=wrJr=TN=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B356FC04AA7
	for <util-linux@archiver.kernel.org>; Mon, 13 May 2019 18:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF982085A
	for <util-linux@archiver.kernel.org>; Mon, 13 May 2019 18:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQteFfhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbfEMSx1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 13 May 2019 14:53:27 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:38806 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728693AbfEMSx1 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 13 May 2019 14:53:27 -0400
Received: by mail-qt1-f169.google.com with SMTP id d13so8904798qth.5
        for <util-linux@vger.kernel.org>; Mon, 13 May 2019 11:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QdYf7k/sC0g8eChNkqZFwNnXUZSdcaCjFQRkiuxJASM=;
        b=mQteFfhh3hPTpvWO3xt9PI21zwquSzbDAw8MNztgTp5NHoI4U6so7i/5GOnn4dz8qX
         2xDXAbru8rescq8E1F1RgDL+X9GvIXRfL39FPkBTOGUF4xURBrSFxzbZ3t2GphUnFYhP
         kM62aDfXd9IJMGgif0dZlVtVbQdPLSYj6B0kSSgC79f1zZfGr+1bPnKwiUQJpdEn+TPB
         w50srPzJy67NMjHKKC3WjGZjefH/A2BAi8iwQE/70AqozgbHI4+4RmvCbTxpCVNyyedv
         dVHnuEWf2Ryz61zZaKFLorNAaDNwHaVMSjIQUn2ndiZEm0eOZRmNd70r/1GqqHG35G5g
         4CcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QdYf7k/sC0g8eChNkqZFwNnXUZSdcaCjFQRkiuxJASM=;
        b=MEXtKrBBu5TQY9j58OGH5d0q3di+lrSo+EzY17T+KUNQUE7NRcKVmQ3FeLH5KfnO9u
         nzHmXcxooh3KK1HELt1SnXLmh50JSW0VTeNVKUUaoHIUA9/FbDTngBvhoHINVfzqvyBz
         H+2nnH+KmIzzr+81Y9ZikbpnrThbGkSy8fQO5JbKHFgOJkkr4bXLcb/bQydteBTID9VP
         2TlFK325DOvQIKfUsiEJNH7N86nXOlM2iwINL8m307UErQ1j+RZWCZJ3Ehic8d1b0Fab
         L/qVDaiiHeM7zCqo/Ij7KYOp0F+T2srnm9nQ9/SYWpJ2zrk57yTImpuMpF+h13lM5/kH
         4XuQ==
X-Gm-Message-State: APjAAAXaUt32DA2leUYorZBP9liFyjffO0xYHBcnMZa0BqiJISJQr/BN
        ILHPRKhAve3bzH8NTgB9hQXcfXEPDa4=
X-Google-Smtp-Source: APXvYqwX1p0/WmCtEaocqQ/mkOitWhcgGqtx5H/rNRHa5CPn/l9YZlQ3ZkRntVQTCrJSUoELQC6+UA==
X-Received: by 2002:ac8:3702:: with SMTP id o2mr25542579qtb.119.1557773605563;
        Mon, 13 May 2019 11:53:25 -0700 (PDT)
Received: from austin2.ad.gaikai.biz ([100.42.103.4])
        by smtp.gmail.com with ESMTPSA id n66sm7577631qkf.49.2019.05.13.11.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 11:53:24 -0700 (PDT)
From:   Austin English <austinenglish@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Austin English <austinenglish@gmail.com>
Subject: [PATCH 3/6] misc-utils/lsblk.8: fix "maybe be" duplication
Date:   Mon, 13 May 2019 13:53:16 -0500
Message-Id: <20190513185319.28853-3-austinenglish@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190513185319.28853-1-austinenglish@gmail.com>
References: <20190513185319.28853-1-austinenglish@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Austin English <austinenglish@gmail.com>
---
 misc-utils/lsblk.8 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/misc-utils/lsblk.8 b/misc-utils/lsblk.8
index 320158278..2910ee356 100644
--- a/misc-utils/lsblk.8
+++ b/misc-utils/lsblk.8
@@ -67,8 +67,8 @@ example by \fB\-E WWN\fR.
 .TP
 .BR \-e , " \-\-exclude " \fIlist\fP
 Exclude the devices specified by the comma-separated \fIlist\fR of major device numbers.
-Note that RAM disks (major=1) are excluded by default if \fB\-\-all\fR is no specified.
-The filter is applied to the top-level devices only. This maybe be confusing for
+Note that RAM disks (major=1) are excluded by default if \fB\-\-all\fR is not specified.
+The filter is applied to the top-level devices only. This may be confusing for
 \fB\-\-list\fR output format where hierarchy of the devices is not obvious.
 .TP
 .BR \-f , " \-\-fs"
@@ -83,7 +83,7 @@ Display help text and exit.
 .TP
 .BR \-I , " \-\-include " \fIlist\fP
 Include devices specified by the comma-separated \fIlist\fR of major device numbers.
-The filter is applied to the top-level devices only. This maybe be confusing for
+The filter is applied to the top-level devices only. This may be confusing for
 \fB\-\-list\fR output format where hierarchy of the devices is not obvious.
 .TP
 .BR \-i , " \-\-ascii"
-- 
2.21.0


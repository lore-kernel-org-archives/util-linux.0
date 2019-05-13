Return-Path: <SRS0=wrJr=TN=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF12C04AA7
	for <util-linux@archiver.kernel.org>; Mon, 13 May 2019 18:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B952085A
	for <util-linux@archiver.kernel.org>; Mon, 13 May 2019 18:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfxXKITF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfEMSx2 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 13 May 2019 14:53:28 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32878 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728693AbfEMSx2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 13 May 2019 14:53:28 -0400
Received: by mail-qt1-f195.google.com with SMTP id m32so12978013qtf.0
        for <util-linux@vger.kernel.org>; Mon, 13 May 2019 11:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DJ6uABkoRwnW22QmnNPpIHk3PDwwt2cDSsCSrjXHL3k=;
        b=FfxXKITFc6y/+kk++PDfBXHKsEVicecwbzsCbrAAHhEHyWXsZSVCT/i0j0eCzKohp6
         jQCla5Uz+P/OyyiBWuWwPV8+m8awbpu6rcedLI1ory8LxwNKcXmjMgO2o569uo7C8hcR
         YxA+DhasuKJnQh4SWfDSTivmvlMxqOg7sPLL7CZNeiPVb/V0ExpaufWgPRQefp0o6jsb
         ibmrAQcgnVueNSUKYBfBIlUIiCDuPmvpOKqekVfxm/o+wtltYgKYPagO//b8K1320JOk
         e+bon0522bvntwrQ9gxqmw7EAiCd7vfyHzQTozjgiF9L6TUyyePUz3B4CfbI/ZeStAPV
         3aWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DJ6uABkoRwnW22QmnNPpIHk3PDwwt2cDSsCSrjXHL3k=;
        b=i2RnV8AlpOerAjf4iWTKFeo0pQUI/XqsMLvNJ+DXQDL8LMniOAxRPRNpHoCLDmKeJm
         ZdS5AzvFq6GXFUts0sMM0uLN1uQKM5l8ABWOUZIji4ntnLrls8MpyghCd2OsS2Iph3El
         DnpYGncmefWDniRtuJPhdUDGJ+dy7OGa3SMVUcPTEJA9kmhMzVuB0RWuqwA369vOtURk
         LoXtGMXpocwXFALQP2Vw/zIyqApjdKmaiymVaePMjzKrjPnDJoSH9kVYMvxq0oXxlgvH
         dWn+u/DlXKXGMXxTFdydwaRLR8RChHBNLYVu0EFRUKvK6Xloe1WBOgCGMze0Pk4CNJDB
         fzHg==
X-Gm-Message-State: APjAAAUjTuni++kCqIQiNzIiC37XkedLXt1tG0Z+VazH9X+3uA5SoMpq
        UlmDCa0tsYCwIUDnDXm9Dd4t2hlhttk=
X-Google-Smtp-Source: APXvYqxZo5ggFhtthVgDxwZb0rcPJfa4Yd8XyErO2VJB6hrk4uv/uGpeqhozEG8fvrTWU9c2v7Iy3Q==
X-Received: by 2002:ac8:2c9d:: with SMTP id 29mr25764339qtw.123.1557773606748;
        Mon, 13 May 2019 11:53:26 -0700 (PDT)
Received: from austin2.ad.gaikai.biz ([100.42.103.4])
        by smtp.gmail.com with ESMTPSA id n66sm7577631qkf.49.2019.05.13.11.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 11:53:25 -0700 (PDT)
From:   Austin English <austinenglish@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Austin English <austinenglish@gmail.com>
Subject: [PATCH 4/6] sys-utils/mount.8: fix "maybe be" duplication
Date:   Mon, 13 May 2019 13:53:17 -0500
Message-Id: <20190513185319.28853-4-austinenglish@gmail.com>
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
 sys-utils/mount.8 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index ccba52c32..b79b4ef5f 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -114,10 +114,10 @@ options to avoid ambivalent interpretation of the given argument.  For example:
 .RE
 
 The same filesystem may be mounted more than once, and in some cases (e.g.
-network filesystems) the same filesystem maybe be mounted on the same
+network filesystems) the same filesystem may be mounted on the same
 mountpoint more times. The mount command does not implement any policy to
-control this behavior. All behavior is controlled by kernel and it is usually
-specific to filesystem driver. The exception is \fB\-\-all\fR, in this case
+control this behavior. All behavior is controlled bythe  kernel and it is usually
+specific to the filesystem driver. The exception is \fB\-\-all\fR, in this case
 already mounted filesystems are ignored (see \fB\-\-all\fR below for more details).
 
 .SS Listing the mounts
@@ -362,7 +362,7 @@ It is important to understand that "bind" does not to create any second-class
 or special node in the kernel VFS. The "bind" is just another operation to
 attach a filesystem. There is nowhere stored information that the filesystem
 has been attached by "bind" operation. The \fIolddir\fR and \fInewdir\fR are
-independent and the \fIolddir\fR maybe be umounted.
+independent and the \fIolddir\fR may be umounted.
 
 One can also remount a single file (on a single file).  It's also
 possible to use the bind mount to create a mountpoint from a regular
-- 
2.21.0


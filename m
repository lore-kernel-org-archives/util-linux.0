Return-Path: <SRS0=w+SW=AX=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF7FC433E1
	for <util-linux@archiver.kernel.org>; Sun, 12 Jul 2020 10:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 735EB206F0
	for <util-linux@archiver.kernel.org>; Sun, 12 Jul 2020 10:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+ISyrxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgGLKlB (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 12 Jul 2020 06:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbgGLKlA (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 12 Jul 2020 06:41:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C761C061794
        for <util-linux@vger.kernel.org>; Sun, 12 Jul 2020 03:41:00 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z13so10033368wrw.5
        for <util-linux@vger.kernel.org>; Sun, 12 Jul 2020 03:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8XNMGs3H6RmnTVukwxmPnNoLhYPHO9ES4gOLs6UO1a0=;
        b=P+ISyrxooJpZroAT713rAX9ZWxSSPKt57df7MeePFu8QkxZhisEzktEjjxBR44ZDeL
         B97h5W5NYPKQ/Bpw8rv0KFb/Hi4CHaz++jGQDaMFa+RNm8tR1hEvCpBSUHhTOV2Dfw9E
         XLJiVlnLjaQtG6qGsyu5FQH63nsV4ZlsjFIm1ZZIDQyjNGYMPxkdUvm3qz8oSh2+2w/P
         UPEmjkW1sA5/7Bvn+1FWvrixRNv0+Mcbl/sZdRbHGo/OwHbKF5My2ykA63mY3Jq2Ui5M
         /FUhProFXganrZwS2bOsfDDwcLMBIvr3rsEP4+TEb94OXrOqVNxpYeFwCeJEQqGjaMvS
         FcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8XNMGs3H6RmnTVukwxmPnNoLhYPHO9ES4gOLs6UO1a0=;
        b=cJpsDpzipPk+S7SP3uz+rPV0vs8eL7hN+Fn88nffh66SuuZ7L45NlAnWyJQsyY9/GU
         dnwomdrmyR55sAGbZVurQBl6+LvmYdlimdWv6dJhYO1ypwiciHEBw+RDxjtVLCnBk1tg
         vDLruT78qEfMrqWVK/Ab2jZ5CeXa273C7VOeHqU7L331Nc6WPUzeCJGu5PXCQeiVHR1k
         p1AemDP58BOb5UkdA0Xx1lLvRL4UBAUmhJqR8MXhdLhp+7FedFNINiAPabrOpX6ajuvh
         AvxbdL2fCCxN2WOtt/zFoUqAPnu7Z1j/w3nyb2C9bKM4e5KFkTjVlgxYeQJMyK0dVeWw
         tJIw==
X-Gm-Message-State: AOAM533L8pZ+kP1XQcq6ltdNOPAWBwttoyHyYZlIp1rrZLAsaf5dnOzD
        6KLdRLTjifiQos1Nz9s/Mf8GF7rq
X-Google-Smtp-Source: ABdhPJx4m/+UnGGLjQz6603CTzxfbYuJ3AcFFyjrKXAn/3o5D+n2DxRvcw8vMfcvCJeWwUd9zfJuug==
X-Received: by 2002:a5d:6a06:: with SMTP id m6mr74537338wru.321.1594550458565;
        Sun, 12 Jul 2020 03:40:58 -0700 (PDT)
Received: from merlot.mazyland.net (dynamic-2a00-1028-8d1c-8c9e-b33d-9d5e-0500-19b7.ipv6.broadband.iol.cz. [2a00:1028:8d1c:8c9e:b33d:9d5e:500:19b7])
        by smtp.googlemail.com with ESMTPSA id 65sm21181757wre.6.2020.07.12.03.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 03:40:57 -0700 (PDT)
From:   Milan Broz <gmazyland@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Milan Broz <gmazyland@gmail.com>
Subject: [PATCH] lsblk: Add SERIAL column to the SCSI output mode.
Date:   Sun, 12 Jul 2020 12:40:48 +0200
Message-Id: <20200712104048.89908-1-gmazyland@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

If there are several identical disks, disk serial number can help
to distinguish exact drive.

This could be helpful in debugging RAID failures and similar problems.

Signed-off-by: Milan Broz <gmazyland@gmail.com>
---
 misc-utils/lsblk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 3f21dcee2..1ec709019 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -1994,6 +1994,7 @@ int main(int argc, char *argv[])
 			add_uniq_column(COL_VENDOR);
 			add_uniq_column(COL_MODEL);
 			add_uniq_column(COL_REV);
+			add_uniq_column(COL_SERIAL);
 			add_uniq_column(COL_TRANSPORT);
 			break;
 		case 'T':
-- 
2.27.0


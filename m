Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AA6C433EF
	for <util-linux@archiver.kernel.org>; Fri, 11 Mar 2022 16:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350355AbiCKQ1p (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350420AbiCKQ1C (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 11 Mar 2022 11:27:02 -0500
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1A510DA4B
        for <util-linux@vger.kernel.org>; Fri, 11 Mar 2022 08:25:31 -0800 (PST)
X-KPN-MessageId: b17f244c-a157-11ec-8338-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id b17f244c-a157-11ec-8338-005056999439;
        Fri, 11 Mar 2022 17:24:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telfort.nl; s=telfort01;
        h=mime-version:message-id:date:subject:to:from;
        bh=mfz+CSF8Cbw5s+OXy7L6fEVFCcfJfbBgh34iFP4QbeQ=;
        b=MdJH0vSIs5jBe8oFSl7XFwXTdU5bC3Tn7vJya55ByodiTdG7nSJYrQ/xIn2UoVTlSixDiWKN/ZsZV
         adeLHJFLk9qfMTZAopxd/BcAdHwhscs1qPrQTwONPm5pZpmgvEUGcmVryz8Yf4Goub+DsFyNtmL1CH
         CNyqn1CnaLJgluik=
X-KPN-MID: 33|CILLu5Vp+s2m/9GTEfBbG1KBQK7731LEJLSp/Qhjy2hKwEBVDaUuOiDcVP6fn0/
 b1yHWjaKaQsicn9tneHLc2w==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|0LIjtGPVs5C0FyJeBUbDCJHMGrMSIV6GsjRsa2HXnjXc3NsfG+piT5xF0rBKhlE
 kF5AdVaHJaYT7Cl/IWsj0Cw==
X-Originating-IP: 82.168.50.91
Received: from localhost (82-168-50-91.fixed.kpn.net [82.168.50.91])
        by smtp.kpnmail.nl (Halon) with ESMTPSA
        id b898f7fc-a157-11ec-b2a4-005056998788;
        Fri, 11 Mar 2022 17:24:27 +0100 (CET)
From:   Benno Schulenberg <bensberg@telfort.nl>
To:     util-linux@vger.kernel.org
Subject: [PATCH 2/2] hardlink: grammarize the main description in the man page
Date:   Fri, 11 Mar 2022 17:23:38 +0100
Message-Id: <20220311162338.4375-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220311162338.4375-1-bensberg@telfort.nl>
References: <20220311162338.4375-1-bensberg@telfort.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

(Also hard-wrap the extremely long line to resonable widths,
so that later small changes are easier to observe in git.)

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/hardlink.1.adoc | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/misc-utils/hardlink.1.adoc b/misc-utils/hardlink.1.adoc
index 851bb285d..5e13fde19 100644
--- a/misc-utils/hardlink.1.adoc
+++ b/misc-utils/hardlink.1.adoc
@@ -22,9 +22,18 @@ hardlink - link multiple copies of a file
 
 == DESCRIPTION
 
-*hardlink* is a tool which replaces copies of a file with hardlinks or copy-on-write clones, therefore saving space.
-
-*hardlink* creates a binary tree from file sizes and after that, it compares files with the same sizes. There are two basic content comparison methods. *memcmp* method directly reads data blocks from files and compares them. The other method is based on checksums (like SHA256), in this case for each data block is calculated checksum by Linux kernel crypto API, and this checksum is stored in userspace and used for files comparison. For each file is also cached "intro" buffer (32 bytes), this buffer is used independently on the comparison method and requested cache-size and io-size. The "intro" buffer dramatically reduces operations with data content as files are very often different from the beginning.
+*hardlink* is a tool that replaces copies of a file with either hardlinks or copy-on-write
+clones, thus saving space.
+
+*hardlink* first creates a binary tree of file sizes and then compares the content of files
+that have the same size. There are two basic content comparison methods. The *memcmp* method
+directly reads data blocks from files and compares them. The other method is based on checksums
+(like SHA256); in this case for each data block a checksum is calculated by the Linux kernel
+crypto API, and this checksum is stored in userspace and used for file comparisons.
+
+For each file also an "intro" buffer (32 bytes) is cached. This buffer is used independently
+from the comparison method and requested cache-size and io-size. The "intro" buffer dramatically
+reduces operations with data content as files are very often different from the beginning.
 
 == OPTIONS
 
-- 
2.34.1


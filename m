Return-Path: <SRS0=zMQF=BD=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4F1C433E5
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 10:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EABA206E3
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 10:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gkcz4zQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgGXKHT (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXKHT (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 24 Jul 2020 06:07:19 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0A5C0619D3
        for <util-linux@vger.kernel.org>; Fri, 24 Jul 2020 03:07:18 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id g7so1136194ejw.12
        for <util-linux@vger.kernel.org>; Fri, 24 Jul 2020 03:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fr0ao1JuhZ6VMu9o89pCVyVA0j+qzz7VhGolFe3l7G4=;
        b=Gkcz4zQd6sor0Kj96y5qH8hjYhtVpc0dSAfZ+eedE3pSLsAwqZ8rk8xcCfn7lu+7vT
         NIBILHivZU30i98I5QRBfEUBol+WqdP7+gxDCW3dNdMjhO4mERSVJeUME/uhfvViHT+G
         1wnwrNH5YO/rsFnVb4d8AM7ldXBvndhSnIv11rqV5y0m4zwh8IF62sG6YYXtogDJenFK
         MW8KFhFJjx5Yz8TWT60261lcnd4W/ZvgWQ4lw7UP53ArKDehGoYByP99bg8VGetX2lsC
         MreHeloGQqqpMbLzamcdmCtQb9sGAz/jqXJgvfmzB5vlmymyIkEwrNktUeu9PWIPKUZv
         lQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fr0ao1JuhZ6VMu9o89pCVyVA0j+qzz7VhGolFe3l7G4=;
        b=tU805JgXiTt3k3wWRGAoONckFIYoniH6KPlmZrV95V8R1AyYSuajSzDdpk78u/hOML
         DhpYiXNh+mdkWzx9XLOigK0jqBVdBo3K9fS8YH4TsQVYxv91mctsK9ELwTPPVb42EBuQ
         c1u5pad2YXkx/eZwlRu7E5YiHkODPcoj1NtgdzAUZkAbCr4x+oW2seBeIycsy/ONZDQw
         AOwsrCG7OjoYg2SJXC0czAsB6zc6h1Cyl6d7DKoTKpobiQsZsqekLQBwTWYRWxkHFrrZ
         1e+Xn5YScMVh1MlZsYNhqgBwqotMNJHsGmIO/aLcqKjYSZHD2SyU4P5iaHmht1FfeyhA
         KRRw==
X-Gm-Message-State: AOAM532cU1KixjcZRQ3rJ6LN4C8V+CtbQBGXZ/GKu9Kub6ZaqOwV9eft
        jVk2vYcI7zK/JlAFy9NeEteqWcYC
X-Google-Smtp-Source: ABdhPJyiIrl1d54cegcmKFjcM8fEIueCnvSli5WG9hHwRka/JlWMNSaQ+lA6UB7sMtvvc7lnqDUn7g==
X-Received: by 2002:a17:906:a219:: with SMTP id r25mr951236ejy.201.1595585237424;
        Fri, 24 Jul 2020 03:07:17 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id a1sm344273ejk.125.2020.07.24.03.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 03:07:17 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 12/12] Manual pages: wipefs.8: Formatting fixes
Date:   Fri, 24 Jul 2020 12:06:18 +0200
Message-Id: <20200724100618.584918-12-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200724100618.584918-1-mtk.manpages@gmail.com>
References: <20200724100618.584918-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 misc-utils/wipefs.8 | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/misc-utils/wipefs.8 b/misc-utils/wipefs.8
index cdc6b2811..0ffe1f183 100644
--- a/misc-utils/wipefs.8
+++ b/misc-utils/wipefs.8
@@ -28,7 +28,9 @@ to make the signatures invisible for libblkid.
 .B wipefs
 does not erase the filesystem itself nor any other data from the device.
 
-When used without any options, wipefs lists all visible filesystems and the
+When used without any options,
+.B wipefs
+lists all visible filesystems and the
 offsets of their basic signatures.  The default output is subject to change.
 So whenever possible, you should avoid using default outputs in your scripts.
 Always explicitly define expected columns by using
@@ -89,8 +91,9 @@ tools.
 Do not print a header line.
 .TP
 .BR \-O , " \-\-output " \fIlist\fP
-Specify which output columns to print.  Use \-\-help to
-get a list of all supported columns.
+Specify which output columns to print.  Use
+.B \-\-help
+to get a list of all supported columns.
 .TP
 .BR \-n , " \-\-no\-act"
 Causes everything to be done except for the write() call.
@@ -116,7 +119,8 @@ Suppress any messages after a successful signature wipe.
 Limit the set of printed or erased signatures.  More than one type may
 be specified in a comma-separated list.  The list or individual types
 can be prefixed with 'no' to specify the types on which no action should be
-taken.  For more details see mount(8).
+taken.  For more details see
+.BR mount (8).
 .TP
 .BR \-V , " \-\-version"
 Display version information and exit.
-- 
2.26.2


Return-Path: <SRS0=zF+j=7F=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D426C433E1
	for <util-linux@archiver.kernel.org>; Sat, 23 May 2020 06:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 544EC2072C
	for <util-linux@archiver.kernel.org>; Sat, 23 May 2020 06:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtDWH+jN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387457AbgEWGnc (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 23 May 2020 02:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387466AbgEWGna (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 23 May 2020 02:43:30 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08D8C05BD43
        for <util-linux@vger.kernel.org>; Fri, 22 May 2020 23:43:29 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id s19so10925031edt.12
        for <util-linux@vger.kernel.org>; Fri, 22 May 2020 23:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fgY9tJ1EYfwvVUjRB9jR/QNiCupjBEmHvK6EDb2c3A4=;
        b=WtDWH+jNKJT+0M0SB+aOJBYxqFf6gJoyBpmi/iXTuSL9nheM2SwkPHN1GyoAzpa84M
         l5RSMntNQvl4qtVOD22rJRd8CWmixBtzmembL5h8RRTh2coqbSWSfsed/9AGJ57HH3bH
         3Jz3ja15czDcu1PHZC9szG790YFxoSqc2c3YG04BujiX2ypaIuArn3Jn2y4XI3pM82zw
         kIgWWnRlUu8kverqRWjXAX3XAzb/JIuo6NRFEZnRcQda4oCaUUpaaCI6wxQF0tj7bYhH
         OvjiqzJ0TZct7D1PHJTeX27gYYTWxOuLcZDybR6jmjRGIOc+Dp/FXshuu7n71kpQM9CR
         5h3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fgY9tJ1EYfwvVUjRB9jR/QNiCupjBEmHvK6EDb2c3A4=;
        b=HUGBcHb3AEp4h+OOASgDXSzAL5TOTDOv22T1na6OGEa3RMWT7VNpkiwtyU//GijFEe
         TdyRok9wCB+oB+BaNg4OTp8cl3y5elgT4SOG9V/1f7PPmFozBxiplfNK4ujXa/HpO9zl
         yFqXfoaAUn40qzzSy7VPc9XIuJzVr9lvJ5afNrVL4h7RQVBMaEtA/nOTZYh40EWmqoSi
         MeKgyXtPOXAC0uN8V97DLqC94bgwyL61dPUvlNfv5O4BV4XJucX5BPzN5NA5SKg6U8S7
         BN+Sgzf6inQJnf2XPzhrE7Lfg2HwIEWs93RapiJSPdYTXp4PyIuB2IvZpuQRrtnPA0On
         REQg==
X-Gm-Message-State: AOAM530t5mj39eMm6RxYsnkS9VOpgQ/K6ybv2czDNYxZ12am77u7ToIx
        j4IgllSV4WJRxFAdx0jwQQA=
X-Google-Smtp-Source: ABdhPJzWlGTqVXsWTAI7gNp01uyWOeF4xr5mcI3u5gEnmoyM/mYrCkTEFdXYRwqrkYUPpU+rBRbLvA==
X-Received: by 2002:a50:ec8d:: with SMTP id e13mr6289507edr.8.1590216208714;
        Fri, 22 May 2020 23:43:28 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id q22sm3240523edg.97.2020.05.22.23.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 23:43:28 -0700 (PDT)
From:   Michael Kerrisk <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 2/9] Manual pages: nsenter.1, unshare.1: add a reference to time_namespaces(7)
Date:   Sat, 23 May 2020 08:43:18 +0200
Message-Id: <20200523064325.78491-2-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523064325.78491-1-mtk.manpages@gmail.com>
References: <20200523064325.78491-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Linux man-pages now has a page describing time namespaces.

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 sys-utils/nsenter.1 | 2 ++
 sys-utils/unshare.1 | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/sys-utils/nsenter.1 b/sys-utils/nsenter.1
index 2f45df66d..299107609 100644
--- a/sys-utils/nsenter.1
+++ b/sys-utils/nsenter.1
@@ -99,6 +99,8 @@ The process can have a distinct view of
 and/or
 .B CLOCK_BOOTTIME
 which can be changed using \fI/proc/self/timens_offsets\fP.
+For further details, see
+.BR time_namespaces (7).
 .TP
 See \fBclone\fP(2) for the exact semantics of the flags.
 .SH OPTIONS
diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 2665ca0af..db67b0d4c 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -111,6 +111,8 @@ The process can have a distinct view of
 and/or
 .B CLOCK_BOOTTIME
 which can be changed using \fI/proc/self/timens_offsets\fP.
+For further details, see
+.BR time_namespaces (7).
 .SH OPTIONS
 .TP
 .BR \-i , " \-\-ipc" [ =\fIfile ]
-- 
2.26.2


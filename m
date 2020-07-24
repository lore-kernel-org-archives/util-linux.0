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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459A8C433E1
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 10:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FE23206E3
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 10:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCOgI0E0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgGXKHC (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXKHC (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 24 Jul 2020 06:07:02 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91D6C0619D3
        for <util-linux@vger.kernel.org>; Fri, 24 Jul 2020 03:07:00 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id ga4so9374143ejb.11
        for <util-linux@vger.kernel.org>; Fri, 24 Jul 2020 03:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jdv7OExKPGnJxpH7NmzOqW0aYV63dpPPHjY2KdTb7xs=;
        b=qCOgI0E0STgTuqxSeYDKRsXuk1XcG3sSYdORndx8mN97MEpS3pJk2w5psxrgBvzpN8
         8CEYvZ2raNH2cgLBG/oV4V1F7acsk0WEWAOaSSRzLX4ACDDeJpJkfWDDiAa75EXcnj23
         zp0fbNoH5jux/3uIbXYiWLJftpnnPGvxQYsfJEy3ZHGra89piJccTwSGhZ4S+5GEg6yE
         K7/DMgpd1iAyR0VjNFW5mfbut3DqfpUGzIInxMTUY9APeuSZRzeMmlAQKJux1O7L2nXs
         +hBtP/z3DeHJcWX50dio6MeuuIypsPL9HkKubiqVSNpHKHZJDZ7ZTRgWQxCMJA8SVQHE
         1Fig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jdv7OExKPGnJxpH7NmzOqW0aYV63dpPPHjY2KdTb7xs=;
        b=DQfX2ttJ0A4HgtREUnyzMxqNH0zFso21LPYx7Tax+dO/1e1CqFWcq5krYPmHRYQgn7
         ct7sFlUG8prsJQx0bkjl9O8krDhw5WHyhIxGbA0SjIoXiU2s9oiUKmoZL3ZZFILpuZEE
         P68lFFBr8HV3ZE250EPY2h7acwiR2XlAzuDqv/vb9gdyK6ZeCOCmuNLgju8p94jHbrRE
         F4t/fT75WT5p8a6wfgEdYn0jvinp5fp+Mk1xyPNKcHBx+cKYiUw/3oINZnrZ/DlPQBWD
         JzQmtpjRG+KmlpS4a/Ky8y9Ql2H6cPhaWaah+qljedi/EBrfdPx8L3qe+gK9hHakhuBh
         vuyg==
X-Gm-Message-State: AOAM530ZidMW+oEi5WHPycGqYgFSQfidtDxwZJgvpzXWZJC9Wl1VW1t1
        LrGqMwKgjjf336NEk+5ips+YDcnq
X-Google-Smtp-Source: ABdhPJyTSFI6HKCof0TKph3NNIcJd+rUhP+CHu7G+iK2BNNvH9YzHs63XVrJz8RHjcNsFnog0oD+dg==
X-Received: by 2002:a17:906:2641:: with SMTP id i1mr8816973ejc.380.1595585219559;
        Fri, 24 Jul 2020 03:06:59 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id y24sm342964ejj.97.2020.07.24.03.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 03:06:59 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 08/12] Manual pages: logger.1: minor formatting and typo fixes
Date:   Fri, 24 Jul 2020 12:06:14 +0200
Message-Id: <20200724100618.584918-8-mtk.manpages@gmail.com>
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
 misc-utils/logger.1 | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index 448311d03..f9c2b6b9e 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -49,8 +49,10 @@ given either, then standard input is logged.
 .TP
 .BR \-d , " \-\-udp"
 Use datagrams (UDP) only.  By default the connection is tried to the
-syslog port defined in /etc/services, which is often 514 .
-.sp
+syslog port defined in
+.IR /etc/services ,
+which is often 514.
+.IP
 See also \fB\-\-server\fR and \fB\-\-socket\fR to specify where to connect.
 .TP
 .BR \-e , " \-\-skip-empty"
@@ -75,7 +77,9 @@ command's PID.  The use of \fB\-\-id=$$\fR
 (PPID) is recommended in scripts that send several messages.
 
 Note that the system logging infrastructure (for example \fBsystemd\fR when
-listening on /dev/log) may follow local socket credentials to overwrite the
+listening on
+.IR /dev/log )
+may follow local socket credentials to overwrite the
 PID specified in the message.
 .BR logger (1)
 is able to set those socket credentials to the given \fIid\fR, but only if you
-- 
2.26.2


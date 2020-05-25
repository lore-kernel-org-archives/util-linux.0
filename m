Return-Path: <SRS0=uTWB=7H=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29884C433E1
	for <util-linux@archiver.kernel.org>; Mon, 25 May 2020 12:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AF262073B
	for <util-linux@archiver.kernel.org>; Mon, 25 May 2020 12:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xqz532Ia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388763AbgEYM70 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 25 May 2020 08:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388738AbgEYM70 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 25 May 2020 08:59:26 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC56C061A0E
        for <util-linux@vger.kernel.org>; Mon, 25 May 2020 05:59:25 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id f13so14327723edr.13
        for <util-linux@vger.kernel.org>; Mon, 25 May 2020 05:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MK6kWqyjKNHWCBax0HUvxrCUzDq+TqVouoiVhjBzS4o=;
        b=Xqz532Iaw03/Gaqj4W4GehaIYsS5VFENJV2xXP0q5vFFyuXJlhiKAdw14Ou1QQzzwf
         UwvKplG22Oa3Kw2WUoEhrBqO3uwaLN1MTZyYhIfr127Od6HUgS+rF4qULwVc7AZkaxWj
         aJuT0NXKYv+zKJV6AuxIjzzIeWytT79WTJRTmC1RaW4kPeJQvK/WIF/o82vrlD+xknVK
         Ksmlkl/JyK+8heTvCOvflQ8Tpx5qUyAqtEwwMRBUY8cHbtpVdRsQ3hHkOHkqpJLDJitd
         Ctfd4O0RYwF1b29NL3BLsZ4mEX56CxDMackVQAhchsgT5sjj/MqjSgaHXywqw5AzUurC
         L2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MK6kWqyjKNHWCBax0HUvxrCUzDq+TqVouoiVhjBzS4o=;
        b=DYLU3Vtuz/MoBokPsyPzz7hbYttVXt400GA4j1Nx0d7MDnuajVS8t+srzUyRrVXfEK
         ux/sr3CWZxP09/upRRaiAzAtBRpTTZTydSRl/hnjQknHfbDoepXPpO+bMb4Nj2yU0fA/
         OeH3NUNDF5mNJNnj27itaeOx0/XqtXhkyYW4Pr0SR8/L0UpPWbgQUpYfsHRs0QKf5AFo
         qJaCYyL6lW+WcyOms/X+dPS6DTvx7IOrCxyZl1AKa5jtc2OoflCuEYm56WhlRW+0vSnc
         D4i8R5cExG9iHXgyVzOI5/E9oILnpAShYIYkt5bXIfFPVyMgXzWYRZt0N2nnfq41Ikdh
         HnRg==
X-Gm-Message-State: AOAM530X3aoI6vDKbvE+4V54mHQLYHg38IzrDoX56CAlV+ztI+MOBIL4
        nbZhmUP9fg64Aqm6PFrZq8F9puybV0Y=
X-Google-Smtp-Source: ABdhPJwSeofIhy5YU2t48ZQVMJL4cz7qBjVI+vbDqbrGkW/2Efmi2vvhQkPQo1sQb/GRtGSKgq6Oog==
X-Received: by 2002:a05:6402:1d2d:: with SMTP id dh13mr14463643edb.169.1590411564656;
        Mon, 25 May 2020 05:59:24 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id b14sm15709719edx.93.2020.05.25.05.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 05:59:24 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/5] Manual pages: kill.1: improve the description of the --timout option
Date:   Mon, 25 May 2020 14:59:09 +0200
Message-Id: <20200525125912.43748-2-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525125912.43748-1-mtk.manpages@gmail.com>
References: <20200525125912.43748-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The text describing this option is a little hard to understand.
Improve it.

Cc: Sami Kerola <kerolasa@iki.fi>
Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 misc-utils/kill.1 | 48 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/misc-utils/kill.1 b/misc-utils/kill.1
index 1c12f8a14..6ca318a6a 100644
--- a/misc-utils/kill.1
+++ b/misc-utils/kill.1
@@ -127,30 +127,48 @@ field of the
 structure.
 .TP
 \fB\-\-timeout\fR \fImilliseconds signal\fR
-Send a signal defined the usual way to a process.
+Send a signal defined in the usual way to a process,
+followed by an additional signal after a specified delay.
+The
 .B \-\-timeout
-will make
+option causes
 .B kill
 to wait for a period defined in
 .I milliseconds
-before sending follow-up
+before sending a follow-up
 .I signal
-to process.
-This feature is implemented by PID file-descriptor and guarantees that
-follow-up signals are sent to the same process or not sent if the process no
-more exist.  Note that the operating system may re-use PIDs and implement the
-same feature in a shell by kill and sleep commands sequence may introduce a
-race.  This option can be specified more than once than signals are sent
-sequentially in defined timeouts.  The
+to the process.
+This feature is implemented using the Linux kernel
+PID file descriptor feature in order to guarantee that the follow-up signal
+is sent to the same process or not sent if the process no longer exists.
+.IP
+Note that the operating system may re-use PIDs and implementing an
+equivalent feature in a shell using
+.B kill
+and
+.B sleep
+would be subject to races whereby the follow-up signal might be sent
+to a different process that used a recycled PID.
+.IP
+The
+.B \-\-timeout
+option can be specified multiple times: the signals are sent
+sequentially with the specified timeouts.  The
 .B \-\-timeout
-option can be combined with
+option can be combined with the
 .B \-\-queue
 option.
 .IP
-Example.  Send signals QUIT, TERM and KILL in sequence and wait for 1000
-milliseconds between the signals
-.br
-kill \-\-verbose \-\-timeout 1000 TERM \-\-timeout 1000 KILL \-\-signal QUIT 12345
+As an example, the following command sends
+the signals QUIT, TERM and KILL in sequence and waits for 1000
+milliseconds between sending the signals:
+.IP
+.in +4n
+.EE
+kill \-\-verbose \-\-timeout 1000 TERM \-\-timeout 1000 KILL \e
+        \-\-signal QUIT 12345
+.EE
+.in
 .SH EXIT STATUS
 .B kill
 has the following exit status values:
-- 
2.26.2


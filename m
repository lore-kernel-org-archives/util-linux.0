Return-Path: <SRS0=wrJr=TN=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB00DC04AAA
	for <util-linux@archiver.kernel.org>; Mon, 13 May 2019 18:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68B52085A
	for <util-linux@archiver.kernel.org>; Mon, 13 May 2019 18:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBnKniu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfEMSx3 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 13 May 2019 14:53:29 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:45794 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728693AbfEMSx3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 13 May 2019 14:53:29 -0400
Received: by mail-qk1-f181.google.com with SMTP id j1so8671293qkk.12
        for <util-linux@vger.kernel.org>; Mon, 13 May 2019 11:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hv9djyx4Vnon/2ZFrMreAYKHhMLQM22MdDL71lgVMxU=;
        b=jBnKniu8A4NnaawcmAMPif26X6raoZtht/OiwFMTfvjiqLdBjT6uJyrbS57Q2/BF2r
         u5bPzSKfvMIxn8Oq1bYZwGFatns9WdBjymdb44qSiEZotmSUMp5nGRitN2eJLmNU/PsV
         JldoIsfdDcd2cvnTLu9dQmcW6k5y9njiLqn4+iVlrI8bbbjEADupIbNqNThT/KZwjx+E
         iHSUKuDP5ghbntQvjwrLNuLotShmzFX9T7wGwYs8hJqmQbz2Ev7vTxYPS0hCUXFNBTkn
         AMbQ0lNNlWze3fFb3m0Rb3ggzmIhiVTRMyqVF8f6a2fsZi4tWnz/e+Adc8ov6Clw9Lwa
         CVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hv9djyx4Vnon/2ZFrMreAYKHhMLQM22MdDL71lgVMxU=;
        b=HiNKyqSsRicpNZYVFLgnSjOtBeFOBXSkMuK1ts3NCYRKALf4ahDqIuTl56p/I/pXub
         R4xTCfkprXvEQ1kIRCubJlBZXWg+OkhYLKvAtQHqldlFaVPlr3nprez3jLtaA6Mms6QL
         qDVr1EaQgcoYywhQTQ2gMsEDYIHcwxvMXlbk00oMIlQVJcuAZT4MGJddoWlWsq3FQ/Kk
         crfU1fCYepPzSUgryYGoyoFRAWnJi7oO3adbdTw2gSzbbFfGKkhCQkkt2M7gDoN/nkOB
         nPRHuaL5BDHGjROzMP2Rqw/Klsv5H/WR+icTUIzrWtCyTXRVgwHOsMFSp285HhvJwAUa
         z2pA==
X-Gm-Message-State: APjAAAWIlRGzQlj+xa4yOcZPKp2xckujyoPS4lmsdEtzv01UyawdLrgt
        xaH70aoacs6YqqRfFuVoVgUmncA33RQ=
X-Google-Smtp-Source: APXvYqw9MBVgK/8/lL1Bg6ZA3zvKWHBSmeEI1lM9yAf0YHkr+brOlkHORfmeerE3frxYH6CgR4aW0w==
X-Received: by 2002:ae9:e910:: with SMTP id x16mr23648879qkf.35.1557773607895;
        Mon, 13 May 2019 11:53:27 -0700 (PDT)
Received: from austin2.ad.gaikai.biz ([100.42.103.4])
        by smtp.gmail.com with ESMTPSA id n66sm7577631qkf.49.2019.05.13.11.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 11:53:27 -0700 (PDT)
From:   Austin English <austinenglish@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Austin English <austinenglish@gmail.com>
Subject: [PATCH 5/6] sys-utils/rtcwake.8.in: fix "maybe be" duplication
Date:   Mon, 13 May 2019 13:53:18 -0500
Message-Id: <20190513185319.28853-5-austinenglish@gmail.com>
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
 sys-utils/rtcwake.8.in | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/rtcwake.8.in b/sys-utils/rtcwake.8.in
index 167f7f9d1..4f70c39c9 100644
--- a/sys-utils/rtcwake.8.in
+++ b/sys-utils/rtcwake.8.in
@@ -43,10 +43,10 @@ On some systems, this can also be used like \fBnvram-wakeup\fP, waking from stat
 like ACPI S4 (suspend to disk).  Not all systems have persistent media that are
 appropriate for such suspend modes.
 .PP
-Note that alarm functionality depends on hardware; not every RTC is able to setup 
+Note that alarm functionality depends on hardware; not every RTC is able to setup
 an alarm up to 24 hours in the future.
 .PP
-The suspend setup maybe be interrupted by active hardware; for example wireless USB
+The suspend setup may be interrupted by active hardware; for example wireless USB
 input devices that continue to send events for some fraction of a second after the
 return key is pressed.
 .B rtcwake
-- 
2.21.0


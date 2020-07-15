Return-Path: <SRS0=WWhG=A2=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2307C433E4
	for <util-linux@archiver.kernel.org>; Wed, 15 Jul 2020 08:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC2C22067D
	for <util-linux@archiver.kernel.org>; Wed, 15 Jul 2020 08:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agpYtvRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgGOIP6 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729643AbgGOIP6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 15 Jul 2020 04:15:58 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF6BC061755
        for <util-linux@vger.kernel.org>; Wed, 15 Jul 2020 01:15:57 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q15so4472871wmj.2
        for <util-linux@vger.kernel.org>; Wed, 15 Jul 2020 01:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Au/oLtZdtspQb52rzMIfQ75b/zXlTZloOpJbaQmL7Do=;
        b=agpYtvRLiXQh1mPhjHIc0cyQYFoQNy/i0FwE5LiSsMK5TqBEaNb+Wrvv2QJlDJLH+E
         jRxzWRuW1iEAgpGcG0A2COWJwwfc7TnmrwTBVAzvKcm4P0H8/hvc/tAPsH0Ey4D7v+XQ
         jXENFLee85PN55UHG82N0raFYw8LsINKozIgyScfBOZv0PprQJIVddnQCa0o+xWAn/KS
         fePe8OyYS0GM3luY9Am4uOO8AY2ccaUjoNdrOm7PehZGkDxpOTGvxmIghyZa5wOwxKOH
         1+ylnjVkf5yUIoZ2ztYLhh9ihIPhgD+Oq4H1xDxmQU4EEHeLcJnfPASqsScdLJ3yqqQs
         NvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Au/oLtZdtspQb52rzMIfQ75b/zXlTZloOpJbaQmL7Do=;
        b=pePtT+FIzvpDB4cegKHH1CMua4yqAmcA3TAyz5/xnRa+2WNIeABFkdvMnDmXan+Jx6
         MMvQ/myXeY8AO4mv4Osai+ztNNhnNIy7oeGy14837IijJoZU5IEKCSJSbGaNb3NhUKsg
         SAZ5ui0gSEOXwBD2f1NkZELzyCYurLtC1PGyDRctEHdJY8ZtwlSFpU7Az7bnthCLfF3E
         way8vi2vYHq9VwKLUNp8HJatKrbaV/AEATDxcxSFvHnrIW1iHGmWWnAisuqFjj6s39lj
         7Sw60rvSW2eMS5I1Vc34E8FfZyLRc+9Hxe3TzDCHW3z8wefVqzsvhL3iYVSViqliBrGG
         R78A==
X-Gm-Message-State: AOAM530NF+VBv5OipFTSDwY5MDVYF6FKYw32MsLqKRMhBmgHhxSWLnM1
        JlEQ43yrNU/Vpm+AMpzviRo=
X-Google-Smtp-Source: ABdhPJyZndi0VNi8/YapDF9wtPCnlEZCXpK6tjO7uFCjXpTVjmr8ohYL9IT/JJWN2aXond99kOflAA==
X-Received: by 2002:a1c:c242:: with SMTP id s63mr7482260wmf.146.1594800956650;
        Wed, 15 Jul 2020 01:15:56 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id o29sm2562756wra.5.2020.07.15.01.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:15:56 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 2/3] Manual pages: scriptlive.1: Miscellaneous wording, grammar, and formatting fixes
Date:   Wed, 15 Jul 2020 10:15:45 +0200
Message-Id: <20200715081546.112933-2-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200715081546.112933-1-mtk.manpages@gmail.com>
References: <20200715081546.112933-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Nothing too contentious here, I think, so I'm rolling all
of the edits into one patch.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 term-utils/scriptlive.1 | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/term-utils/scriptlive.1 b/term-utils/scriptlive.1
index 236868b8f..fd553ad01 100644
--- a/term-utils/scriptlive.1
+++ b/term-utils/scriptlive.1
@@ -9,17 +9,23 @@ scriptlive \- re-run session typescripts, using timing information
 .RB [ \-I|\-B ]
 .I typescript
 .SH DESCRIPTION
-This program re-run a typescript, using stdin typescript and timing information to ensure that
+This program re-runs a typescript,
+using stdin typescript and timing information to ensure that
 input happens in the same rhythm as it originally appeared when the script
 was recorded.
 .PP
-The \fBsession is executed\fR in newly created pseudo terminal with user's $SHELL
+The \fBsession is executed\fR in a newly created pseudoterminal with
+the user's $SHELL
 (or defaults to /bin/bash).
 .PP
 .B Be careful!
 Do not forget that the typescript may contains arbitrary commands.
 It is recommended to use \fB"scriptreplay \-\-stream in \-\-log\-in typescript"\fR
-(or with --log-io instead of --log-in) to verify the typescript before it is executed by
+(or with
+.B \-\-log\-io
+instead of
+.BR \-\-log\-in\)
+to verify the typescript before it is executed by
 .BR scriptlive (1).
 .PP
 The timing information is what
@@ -47,17 +53,18 @@ File containing \fBscript\fR's timing output.  This option overrides old-style a
 .BR \-T , " \-\-log\-timing " \fIfile\fR
 Aliased to \fB\-t\fR, maintained for compatibility with
 .BR script (1)
-command line options.
+command-line options.
+.TP
 .BR \-d , " \-\-divisor " \fInumber\fR
 Speed up the replay displaying this
 .I number
-of times.  The argument is a floating point number.  It's called divisor
+of times.  The argument is a floating-point number.  It's called divisor
 because it divides the timings by this factor.  This option overrides old-style arguments.
 .TP
 .BR \-m , " \-\-maxdelay " \fInumber\fR
 Set the maximum delay between updates to
 .I number
-of seconds.  The argument is a floating point number.  This can be used to
+of seconds.  The argument is a floating-point number.  This can be used to
 avoid long pauses in the typescript replay.
 .TP
 .BR \-V , " \-\-version"
-- 
2.26.2


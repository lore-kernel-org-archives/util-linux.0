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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE6EC433E5
	for <util-linux@archiver.kernel.org>; Wed, 15 Jul 2020 08:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 618E32067D
	for <util-linux@archiver.kernel.org>; Wed, 15 Jul 2020 08:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCfttLgc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgGOIQD (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729643AbgGOIQC (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 15 Jul 2020 04:16:02 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42228C061755
        for <util-linux@vger.kernel.org>; Wed, 15 Jul 2020 01:16:02 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o8so4445226wmh.4
        for <util-linux@vger.kernel.org>; Wed, 15 Jul 2020 01:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o+gBrPoU3oSYb3HQStke4RnhAjWyBzWOLqiV+38Nbz4=;
        b=LCfttLgc+/H8Bh1guOxsJhEHjzMsjtInYN2ExQgzQFKQk9LnSEMtFAhnLWaJnJhL9o
         ghWs7grovIeHInQS8a6N46rgVqdWbLQno6xfiRNB9RqrAdB2EWszVZOp6jk99hTgwQPz
         tjKA8nHWCFL6hKJtCf9Xjx72T5XhN3NxY3NlX/5GvEkZ8KWOfP5sPhMdwBufJSrwdzTt
         KYpakIEVmAnk3p383XTVhXBnHBFtNq9N0DoFlp1DWcCljiUQtevKQux1puAwXvEl6bKm
         lmNiHEUmdxmgttsssc15VqOvXkpxcCaXu6+54PE38f9aQLr1uY7ZHz2Y/CV0MSr+mln1
         7NBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o+gBrPoU3oSYb3HQStke4RnhAjWyBzWOLqiV+38Nbz4=;
        b=Fu04zii/eAr5wmi55+pzmNtrhxSEL7Gl6sfL+8pEoyFqPV3fA6LVcD3A6wloHp4JEA
         wntzyQlyIpv8t2WNXaCayf4fj/gBKCjX09sE8tSpQ+Gt4k6fCtk5ndlUHOd8+S+7h+XH
         ciM6DBe5UGPS1No5hThNhFd1ReARA8fzLadyscioLks+sCRMc/YmZ4IXm1FVdn+i7r11
         hGMGoZEbKoQDxF71JfTmPOBedJIZFGzWYitBNLH3CDnnhY5hDfzYU+W314zvw22944E0
         Nrs15lLk5k6ea8C2kFZh8rNIZdDVtapwx3e8fWHiKnqITGdfuXAFqNKHFrHs5sp0+SSs
         gx/w==
X-Gm-Message-State: AOAM530dimGPZFzXcMj8+JC2k21c1hqlQcwjTE0rPLqGxXJBE/qdJnws
        A6T5bYzuAFKxDZRux2+Df6s=
X-Google-Smtp-Source: ABdhPJx6jcfaAhFm1MTTyH4khAHnTITaKDBHULmqrtznDNAyQoADaRPN0itf4cnJBs4H1N7I9F756w==
X-Received: by 2002:a1c:309:: with SMTP id 9mr7227622wmd.164.1594800960935;
        Wed, 15 Jul 2020 01:16:00 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id q1sm2315783wro.82.2020.07.15.01.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:16:00 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 3/3] Manual pages: scriptreplay.1: Miscellaneous wording, grammar, and formatting fixes
Date:   Wed, 15 Jul 2020 10:15:46 +0200
Message-Id: <20200715081546.112933-3-mtk.manpages@gmail.com>
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
 term-utils/scriptreplay.1 | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/term-utils/scriptreplay.1 b/term-utils/scriptreplay.1
index 99bf9c3d2..18aadd5f4 100644
--- a/term-utils/scriptreplay.1
+++ b/term-utils/scriptreplay.1
@@ -30,7 +30,7 @@ outputs to file specified by
 .BR \-\-log-timing .
 .PP
 By default, the typescript to display is assumed to be named
-.BR typescript ,
+.IR typescript ,
 but other filenames may be specified, as the second parameter or with option
 .BR \-\-log\-out .
 .PP
@@ -56,20 +56,21 @@ File containing \fBscript\fR's terminal output and input.
 File containing \fBscript\fR's timing output.  This option overrides old-style arguments.
 .TP
 .BR \-T , " \-\-log\-timing " \fIfile\fR
-aliast to \fB\-t\fR, maintained for compatibility with
-.B script (1)
-command line options.
+This is an alias for \fB\-t\fR, maintained for compatibility with
+.BR script (1)
+command-line options.
 .TP
 .BR \-s , " \-\-typescript " \fIfile\fR
 File containing \fBscript\fR's terminal output.  Deprecated alias to \fB\-\-log-out\fR.
 This option overrides old-style arguments.
 .TP
 .BR \-c , " \-\-cr\-mode " \fImode\fR
-Specifies how to use CR (0x0D, carriage return) character from log files.
+Specifies how to use the CR (0x0D, carriage return) character from log files.
 The default mode is
 .IR auto ,
 in this case CR is replaced with line break for stdin log, because otherwise
-scriptreplay will overwrite the same line.  The other modes are
+.B scriptreplay
+would overwrite the same line.  The other modes are
 .I never
 and
 .IR always .
@@ -77,33 +78,36 @@ and
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
 .B \-\-summary
-Display details about session recorded in the specified timing file and exit.  The session has
-to be recorded by
+Display details about the session recorded in the specified timing file
+and exit.  The session has to be recorded using
 .I advanced
 format (see
 .BR script (1))
 option \fB\-\-logging\-format\fR for more details).
 .TP
 .BR \-x , " \-\-stream " \fItype\fR
-Forces scriptreplay to print only specified stream.  The supported stream types
+Forces
+.B scriptreplay
+to print only the specified stream.  The supported stream types
 are
 .IR in ,
 .IR out ,
 .IR signal ,
 or
 .IR info .
-This option is recommended for multi-stream logs (e.g., \-\-log-io)
-to print only specified data.
+This option is recommended for multi-stream logs (e.g.,
+.BR \-\-log-io )
+in order to print only specified data.
 .TP
 .BR \-V , " \-\-version"
 Display version information and exit.
-- 
2.26.2


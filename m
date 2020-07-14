Return-Path: <SRS0=vFYQ=AZ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ED5C433FB
	for <util-linux@archiver.kernel.org>; Tue, 14 Jul 2020 09:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4DB5221FD
	for <util-linux@archiver.kernel.org>; Tue, 14 Jul 2020 09:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwQmHhwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgGNJ6C (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgGNJ6B (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Jul 2020 05:58:01 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A47C061755
        for <util-linux@vger.kernel.org>; Tue, 14 Jul 2020 02:58:01 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id dm19so16376872edb.13
        for <util-linux@vger.kernel.org>; Tue, 14 Jul 2020 02:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bkkec5ru/L9qT+uVOjJumDKjeJzUODApcUQqrlGfrzQ=;
        b=uwQmHhwhwf7fBJzWqIXhnvwRptOtVvmeJzi2+xNtC00YGDQ/PGc/imkyNOw+qko9C3
         zI1g/XkH0MwaB3hBEt41EMjc4sj6/LTUQUl1zWLMVtoL48bwtnEug2hzctGGTcMqVdbf
         /WNdBYRVjDKtfh7qI1i8rLFePJ4mBYJoHVt6x9cjGdiiXfd5AScDAaTOsB+StzdDq+4q
         +JWtmWcEc74slkJQB8ZgkuA1xJ2XGJA5MCdV/Ny5NOswJs6lrbpQWy5boy9gZ4AWl6mf
         dd69hHGO45DEgQ6Bo2gmfIANUR5cy+7uwUUNt/Y2TJzoTfJY97sKdLZjmTc231YnBdFh
         2WmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bkkec5ru/L9qT+uVOjJumDKjeJzUODApcUQqrlGfrzQ=;
        b=hawMBzNMSGJ/2Q3V7wGbS/PMErjcsOgvYSH+6VfjS2JqJMJT7aHP43ig9xLhUXFY9l
         YMu8kp1boA5AbwnCKU4m7WSNS+w1/UrJugCqr08Avb6IXGOWgsh9x6ZW4PTaGFgqTx8r
         TaSiMz4oxdqrqvvyB7OKwVcyjeuS/f2j4icmt/fFgShrYi3YfMn9qOHE1j1ACtWFPHHs
         FGxAev/xXCP68HQIDLYhXh0LG/8dmv20WfTVq12yvK+JjszAerhqNEpnoJOytg6vuL0A
         n0aF9Z6KpdMUZkKoEhVVYuE8l61Lj5+g9TzfTOHTplXwu82X+FplQh0+zPDD/3bmjS5+
         KLdw==
X-Gm-Message-State: AOAM532B6J6GlQQbtH5cEugf1gBaZOqCRa1rYjI5mxz7+XgYH/iRRPKC
        SWfO974pgHJ7WojGpncZAbM=
X-Google-Smtp-Source: ABdhPJwXalv0dh9BUEttmvbLALUwbShd0LtIXTuNxWmMA5qY+Zf4KXHG+mqKrKj4SthLnJf75yirYw==
X-Received: by 2002:a50:c307:: with SMTP id a7mr3510198edb.279.1594720680001;
        Tue, 14 Jul 2020 02:58:00 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id c9sm14119803edv.8.2020.07.14.02.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 02:57:59 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 3/5] Manual pages: login.1: formatting fixes
Date:   Tue, 14 Jul 2020 11:57:39 +0200
Message-Id: <20200714095741.45292-3-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200714095741.45292-1-mtk.manpages@gmail.com>
References: <20200714095741.45292-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Bold for command names; italic for pathnames, etc.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 login-utils/login.1 | 48 +++++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/login-utils/login.1 b/login-utils/login.1
index 3c72480c5..f3938b571 100644
--- a/login-utils/login.1
+++ b/login-utils/login.1
@@ -131,7 +131,9 @@ Used by other servers (i.e.,
 to tell
 .B login
 that printing the hostname should be suppressed in the login: prompt.
-See also LOGIN_PLAIN_PROMPT below if your server does not allow to configure
+See also
+.B LOGIN_PLAIN_PROMPT
+below if your server does not allow to configure
 .B login
 command line.
 .TP
@@ -147,7 +149,7 @@ reads the
 configuration file.  Note that the configuration file could be
 distributed with another package (e.g., shadow-utils).  The following
 configuration items are relevant for
-.BR login (1):
+.BR login :
 .PP
 .B MOTD_FILE
 (string)
@@ -173,12 +175,17 @@ are supported since version 2.36.
 Note that
 .B login
 does not implement any filenames overriding behavior like pam_motd
-(see also MOTD_FIRSTONLY), but all content from all files is displayed.  It is
-recommended to keep extra logic in content generators and use /run/motd.d rather
+(see also
+.BR MOTD_FIRSTONLY ),
+but all content from all files is displayed.  It is
+recommended to keep extra logic in content generators and use
+.I /run/motd.d
+rather
 than rely on overriding behavior hardcoded in system tools.
 .RE
 .PP
-.B MOTD_FIRSTONLY (boolean)
+.B MOTD_FIRSTONLY
+(boolean)
 .RS 4
 Forces
 .B login
@@ -193,7 +200,9 @@ semantic to be more compatible with pam_motd.
 .B LOGIN_PLAIN_PROMPT
 (boolean)
 .RS 4
-Tell login that printing the hostname should be suppressed in the login:
+Tell
+.B login
+that printing the hostname should be suppressed in the login:
 prompt.  This is alternative to the \fB\-H\fR command line option.  The default
 value is
 .IR no .
@@ -286,12 +295,18 @@ to change directory to her home.  The default value is
 .B LASTLOG_UID_MAX
 (unsigned number)
 .RS 4
-Highest user ID number for which the lastlog entries should be
+Highest user ID number for which the
+.I lastlog
+entries should be
 updated.  As higher user IDs are usually tracked by remote user
 identity and authentication services there is no need to create
-a huge sparse lastlog file for them.  No LASTLOG_UID_MAX option
+a huge sparse
+.I lastlog
+file for them.  No LASTLOG_UID_MAX option
 present in the configuration means that there is no user ID limit
-for writing lastlog entries.
+for writing
+.I lastlog
+entries.
 .RE
 .PP
 .B LOG_UNKFAIL_ENAB
@@ -308,7 +323,9 @@ user enters her password instead of her login name.
 .B ENV_PATH
 (string)
 .RS 4
-If set, it will be used to define the PATH environment variable when
+If set, it will be used to define the
+.B PATH
+environment variable when
 a regular user logs in.  The default value is
 .I /usr\:/local\:/bin:\:/bin:\:/usr\:/bin
 .RE
@@ -347,12 +364,17 @@ programs.
 A recursive login, as used to be possible in the good old days, no
 longer works; for most purposes
 .BR su (1)
-is a satisfactory substitute.  Indeed, for security reasons, login
-does a vhangup() system call to remove any possible listening
+is a satisfactory substitute.  Indeed, for security reasons,
+.B login
+does a
+.BR vhangup (2)
+system call to remove any possible listening
 processes on the tty.  This is to avoid password sniffing.  If one
 uses the command
 .BR login ,
-then the surrounding shell gets killed by vhangup() because it's no
+then the surrounding shell gets killed by
+.BR vhangup (2)
+because it's no
 longer the true owner of the tty.  This can be avoided by using
 .B exec login
 in a top-level shell or xterm.
-- 
2.26.2


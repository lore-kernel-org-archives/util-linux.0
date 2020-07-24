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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF03C433EA
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 10:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BD2A206E3
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 10:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsl34RGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgGXKGv (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXKGu (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 24 Jul 2020 06:06:50 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A894C0619D3
        for <util-linux@vger.kernel.org>; Fri, 24 Jul 2020 03:06:50 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id v18so1061985ejb.0
        for <util-linux@vger.kernel.org>; Fri, 24 Jul 2020 03:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nyl36cZgKXqlSeaxNzq053XNkJd+3I+QViesE4wU3mc=;
        b=bsl34RGMXfJhCftK/riDHRWT7RVIXCO/fCCv2A4c/sAzRXlcszFlEIC7DsEj7dipJJ
         HJ9owE9kdoI+abQkpNpva/mksq8+oC/z7jKCYYiu06TVHRTjzKFS60q6FWbAaaWyQ2mX
         mFtxE1q99kxTvRQN4VIk7mIL250l3Ax5d7KDeoahksFkNBPNuwKZrDf7S7Y9QsJH+1mi
         rKfEK8PXJ781P3BUeNzOlusCTZSWNnZfyWSdNXOKtCJIm6JbDJoPjbhBWmqQwWudOrGl
         v2yoOj6XqdZJcKfo2HZr142vOA+qq53+qVo69swh4PxsDCo7Brju85ffese97h5IFDUy
         RJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nyl36cZgKXqlSeaxNzq053XNkJd+3I+QViesE4wU3mc=;
        b=V7kx4uGbBckpP4AlPf5gaLQoJtWsj8j/P2hpCISt1IQqjOH13y5duQ/DIvi6UxGDl2
         h8F4EpnOEncjZY6n7ueSd2lDrqKi9642NJcHGcJJwjRyKN5oxJk29iEghHdnQB4gVWeT
         7KPtPCTR8QVpQxQUQDgNWkR5OoWppvHT4nUkoegEIlMLcuuALw4COlvcAPUhv9H3ndu3
         A4KUB+9FlrR2xAubgmAlq6pl8IQFfnxHbFye3IEKMnVAmfDMtco775AdZenZCm/tBcBi
         BGIEuG+G76aKqrlbKLD0WVhvL2pRY4H18yETLMSmZOS9gW0+dVUrKUvER1siUOF2LRA5
         bYSA==
X-Gm-Message-State: AOAM5319F25MJ7HK1gwQ3NtQ7L/9s1URmQ1TWgLgGM05qrAGGfUZssxx
        JJphNk4pl50mgznX9FZj4M8=
X-Google-Smtp-Source: ABdhPJyQuuM1ZU79uWcSjxrcLSrVVdbpTvqJi0WiTk2KNKwoBQGONMBANPuybPudL25vMGNdjeDeSw==
X-Received: by 2002:a17:907:42a0:: with SMTP id ny24mr1276006ejb.328.1595585209298;
        Fri, 24 Jul 2020 03:06:49 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id p20sm351444ejy.107.2020.07.24.03.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 03:06:48 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 06/12] Manual pages: lslogins.1: Minor wording and formatting fixres
Date:   Fri, 24 Jul 2020 12:06:12 +0200
Message-Id: <20200724100618.584918-6-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200724100618.584918-1-mtk.manpages@gmail.com>
References: <20200724100618.584918-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 login-utils/lslogins.1 | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/login-utils/lslogins.1 b/login-utils/lslogins.1
index 6824001d4..0c9ea6dce 100644
--- a/login-utils/lslogins.1
+++ b/login-utils/lslogins.1
@@ -11,7 +11,10 @@ lslogins \- display information about known users in the system
 .RB [ \-l " \fIlogins\fR]"
 .RI [ username ]
 .SH DESCRIPTION
-Examine the wtmp and btmp logs, /etc/shadow (if necessary) and /etc/passwd
+Examine the wtmp and btmp logs,
+.I /etc/shadow
+(if necessary) and
+.I /passwd
 and output the desired data.
 
 The optional argument \fIusername\fR forces
@@ -46,12 +49,14 @@ Show information about supplementary groups.
 .TP
 \fB\-g\fR, \fB\-\-groups\fR=\fIgroups\fR
 Only show data of users belonging to \fIgroups\fR.  More than one group
-may be specified; the list has to be comma-separated.  The unknown group
+may be specified; the list has to be comma-separated.  Unknown group
 names are ignored.
 
 Note that relation between user and group may be invisible for primary group if
 the user is not explicitly specify as group member (e.g., in /etc/group). If the
-command lslogins scans for groups than it uses groups database only, and user
+command
+.B lslogins
+scans for groups than it uses groups database only, and user
 database with primary GID is not used at all.
 .TP
 \fB\-h\fR, \fB\-\-help\fR
@@ -63,7 +68,7 @@ Display data containing information about the users' last login sessions.
 \fB\-l\fR, \fB\-\-logins\fR=\fIlogins\fR
 Only show data of users with a login specified in \fIlogins\fR (user names or user
 IDS).  More than one login may be specified; the list has to be comma-separated.
-The unknown login names are ignored.
+Unknown login names are ignored.
 .TP
 \fB\-n\fR, \fB\-\-newline\fR
 Display each piece of information on a separate line.
@@ -94,7 +99,8 @@ Raw output (no columnation).
 Show system accounts.  These are by default all accounts with a UID between 101 and 999
 (inclusive), with the exception of either nobody or nfsnobody (UID 65534).
 This hardcoded default may be overwritten by parameters SYS_UID_MIN and SYS_UID_MAX in
-the file /etc/login.defs.
+the file
+.IR /etc/login.defs .
 .TP
 \fB\-\-time\-format\fR \fItype\fP
 Display dates in short, full or iso format.  The default is short, this time
@@ -104,7 +110,8 @@ format is designed to be space efficient and human readable.
 Show user accounts.  These are by default all accounts with UID above 1000
 (inclusive), with the exception of either nobody or nfsnobody (UID 65534).
 This hardcoded default maybe overwritten by parameters UID_MIN and UID_MAX in
-the file /etc/login.defs.
+the file
+.IR /etc/login.defs .
 .TP
 \fB\-V\fR, \fB\-\-version\fR
 Display version information and exit.
@@ -132,7 +139,8 @@ if incorrect arguments specified,
 2
 if a serious error occurs (e.g., a corrupt log).
 .SH NOTES
-The default UID thresholds are read from /etc/login.defs.
+The default UID thresholds are read from
+.IR /etc/login.defs .
 
 .SH HISTORY
 The \fBlslogins\fP utility is inspired by the \fBlogins\fP utility, which first appeared in FreeBSD 4.10.
-- 
2.26.2


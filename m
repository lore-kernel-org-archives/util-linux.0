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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA30C433E3
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 10:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05278206E3
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 10:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoolxQQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgGXKHO (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXKHO (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 24 Jul 2020 06:07:14 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288A5C0619D3
        for <util-linux@vger.kernel.org>; Fri, 24 Jul 2020 03:07:14 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id bm28so6657233edb.2
        for <util-linux@vger.kernel.org>; Fri, 24 Jul 2020 03:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9i/tfti3ZQQDgT9+MsYGRQ+rnqYc5TJK/+W10JOWx74=;
        b=QoolxQQjrPTW2iMio5or8DuJSj/mlFPFdlVNyQbq0dghzrRUTNdAKHdOUb+BlnMX14
         kAN1hy80fH6VbtsOhPgsc3+uWzyTyb5PkWbQoFUj+IJcWvz060ETUOMzQ9cbUZH7mQTo
         DD/yYlf/P29Oapd55i1bBG8VbL+77H2ZXe2CeQZr+B0Syhoi4SIStsiV3waWVp5hTn46
         oFzrRfJYreV+MGtGYDYMTXCFjliEs5MIsANQb5BCKFkVpITkgQZr7wsGdtQH9/u5g0kK
         Ka77guU3PNKonjcLutGfCFtIMBA208edrpYkzLgd+O4sucWEd85qk1TKC1atdTOGDQqJ
         kFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9i/tfti3ZQQDgT9+MsYGRQ+rnqYc5TJK/+W10JOWx74=;
        b=Rg1D1lyBJ1i2PQEBXtTMJgsPqwoGSjJcUfP5PaBQTJEw9D65lKsAXVGiEBk4Y4bCuB
         nYTBvORsPmGbZRXcHOJE4MeAhFpQrJV0X3x5hnqOkzjxZ/etjK3SqaRDLLZopxd7nxrH
         Kg+5zqHx+mrrAr5V4c60pATL1qA4SIKSge2IrMazuXUCumB6mMwB2/QfezpBW6BmpRkW
         ftQ9Ii6y8cXk7oszftTmo17Mw61WUXfOCsCIXJbWtpdjgoQc45/VoNa2JAtcPVKw1ajP
         qOHBITh7idvF7FR7AEfQgPN4bC41mqJJrKoY++DXYq24DLBVrIJj0GCkTQfkn69nIyLd
         ss0Q==
X-Gm-Message-State: AOAM5324hsypsquzXf9Y5d228FRcKQe6Sd8jr7koJwUqaX3w0nilVUb0
        HpctqDCtolTdwQk9QBwCzA8=
X-Google-Smtp-Source: ABdhPJzQlEqDSU6A0mwfwi51GnycZ1hk2cx6q01dMxlATsUkUiILbNKymE0R34qVvsHN7XpjOz3MDA==
X-Received: by 2002:a05:6402:354:: with SMTP id r20mr8662648edw.32.1595585232856;
        Fri, 24 Jul 2020 03:07:12 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id ce19sm363905ejb.24.2020.07.24.03.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 03:07:12 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 11/12] Manual pages: agetty.8: Minor formatting and wording fixes
Date:   Fri, 24 Jul 2020 12:06:17 +0200
Message-Id: <20200724100618.584918-11-mtk.manpages@gmail.com>
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
 term-utils/agetty.8 | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/term-utils/agetty.8 b/term-utils/agetty.8
index 902914197..6c748a365 100644
--- a/term-utils/agetty.8
+++ b/term-utils/agetty.8
@@ -74,7 +74,9 @@ The default for \fBserial terminals\fP is keep the current baud rate
 .TP
 .I term
 The value to be used for the TERM environment variable.  This overrides
-whatever init(8) may have set, and is inherited by login and the shell.
+whatever
+.BR init (1)
+may have set, and is inherited by login and the shell.
 .sp
 The default is 'vt100', or 'linux' for Linux on a virtual terminal,
 or 'hurd' for GNU Hurd on a virtual terminal.
@@ -93,8 +95,12 @@ Using this option causes an \fB\-f \fIusername\fR option and argument to be
 added to the \fB/bin/login\fP command line.  See \fB\-\-login\-options\fR, which
 can be used to modify this option's behavior.
 
-Note that \fB\-\-autologin\fP may affect the way how agetty initializes the
-serial line, because on auto-login agetty does not read from the line and it
+Note that \fB\-\-autologin\fP may affect the way in which 
+.B getty
+initializes the
+serial line, because on auto-login
+.B agetty
+does not read from the line and it
 has no opportunity optimize the line setting.
 .TP
 \-c, \-\-noreset
@@ -353,16 +359,20 @@ not be interpreted as options.  Use this feature if available by passing "\-\-"
 before the username gets passed by \\u.
 
 .SH ISSUE FILES
-The default issue file is \fI/etc/issue\fP. If the file exists then agetty also
+The default issue file is \fI/etc/issue\fP. If the file exists, then
+.B agetty
+also
 checks for \fI/etc/issue.d\fP directory. The directory is optional extension to
 the default issue file and content of the directory is printed after
-\fI/etc/issue\fP content. If the \fI/etc/issue\fP does not exist than the
+\fI/etc/issue\fP content. If the \fI/etc/issue\fP does not exist, then the
 directory is ignored. All files \fBwith .issue extension\fP from the directory are
 printed in version-sort order. The directory can be used to maintain 3rd-party
 messages independently on the primary system \fI/etc/issue\fP file.
 
 Since version 2.35 additional locations for issue file and directory are
-supported. If the default \fI/etc/issue\fP does not exist than agetty checks
+supported. If the default \fI/etc/issue\fP does not exist, then
+.B agetty
+checks
 for \fI/run/issue\fP and \fI/run/issue.d\fP, thereafter for
 \fI/usr/lib/issue\fP and \fI/usr/lib/issue.d\fP.  The directory /etc is
 expected for host specific configuration, /run is expected for generated stuff
@@ -372,7 +382,7 @@ The default path maybe overridden by \fB\-\-issue\-file\fP option. In this case
 specified path has to be file or directory and all the default issue file and
 directory locations are ignored.
 
-The issue file feature is possible to completely disable by \fB\-\-noissue\fP option.
+The issue file feature can be completely disabled by \fB\-\-noissue\fP option.
 
 It is possible to review the current issue file by \fBagetty \-\-show\-issue\fP
 on the current terminal.
-- 
2.26.2


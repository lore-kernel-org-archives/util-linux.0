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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CA1C433F8
	for <util-linux@archiver.kernel.org>; Tue, 14 Jul 2020 09:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2EAB221FD
	for <util-linux@archiver.kernel.org>; Tue, 14 Jul 2020 09:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTEjV4uU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgGNJ6D (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgGNJ6C (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Jul 2020 05:58:02 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47322C061755
        for <util-linux@vger.kernel.org>; Tue, 14 Jul 2020 02:58:02 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dr13so20883319ejc.3
        for <util-linux@vger.kernel.org>; Tue, 14 Jul 2020 02:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyc2uYARP+7ME8wqB1yvYEPBSr5/ojilSP12ZI465Tg=;
        b=jTEjV4uUbsLDac5BaXcrEXziu7Llcv6nEo4qp7BsSmwfQyLjpk+W4bqfVk3kXi5t5J
         WOUHqdI2iiSgpE1LiR+hc6P9+Vb1DyiPlTJ6samVPY5RkRAXw7QL18nwnuLB6ZOp6Or7
         xEuVQzCrPAivkAklb6OeLMIgNqqbZCtq8R2gEMtrQTnsp0xI2nXRBVgcK1Usl8OLokfO
         jrKAYHTp5Wfu/3Pwh52z7ktIBhxkuUN1WdqJdSIw9BJW4buxBZDGu1TEmiFn0EutAxif
         h2MPoul81mTQXCrgMyms8DkAGsYBEHgRUCHVTWKqicTeH1oljtc+WhPN/OhW1I0yZoRV
         wPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyc2uYARP+7ME8wqB1yvYEPBSr5/ojilSP12ZI465Tg=;
        b=THRpp3UBOrJD5f1w1q7pYMyA8Ua/s7OzDfjTcvPE/CZtn+Yl53EweCZs4Xt3/fWA7d
         dSSQYGIDrC3F1NW3VcrcG88wjDCFsvtXT3J6i+sIiJa9acV5lndgOFM3y1EFc+sDTIE+
         I2xjH1DpzRucDr/tVyp65dftqo8gD8WQbTuZMJslyeimgSu8VjfjhxzjB29RGcYB0jVu
         hZiRhAavKjLBsUka5W/CpJl/lYGvVlCSRTPFrfJTpvKp1ectGfN/wfZXXIYi3c2TSoaT
         cucrwMZjknr/lYwYu+4oZQxLifmgBWC8jzaQqcq/YaYfvzh+4salabRwkBJ5pDfi4wwS
         ZSaA==
X-Gm-Message-State: AOAM532aVnL8Q4PJhNvVaGadYLWqm026PfqxtTX5YbuWjVzdJ0d9bXrN
        d7l4gi0qE4QdhC58XGo4dTk=
X-Google-Smtp-Source: ABdhPJz9Lbjin04iYbXyCcug1lVZfzBT/4M7x+eZ6/VVv5txpcUsUFWRYeZyA+sw5VK1CYZsp/Z2BA==
X-Received: by 2002:a17:906:3a04:: with SMTP id z4mr3603420eje.441.1594720681034;
        Tue, 14 Jul 2020 02:58:01 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id c9sm14119803edv.8.2020.07.14.02.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 02:58:00 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 4/5] Manual pages: login.1: various minor wording fixes
Date:   Tue, 14 Jul 2020 11:57:40 +0200
Message-Id: <20200714095741.45292-4-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200714095741.45292-1-mtk.manpages@gmail.com>
References: <20200714095741.45292-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 login-utils/login.1 | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/login-utils/login.1 b/login-utils/login.1
index f3938b571..73c59462a 100644
--- a/login-utils/login.1
+++ b/login-utils/login.1
@@ -97,7 +97,7 @@ not to destroy the environment.
 .TP
 .B \-f
 Used to skip a login authentication.  This option is usually
-used by
+used by the
 .BR getty (8)
 autologin feature.
 .TP
@@ -111,14 +111,14 @@ use this option.
 .IP
 Note that the
 .B \-h
-option has impact on the
+option has an impact on the
 .B PAM service
 .BR name .
 The standard service name is
 .IR login ,
-with the
+but with the
 .B \-h
-option the name is
+option, the name is
 .IR remote .
 It is necessary to create proper PAM config files (e.g.,
 .I /etc\:/pam.d\:/login
@@ -164,7 +164,7 @@ If the
 .B MOTD_FILE
 item is empty or a quiet login is enabled, then the message of the day
 is not displayed.  Note that the same functionality is also provided
-by
+by the
 .BR pam_motd (8)
 PAM module.
 .PP
@@ -191,7 +191,8 @@ Forces
 .B login
 to stop display content specified by
 .B MOTD_FILE
-after first accessible item in the list.  Note that a directory is one item in this case.
+after the first accessible item in the list.
+Note that a directory is one item in this case.
 This option allows to configure
 .B login
 semantic to be more compatible with pam_motd.
@@ -203,7 +204,8 @@ semantic to be more compatible with pam_motd.
 Tell
 .B login
 that printing the hostname should be suppressed in the login:
-prompt.  This is alternative to the \fB\-H\fR command line option.  The default
+prompt.
+This is an alternative to the \fB\-H\fR command line option.  The default
 value is
 .IR no .
 .RE
@@ -211,7 +213,7 @@ value is
 .B LOGIN_TIMEOUT
 (number)
 .RS 4
-Max time in seconds for login.  The default value is
+Maximum time in seconds for login.  The default value is
 .IR 60 .
 .RE
 .PP
-- 
2.26.2


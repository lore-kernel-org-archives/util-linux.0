Return-Path: <SRS0=us4l=7K=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2214C433E0
	for <util-linux@archiver.kernel.org>; Thu, 28 May 2020 14:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBDA82075F
	for <util-linux@archiver.kernel.org>; Thu, 28 May 2020 14:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJSNoN/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403853AbgE1O6l (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 28 May 2020 10:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403950AbgE1O6c (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 28 May 2020 10:58:32 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387F3C08C5C6
        for <util-linux@vger.kernel.org>; Thu, 28 May 2020 07:58:32 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t18so14186409wru.6
        for <util-linux@vger.kernel.org>; Thu, 28 May 2020 07:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MobVfSa430Z3t9YpfI3UxgNx2gQmLtTEy7eZai8Re2s=;
        b=gJSNoN/y/V8DvGJHr7BQuXmDBN81hp6IzZ7MR5SmrDcQq3gIF2Pj/oMVwzNSLnJAp/
         OJeW1jmeSzHAn5vtbPAXM0cNI//jeDokmqM7/WqqSISV6iM/BXGS8GhNINiLcB2/GfK2
         ZPBB7I8+rKPsnJfD6Ol1Y4I3JDfmlyuhoJkgnrl7XezRba71kqGxwHXkvdVg7BLqVndQ
         6QeAv2XQGRIDhb9wy6uvbWM+lsNz6fgSPFUy/hwujgDT/zFDbk0+pBqiHePFXhMQvXUU
         +c3LiaLAZJB7Y/7GITnQ7LmjTzJLfjw8Frf8Q5xjAUdtmopg07fHoHoeC8OD2E2fEmd5
         rxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MobVfSa430Z3t9YpfI3UxgNx2gQmLtTEy7eZai8Re2s=;
        b=WOyVmCtRWdQbSp4xlUeQ6rmyPRKJHzHsTcQtpz7nM/9w0p7L47lvFBlZqJpnFxQElx
         XM8x8LyEbMH9jl/080IpJl7bo6+TDpFHqJb3udRVaMR8l/qiTmUVFL3PYrcJYd+Y1hqD
         /ujsIiEe+laVPWhDlE1PpsCzj/+5ifexG6To34vWh7fnc8L9s+DTiNESeDazofX4d8Fi
         Ok/wJjh/2y1HIUcFkYhGJ7Uo8Ry9q5wjL0rI2ijjPnNc7XGRgGhWVaGBnW/eVqudAjoT
         WkJdqg67uYDn8dzjzCZidhIZhGzXt3pGip5wyMh/d9h8tJ8TmDlnmGK7vzRor7iwDSvn
         5GhA==
X-Gm-Message-State: AOAM533cT7lH566gM81B4XBz1WVPxaaOhBD387utjVlk5NK4LK7ISYHA
        KfeyZsfAVzsbEnGYPTGiFl0=
X-Google-Smtp-Source: ABdhPJx3Vfj4uzH1JrKVXAPgundVXOnrT3rrrmb6M32EWHDDpqntTBchhwsOJkGCVkTOo630E72uyA==
X-Received: by 2002:a05:6000:11ca:: with SMTP id i10mr4037485wrx.10.1590677910891;
        Thu, 28 May 2020 07:58:30 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:2516:6501:a84b:ccd6:785a:2f0f])
        by smtp.gmail.com with ESMTPSA id v7sm6482630wre.93.2020.05.28.07.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:58:30 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 03/10] Manual pages: setpriv.1: Minor formatting and typo fixes
Date:   Thu, 28 May 2020 16:58:17 +0200
Message-Id: <20200528145823.978508-3-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528145823.978508-1-mtk.manpages@gmail.com>
References: <20200528145823.978508-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

These seem all "obviously correct", so I'm rolling them up
into one patch.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 sys-utils/setpriv.1 | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/sys-utils/setpriv.1 b/sys-utils/setpriv.1
index d1bd5efda..dbf5772ed 100644
--- a/sys-utils/setpriv.1
+++ b/sys-utils/setpriv.1
@@ -14,7 +14,7 @@ In comparison to
 .BR su (1)
 and
 .BR runuser (1),
-.BR setpriv (1)
+.BR setpriv
 neither uses PAM, nor does it prompt for a password.
 It is a simple, non-set-user-ID wrapper around
 .BR execve (2),
@@ -32,7 +32,8 @@ or similar tools shipped by other service managers.
 Clear supplementary groups.
 .TP
 .BR \-d , " \-\-dump"
-Dump current privilege state.  Can be specified more than once to show extra,
+Dump the current privilege state.
+Can be specified more than once to show extra,
 mostly useless, information.  Incompatible with all other options.
 .TP
 .B \-\-groups \fIgroup\fR...
@@ -49,7 +50,7 @@ entries, which add or remove an entry respectively. \fIcap\fR can either be a
 human-readable name as seen in
 .BR capabilities (7)
 without the \fIcap_\fR prefix or of the format
-.BI cap_N ,
+.BR cap_N ,
 where \fIN\fR is the internal capability index used by Linux.
 .B +all
 and
@@ -97,11 +98,13 @@ and
 .I Documentation/\:prctl/\:no_\:new_\:privs.txt
 in the Linux kernel source.
 .sp
-The no_new_privs bit is supported since Linux 3.5.
+The
+.I no_new_privs
+bit is supported since Linux 3.5.
 .TP
 .BI \-\-rgid " gid\fR, " \-\-egid " gid\fR, " \-\-regid " gid"
 Set the real, effective, or both GIDs.  The \fIgid\fR argument can be
-given as textual group name.
+given as a textual group name.
 .sp
 For safety, you must specify one of
 .BR \-\-clear\-groups ,
@@ -113,7 +116,7 @@ if you set any primary
 .TP
 .BI \-\-ruid " uid\fR, " \-\-euid " uid\fR, " \-\-reuid " uid"
 Set the real, effective, or both UIDs.  The \fIuid\fR argument can be
-given as textual login name.
+given as a textual login name.
 .sp
 Setting a
 .I uid
@@ -148,7 +151,7 @@ credentials to remedy that situation.
 .BI \-\-selinux\-label " label"
 Request a particular SELinux transition (using a transition on exec, not
 dyntrans).  This will fail and cause
-.BR setpriv (1)
+.BR setpriv
 to abort if SELinux is not in use, and the transition may be ignored or cause
 .BR execve (2)
 to fail at SELinux's whim.  (In particular, this is unlikely to work in
@@ -160,7 +163,7 @@ This is similar to
 .BI \-\-apparmor\-profile " profile"
 Request a particular AppArmor profile (using a transition on exec).  This will
 fail and cause
-.BR setpriv (1)
+.BR setpriv
 to abort if AppArmor is not in use, and the transition may be ignored or cause
 .BR execve (2)
 to fail at AppArmor's whim.
@@ -187,7 +190,9 @@ will not be run and
 will return with exit status 127.
 .PP
 Be careful with this tool \-\- it may have unexpected security consequences.
-For example, setting no_new_privs and then execing a program that is
+For example, setting
+.I no_new_privs
+and then execing a program that is
 SELinux\-confined (as this tool would do) may prevent the SELinux
 restrictions from taking effect.
 .SH EXAMPLES
-- 
2.26.2


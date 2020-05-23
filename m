Return-Path: <SRS0=zF+j=7F=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C78C433E0
	for <util-linux@archiver.kernel.org>; Sat, 23 May 2020 06:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F85C206DD
	for <util-linux@archiver.kernel.org>; Sat, 23 May 2020 06:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCgTKMV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387610AbgEWGnf (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 23 May 2020 02:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387605AbgEWGnf (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 23 May 2020 02:43:35 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C78C061A0E
        for <util-linux@vger.kernel.org>; Fri, 22 May 2020 23:43:35 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id x20so15399484ejb.11
        for <util-linux@vger.kernel.org>; Fri, 22 May 2020 23:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4XKRhE6yvKjEf6R2TAkhrxkOO4PbyC1HO2XqQugol+4=;
        b=XCgTKMV7Q7Xa8Fd2uX3ZaZQGbf1JfMvMOzkZzm4ZbAY+k5LZN7mry0qHWdU1cBgVbu
         8gQO13xsYRbc9iSprMlYn3Z2yHUrPepP67e9b/j5dkePdLjqLN1VCs4AqLG4Mo/JXQh+
         T7BcPe3idx6gIW2tw0I9GkGZQtjnI2P/U5unRNscawjZWwkTXzuyQ1ooNkHNiUffk18r
         c0ButX5IjyFiUXTf+0oOp64XAx5VdPThJK3AHRUpA3flWha8pJIHjUujgP7FFNa75SXz
         p/YYW3d4NxImLQKHCZIEItYH+TnjLPr4L4Kita6+GWOTLFmnHGCe1AoWYHvir+7P+amT
         1pTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4XKRhE6yvKjEf6R2TAkhrxkOO4PbyC1HO2XqQugol+4=;
        b=N6MJkIXO0z4dfXQIOGtgrszrt9AqXnat7EnWZt2qwz/rFSriHj03Zv1tnhEp9zGuN5
         0hyBtjChIzjgeMkVhQxOXFxCNhC3hQObthnuWKsdI9jWCb345oJeDZtHC9EmpG9YmpYz
         6t/MzMBiiZ2+zERDAqGHeBk8MsXmeKFT5UdSQZo1XhJ/uDO5Goi+R9NxFSBR53e7O7Ys
         99p/3ArLa+Nf267XEJCFr1wXphhv1aWBC9yLkpRMQ53RQku2ITbl1PgJEumvnKUhGIIk
         8D6DHqLZla3dlIFeH5mXU2YHWbFcWbuGqm35GWwiuus8Fp0G1Nqt2dWfoBJ7EL9e/C2Y
         JV2w==
X-Gm-Message-State: AOAM532at2fPqd+dgu/M9vVI8K+u7rQvKsQp59HcCdcZ2lEn4THE3tJ3
        IgydPQH0PCO2t0HPwIky93A=
X-Google-Smtp-Source: ABdhPJy92i2JoWEedsVUu/Kqld5Y9N9mRDLPSn6b0XzJMQU8XxnkINWpkSuU04+H54z8faCHtHTVWw==
X-Received: by 2002:a17:906:f891:: with SMTP id lg17mr10682964ejb.443.1590216213788;
        Fri, 22 May 2020 23:43:33 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id q22sm3240523edg.97.2020.05.22.23.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 23:43:33 -0700 (PDT)
From:   Michael Kerrisk <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 4/9] Manual pages: unshare.1: improve intro paragraphs
Date:   Sat, 23 May 2020 08:43:20 +0200
Message-Id: <20200523064325.78491-4-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523064325.78491-1-mtk.manpages@gmail.com>
References: <20200523064325.78491-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The intro paragraphs of this page are rather hard for a newcomer to
grok. The name of the underlying system call (and consequently the
name of the command) are "strange", but let's help the reader by
naming more clearly what unshare(1) does: creating new namespaces. In
addition, clarify and expand the details on making a namespace
persistent using bind mounts.

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 sys-utils/unshare.1 | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index fb769d607..14b107d37 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -1,30 +1,41 @@
 .TH UNSHARE 1 "February 2016" "util-linux" "User Commands"
 .SH NAME
-unshare \- run program with some namespaces unshared from parent
+unshare \- run program in new namespaces
 .SH SYNOPSIS
 .B unshare
 [options]
 .RI [ program
 .RI [ arguments ]]
 .SH DESCRIPTION
-Unshares the indicated namespaces from the parent process and then executes
-the specified \fIprogram\fR. If \fIprogram\fR is not given, then ``${SHELL}'' is
+The
+.B unshare
+command creates new namespaces
+(as specified by the command-line options described below)
+and then executes the specified \fIprogram\fR.
+If \fIprogram\fR is not given, then ``${SHELL}'' is
 run (default: /bin/sh).
 .PP
-The namespaces can optionally be made persistent by bind mounting
-/proc/\fIpid\fR/ns/\fItype\fR files to a filesystem path and entered with
+By default, a new namespace persists only as long as it has member processes.
+A new namespace can be made persistent even when it has no member processes
+by bind mounting
+/proc/\fIpid\fR/ns/\fItype\fR files to a filesystem path.
+A namespace that has been made persistent in this was can subsequently
+be entered with
 .BR \%nsenter (1)
 even after the \fIprogram\fR terminates (except PID namespaces where
-permanently running init process is required).
-Once a persistent \%namespace is no longer needed, it can be unpersisted with
-.BR umount (8).
+a permanently running init process is required).
+Once a persistent \%namespace is no longer needed,
+it can be unpersisted by using
+.BR umount (8)
+to remove the bind mount.
 See the \fBEXAMPLE\fR section for more details.
 .PP
 .B unshare
 since util-linux version 2.36 uses /\fIproc/[pid]/ns/pid_for_children\fP and \fI/proc/[pid]/ns/time_for_children\fP
 files for persistent PID and TIME namespaces. This change requires Linux kernel 4.17 or newer.
 .PP
-The namespaces to be unshared are indicated via options.  Unshareable namespaces are:
+The following types of namespaces can be created with
+.BR unshare :
 .TP
 .B mount namespace
 Mounting and unmounting filesystems will not affect the rest of the system,
-- 
2.26.2


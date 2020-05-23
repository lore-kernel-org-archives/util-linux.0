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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A948C433DF
	for <util-linux@archiver.kernel.org>; Sat, 23 May 2020 06:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11456206DD
	for <util-linux@archiver.kernel.org>; Sat, 23 May 2020 06:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYoFCum8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387615AbgEWGng (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 23 May 2020 02:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387605AbgEWGng (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 23 May 2020 02:43:36 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2D0C05BD43
        for <util-linux@vger.kernel.org>; Fri, 22 May 2020 23:43:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l21so15449258eji.4
        for <util-linux@vger.kernel.org>; Fri, 22 May 2020 23:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X7XJ2VapPiWGAuIXDxTDNjq6ZjKbzLSW/dFbin5wJYo=;
        b=KYoFCum8PoKNvjH4muESwS7Z7SESI/Cuavgb5EtzJYQKbJ/zR1VL6iDZqo8YJM1DDN
         oAgSt2ibsLhitQ/sJg02l766p7XWHosGB7wegNjlucHRqItUcc4lkWGWZ7CMlk/F9xjZ
         fSgYoYMSxPt1+TqUf+8R6sSbe7FUXT/9fHdQl8EBdVvHx2lG1A3VZO6GmHZSbjB6Zxja
         vBb/SkXqyh0MNPTjN+oK2xZ8vIEDOcYtu+9lpS9l/vcEr3aY+W8yATWZ0UpQ7lcYp0Gj
         iqZjumpS9ItCWRfhWBkIcmNlmKmnZgBvGVmHQdvEIh1E1AeyprODglsnhlCHU0MJqPSH
         +zWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X7XJ2VapPiWGAuIXDxTDNjq6ZjKbzLSW/dFbin5wJYo=;
        b=cV8lyz3UXFgS454CFim0GLN5KVc3dxD0XpKRVIfruq+0mqQQBGBoiCxt4goElpW72c
         iQgEao0v5qlifqKT2KcTNvi3UQYl4KARLGYHjC/VNlnL4WKm7EJOSSzP0llOVVp/3akK
         iUp9mFreoKh64uVKAuWxdPyLa2j14b2z+iTobvkJzuUF8eTH3HzyN4uRxPQ8qD5/n2Be
         reTqQT3WfyaUlw4tMEjYHOKVmjRxL7B36qgRimflGQwlRTyEqshn49gkgEjvCCtpVK7z
         TiCCYufTIhW0xgd+8nIDybC+DtS0nFhaJWtTgkVFimhaet+CqIbvuEEE+IIt5s/Apo82
         g+Jg==
X-Gm-Message-State: AOAM5305uJG3qIgiUTcUcMUHETVLTVtLMk5b7D0FJWLE16b7tePOsYRk
        QtTjYtZsP9D1xWMczFW/xuA=
X-Google-Smtp-Source: ABdhPJzPLF/AJCs+0nKurHVE1I2XW8aYL5fvnj0mLplM2TrTnb4N7P4ljjOag5q4cMH1P3+xG1rZSw==
X-Received: by 2002:a17:906:90d4:: with SMTP id v20mr11649316ejw.485.1590216209380;
        Fri, 22 May 2020 23:43:29 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id q22sm3240523edg.97.2020.05.22.23.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 23:43:28 -0700 (PDT)
From:   Michael Kerrisk <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 3/9] Manual pages: nsenter.1, unshare.1: remove repeated references to clone(2)
Date:   Sat, 23 May 2020 08:43:19 +0200
Message-Id: <20200523064325.78491-3-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523064325.78491-1-mtk.manpages@gmail.com>
References: <20200523064325.78491-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Back in commits f85b9777c2965671cd and 894efece9eb894, in the
description of each namespace type, I added repeated cross references
to clone(2). Drop these references. The Section 7 namespaces pages,
which are already noted in the nsenter(1) and unshare(1) manual pages,
provide much more relevant information. Furthermore, pointing the
reader at clone(2) is perhaps a little misleading, since the system
call underlying nsenter(1) is setns(2) and the system call underlying
unshare(1) is unshare(2).

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 sys-utils/nsenter.1 | 39 ++++++---------------------------------
 sys-utils/unshare.1 | 45 ++++++++-------------------------------------
 2 files changed, 14 insertions(+), 70 deletions(-)

diff --git a/sys-utils/nsenter.1 b/sys-utils/nsenter.1
index 299107609..ea924f909 100644
--- a/sys-utils/nsenter.1
+++ b/sys-utils/nsenter.1
@@ -27,22 +27,14 @@ flag in
 .B UTS namespace
 Setting hostname or domainname will not affect the rest of the system.
 For further details, see
-.BR uts_namespaces (7)
-and the discussion of the
-.B CLONE_NEWUTS
-flag in
-.BR clone (2).
+.BR uts_namespaces (7).
 .TP
 .B IPC namespace
 The process will have an independent namespace for POSIX message queues
 as well as System V message queues,
 semaphore sets and shared memory segments.
 For further details, see
-.BR ipc_namespaces (7)
-and the discussion of the
-.B CLONE_NEWIPC
-flag in
-.BR clone (2).
+.BR ipc_namespaces (7).
 .TP
 .B network namespace
 The process will have independent IPv4 and IPv6 stacks, IP routing tables,
@@ -52,11 +44,7 @@ and
 .I /sys\:/class\:/net
 directory trees, sockets, etc.
 For further details, see
-.BR network_namespaces (7)
-and the discussion of the
-.B CLONE_NEWNET
-flag in
-.BR clone (2).
+.BR network_namespaces (7).
 .TP
 .B PID namespace
 Children will have a set of PID to process mappings separate from the
@@ -67,31 +55,18 @@ will fork by default if changing the PID namespace, so that the new program
 and its children share the same PID namespace and are visible to each other.
 If \fB\-\-no\-fork\fP is used, the new program will be exec'ed without forking.
 For further details, see
-.BR pid_namespaces (7)
-and
-the discussion of the
-.B CLONE_NEWPID
-flag in
-.BR clone (2).
+.BR pid_namespaces (7).
 .TP
 .B user namespace
 The process will have a distinct set of UIDs, GIDs and capabilities.
 For further details, see
-.BR user_namespaces (7)
-and the discussion of the
-.B CLONE_NEWUSER
-flag in
-.BR clone (2).
+.BR user_namespaces (7).
 .TP
 .B cgroup namespace
 The process will have a virtualized view of \fI/proc\:/self\:/cgroup\fP, and new
 cgroup mounts will be rooted at the namespace cgroup root.
 For further details, see
-.BR cgroup_namespaces (7)
-and the discussion of the
-.B CLONE_NEWCGROUP
-flag in
-.BR clone (2).
+.BR cgroup_namespaces (7).
 .TP
 .B time namespace
 The process can have a distinct view of
@@ -101,8 +76,6 @@ and/or
 which can be changed using \fI/proc/self/timens_offsets\fP.
 For further details, see
 .BR time_namespaces (7).
-.TP
-See \fBclone\fP(2) for the exact semantics of the flags.
 .SH OPTIONS
 Various of the options below that relate to namespaces take an optional
 .I file
diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index db67b0d4c..fb769d607 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -32,12 +32,8 @@ except for filesystems which are explicitly marked as
 shared (with \fBmount \-\-make-shared\fP; see \fI/proc/self/mountinfo\fP or
 \fBfindmnt \-o+PROPAGATION\fP for the \fBshared\fP flags).
 For further details, see
-.BR mount_namespaces (7)
-and the discussion of the
-.B CLONE_NEWNS
-flag in
-.BR clone (2).
-.sp
+.BR mount_namespaces (7).
+.IP
 .B unshare
 since util-linux version 2.27 automatically sets propagation to \fBprivate\fP
 in a new mount namespace to make sure that the new namespace is really
@@ -48,62 +44,37 @@ Note that \fBprivate\fP is the kernel default.
 .B UTS namespace
 Setting hostname or domainname will not affect the rest of the system.
 For further details, see
-.BR uts_namespaces (7)
-and the discussion of the
-.B CLONE_NEWUTS
-flag in
-.BR clone (2).
+.BR uts_namespaces (7).
 .TP
 .B IPC namespace
 The process will have an independent namespace for POSIX message queues
 as well as System V \%message queues,
 semaphore sets and shared memory segments.
 For further details, see
-.BR ipc_namespaces (7)
-and the discussion of the
-.B CLONE_NEWIPC
-flag in
-.BR clone (2).
+.BR ipc_namespaces (7).
 .TP
 .B network namespace
 The process will have independent IPv4 and IPv6 stacks, IP routing tables,
 firewall rules, the \fI/proc/net\fP and \fI/sys/class/net\fP directory trees,
 sockets, etc.
 For further details, see
-.BR network_namespaces (7)
-and the discussion of the
-.B CLONE_NEWNET
-flag in
-.BR clone (2).
+.BR network_namespaces (7).
 .TP
 .B PID namespace
 Children will have a distinct set of PID-to-process mappings from their parent.
 For further details, see
-.BR pid_namespaces (7)
-and
-the discussion of the
-.B CLONE_NEWPID
-flag in
-.BR clone (2).
+.BR pid_namespaces (7).
 .TP
 .B cgroup namespace
 The process will have a virtualized view of \fI/proc\:/self\:/cgroup\fP, and new
 cgroup mounts will be rooted at the namespace cgroup root.
 For further details, see
-.BR cgroup_namespaces (7)
-and the discussion of the
-.B CLONE_NEWCGROUP
-flag in
-.BR clone (2).
+.BR cgroup_namespaces (7).
 .TP
 .B user namespace
 The process will have a distinct set of UIDs, GIDs and capabilities.
 For further details, see
-.BR user_namespaces (7)
-and the discussion of the
-.B CLONE_NEWUSER
-flag in
-.BR clone (2).
+.BR user_namespaces (7).
 .TP
 .B time namespace
 The process can have a distinct view of
-- 
2.26.2


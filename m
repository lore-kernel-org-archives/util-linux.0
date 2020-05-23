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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BFEC433DF
	for <util-linux@archiver.kernel.org>; Sat, 23 May 2020 06:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37BEB206DD
	for <util-linux@archiver.kernel.org>; Sat, 23 May 2020 06:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPJZjY6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387604AbgEWGnc (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 23 May 2020 02:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387457AbgEWGn3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 23 May 2020 02:43:29 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74590C061A0E
        for <util-linux@vger.kernel.org>; Fri, 22 May 2020 23:43:29 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id se13so15415480ejb.9
        for <util-linux@vger.kernel.org>; Fri, 22 May 2020 23:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j6dOnuMeioIZZl7GybPZdhPaCGd4MBMxXJyfYfoRxUM=;
        b=RPJZjY6JL8ghiVeSLD7lh8tAijMwEoMJkW3uAo+AxQcydtLoKV5o765ggQNCtO335d
         1J2An1GgvF2H+5xbVS60LpkoDdiWbbyGHnheFKqKA0q77IRQr/ZzfYE7WpdLUMKsNEUs
         aVJldAhKz1QhAsCUlfTHAmlz1By+uUhbmwphg9mXXVtq0yRPiDwc9l7VGYuN5BZ6cI7z
         r/Yed656rCe8kDy743FoPfLI+8OxyGC1Zsf7J+VCodTslwY6iiiQEsnN0VELuC3hDTzx
         dewhj8frlQsa7+/sANnL/QW7vNxmn4o4poYqqAo3ubjwGjTJw7TsNqwWCWtS7hlxk4nF
         W7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j6dOnuMeioIZZl7GybPZdhPaCGd4MBMxXJyfYfoRxUM=;
        b=jOslqQI5mTt+H8+LqINvrjQZrkTEpJHgB7MUCxTGOJshyP2M48pbUCYoaP4DXss6cW
         R7Fn4KrvAD10CgFp1OCy70IdWLsyTa7deGA6FLfvaLSvOeEV+ZN43TkR+/rdP91Tpf6Z
         lQqcr3AmgqgFeCOOK0JYN/gtMjI1P4YzgjADqnQO1Me6TTzhxgo9yZ7pUqZuOCMdUanr
         wYybwE/bziWP9z+1DdQdFQNbz85bTSmStz+sEAIWA1A+FQPfmPWcXcQl/cbZNNynZlDZ
         33PsOXZ4AaiKBC1a6ypFGIJaeCu0CGN1fKz3o5YGnjf3fhowGV1jsN93Go+byHPzCQbd
         71iA==
X-Gm-Message-State: AOAM531KneWZzqBvrbS5WBZIMEg1cjTXp2slBt7xZhf73+Jq29c5wRKt
        F0kSyHV2uOeG5E8LxfRFhgw=
X-Google-Smtp-Source: ABdhPJxeO/xUc2Eu6VhCnWhDCEE8U4UzPmz4PSaUuzwo0P0H4/L52kVh6zCW3NKA+tac/xL3HMhoTw==
X-Received: by 2002:a17:906:9719:: with SMTP id k25mr11523430ejx.411.1590216208071;
        Fri, 22 May 2020 23:43:28 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id q22sm3240523edg.97.2020.05.22.23.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 23:43:27 -0700 (PDT)
From:   Michael Kerrisk <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 1/9] Manual pages: nsenter.1, unshare.1: update references to *_namespaces(7) pages
Date:   Sat, 23 May 2020 08:43:17 +0200
Message-Id: <20200523064325.78491-1-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Nowadays, the Linux man-pages project provides separate Section 7
manual pages for each type of namespace. Update the cross references
in nsenter.1 and unshare.1 to reflect this.

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 sys-utils/nsenter.1 | 6 +++---
 sys-utils/unshare.1 | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sys-utils/nsenter.1 b/sys-utils/nsenter.1
index 424e22dc9..2f45df66d 100644
--- a/sys-utils/nsenter.1
+++ b/sys-utils/nsenter.1
@@ -27,7 +27,7 @@ flag in
 .B UTS namespace
 Setting hostname or domainname will not affect the rest of the system.
 For further details, see
-.BR namespaces (7)
+.BR uts_namespaces (7)
 and the discussion of the
 .B CLONE_NEWUTS
 flag in
@@ -38,7 +38,7 @@ The process will have an independent namespace for POSIX message queues
 as well as System V message queues,
 semaphore sets and shared memory segments.
 For further details, see
-.BR namespaces (7)
+.BR ipc_namespaces (7)
 and the discussion of the
 .B CLONE_NEWIPC
 flag in
@@ -52,7 +52,7 @@ and
 .I /sys\:/class\:/net
 directory trees, sockets, etc.
 For further details, see
-.BR namespaces (7)
+.BR network_namespaces (7)
 and the discussion of the
 .B CLONE_NEWNET
 flag in
diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 7b35bc0b6..2665ca0af 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -48,7 +48,7 @@ Note that \fBprivate\fP is the kernel default.
 .B UTS namespace
 Setting hostname or domainname will not affect the rest of the system.
 For further details, see
-.BR namespaces (7)
+.BR uts_namespaces (7)
 and the discussion of the
 .B CLONE_NEWUTS
 flag in
@@ -59,7 +59,7 @@ The process will have an independent namespace for POSIX message queues
 as well as System V \%message queues,
 semaphore sets and shared memory segments.
 For further details, see
-.BR namespaces (7)
+.BR ipc_namespaces (7)
 and the discussion of the
 .B CLONE_NEWIPC
 flag in
@@ -70,7 +70,7 @@ The process will have independent IPv4 and IPv6 stacks, IP routing tables,
 firewall rules, the \fI/proc/net\fP and \fI/sys/class/net\fP directory trees,
 sockets, etc.
 For further details, see
-.BR namespaces (7)
+.BR network_namespaces (7)
 and the discussion of the
 .B CLONE_NEWNET
 flag in
-- 
2.26.2


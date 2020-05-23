Return-Path: <SRS0=zF+j=7F=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524DDC433E0
	for <util-linux@archiver.kernel.org>; Sat, 23 May 2020 06:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AF04206DD
	for <util-linux@archiver.kernel.org>; Sat, 23 May 2020 06:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pdfl5f3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbgEWGni (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 23 May 2020 02:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387612AbgEWGnh (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 23 May 2020 02:43:37 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F1CC05BD43
        for <util-linux@vger.kernel.org>; Fri, 22 May 2020 23:43:37 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z5so15486449ejb.3
        for <util-linux@vger.kernel.org>; Fri, 22 May 2020 23:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5JxNhd65UOL0An7yx6bZT0ME+wJSTaSTfkPQt2oF1QA=;
        b=Pdfl5f3k/66SBFmtVVszMifbZuIDOr9i2A3V/ZC91rNoFEwyNf3+7prYahF2wrbb74
         l+tV8K/FXewu+LB5xf+9Iw2qttAE4TzwzKLoV6niPVniH7cg8Y/g9xk6YbNzmcz+9YXe
         4UKMun9ZMqsrWUr1M1r2pFywyx46RabqMNrv9OuWCMRH8aaDlJ90zxroiCJ6cabQRmk+
         qx/935xV3ukhg6XkEyv0m2dpzKxVa8STvEghF8iOUEf0bNX2zZHGuGjDTzuavv/9iNeU
         q3jIeLiiViN2hS5rIeWt+ulqMIlOSOm7PVAkNL6RKkmNyrSb/oMzskDOiRYGW1c9VpGr
         gRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5JxNhd65UOL0An7yx6bZT0ME+wJSTaSTfkPQt2oF1QA=;
        b=PZQj2zEkOR33ZwfY3PJHbDndrLXmZse476CDb29dS5ZqNhDfp4VAZNyKIzkc7zyLMA
         IMLYFVjyC+JOh07DsB2TjptDKq7oNE6MXSZhDutnGJgkKvjr/CU8kmnLODWhZ3Az+ZWI
         xRuMKLkpClb5W/n8FZi3A4eoexr3cgE8kws/bc4jYIV8WcqV9y/2tbzQIj2rquqQgZkN
         pIIjEjQE4MrK00G9BZ53/RMckJJytaPYkUvMdXt/dq5DTP56DLcmqkm0F7mRmpb8tlYN
         CnrOCflZobdfiRzc8gXR1h3EduLzPIRekBJEiE7vvO8yXY04xjaRkupV6s2xHefOTe5D
         0hqg==
X-Gm-Message-State: AOAM531jhWbl/r0YTbH3jgXmozT+im2xMxO6YcoXM4myb3njs9aCIPOF
        5WqV0AEeWpYS2Rw3cOgMwIl2aJ1bvvs=
X-Google-Smtp-Source: ABdhPJw0cQHfGvl49ZVxa2Ceh2iEfacPGxtuJ/YiVKfxlQSrH7pgf1gDt9KTbJGcmxfS0dgJt8Kp4w==
X-Received: by 2002:a17:907:1189:: with SMTP id uz9mr10807025ejb.53.1590216216207;
        Fri, 22 May 2020 23:43:36 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id q22sm3240523edg.97.2020.05.22.23.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 23:43:35 -0700 (PDT)
From:   Michael Kerrisk <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 7/9] Manual pages: unshare.1: fix examples, part 1
Date:   Sat, 23 May 2020 08:43:23 +0200
Message-Id: <20200523064325.78491-7-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523064325.78491-1-mtk.manpages@gmail.com>
References: <20200523064325.78491-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The examples section of this manual page is rather hard to grok.
First, the arrangement of the text as follows makes life harder
than needed for the reader:

    shell demo
        explanatory text

It helps the reader if an example *begins* with an explanation of
what is being demonstrated. Therefore, rearrange these examples as:

    explanatory text
        shell demo

In addition, let's provide a bit more explanation for the first three
examples and expand the second example (user namespaces) a little.

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 sys-utils/unshare.1 | 109 +++++++++++++++++++++++++++++---------------
 1 file changed, 72 insertions(+), 37 deletions(-)

diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 14b107d37..b8ef371a0 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -244,61 +244,96 @@ restricted so that a less privileged user can not get more access to sensitive
 files that a more privileged user made unavailable. In short the rule for proc
 and sysfs is as close to a bind mount as possible.
 .SH EXAMPLE
-.TP
+.PP
+The following command creates a PID namespace, using
+.B \-\-fork
+to ensure that the executed command is performed in a child process
+that (being the first process in the namespace) has PID 1.
+The
+.B \-\-mount-proc
+option ensures that a new mount namespace is also simultaneously created
+and that a new
+.BR proc (5)
+filesystem is mounted that contains information corresponding to the new
+PID namespace.
+When the
+.BR readlink
+command terminates, the new namespaces are automatically torn down.
+.PP
+.in +4n
+.EX
 .B # unshare \-\-fork \-\-pid \-\-mount-proc readlink /proc/self
-.TQ
 1
-.br
-Establish a PID namespace, ensure we're PID 1 in it against a newly mounted
-procfs instance.
-.TP
-.B $ unshare \-\-map-root-user \-\-user sh \-c whoami
-.TQ
+.EE
+.in
+.PP
+As an unprivileged user, create a new user namespace where the user's
+credentials are mapped to the root IDs inside the namespace:
+.PP
+.in +4n
+.EX
+.B $ id \-u; id \-g
+1000
+1000
+.B $ unshare \-\-user \-\-map-root-user \e
+.B "        sh \-c \(aqwhoami; cat /proc/self/uid_map /proc/self/gid_map\(aq"
 root
-.br
-Establish a user namespace as an unprivileged user with a root user within it.
-.TP
+         0       1000          1
+         0       1000          1
+.EE
+.in
+.PP
+The first of the following commands creates a new persistent UTS namespace
+and modifies the hostname as seen in that namespace.
+The namespace is then entered with
+.BR nsenter (1)
+in order to display the modified hostname;
+this step demonstrates that the UTS namespace continues to exist
+even though the namespace had no member processes after the
+.B unshare
+command terminated.
+The namespace is then destroyed by removing the bind mount.
+.PP
+.in +4n
+.EX
 .B # touch /root/uts-ns
-.TQ
 .B # unshare \-\-uts=/root/uts-ns hostname FOO
-.TQ
 .B # nsenter \-\-uts=/root/uts-ns hostname
-.TQ
 FOO
-.TQ
 .B # umount /root/uts-ns
-.br
-Establish a persistent UTS namespace, and modify the hostname.  The namespace
-is then entered with \fBnsenter\fR.  The namespace is destroyed by unmounting
-the bind reference.
-.TP
+.EE
+.in
+.PP
+Establish a persistent mount namespace referenced by the bind mount
+/root/namespaces/mnt.  This example shows a portable solution, because it
+makes sure that the bind mount is created on a shared filesystem.
+.PP
+.in +4n
+.EX
 .B # mount \-\-bind /root/namespaces /root/namespaces
-.TQ
 .B # mount \-\-make-private /root/namespaces
-.TQ
 .B # touch /root/namespaces/mnt
-.TQ
 .B # unshare \-\-mount=/root/namespaces/mnt
-.br
-Establish a persistent mount namespace referenced by the bind mount
-/root/namespaces/mnt.  This example shows a portable solution, because it
-makes sure that the bind mount is created on a shared filesystem.
-.TP
-.B # unshare \-pf \-\-kill-child \-\- bash \-c "(sleep 999 &) && sleep 1000" &
-.TQ
-.B # pid=$!
-.TQ
-.B # kill $pid
-.br
+.EE
+.in
+.PP
 Reliable killing of subprocesses of the \fIprogram\fR.
 When \fBunshare\fR gets killed, everything below it gets killed as well.
 Without it, the children of \fIprogram\fR would have orphaned and
 been re-parented to PID 1.
-.TP
+.PP
+.in +4n
+.EX
+.B # unshare \-pf \-\-kill-child \-\- bash \-c "(sleep 999 &) && sleep 1000" &
+.B # pid=$!
+.B # kill $pid
+.EE
+.in
+.PP
+.in +4n
+.EX
 .B # unshare \-\-fork \-\-time \-\-boottime 100000000 uptime
-.TQ
  10:58:48 up 1158 days,  6:05,  1 user,  load average: 0.00, 0.00, 0.00
-
 .SH AUTHORS
 .UR dottedmag@dottedmag.net
 Mikhail Gusarov
-- 
2.26.2


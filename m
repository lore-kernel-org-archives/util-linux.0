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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0422DC433E1
	for <util-linux@archiver.kernel.org>; Sat, 23 May 2020 06:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D823F206DD
	for <util-linux@archiver.kernel.org>; Sat, 23 May 2020 06:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGkUiFVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbgEWGnj (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 23 May 2020 02:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387612AbgEWGni (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 23 May 2020 02:43:38 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCFEC05BD43
        for <util-linux@vger.kernel.org>; Fri, 22 May 2020 23:43:38 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a2so15408095ejb.10
        for <util-linux@vger.kernel.org>; Fri, 22 May 2020 23:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FmzDd1k+msdb7L4URpp5egFGYQcwUtHWbHfTo+IyiQg=;
        b=kGkUiFVnRLDY4NvhFMpEG8FllFfjnAqHYN+o9hfKtT/Hcn+oVCPXP6gH2EAzh3E1u2
         E2kq8liXjjdJNjfyVYnu0H1HEjeOAD33qq/rGfQkL3xxfP/47JJvsLIbtEEHDuI0XgP8
         Qz9DJa65LNcZ6Ad2YeHFWRGe0EHIYFqLSFhFqfA9qW/ko8VE8YBdUBNlaiP4+vNj2hXw
         abuUn8kt+6xq/LRxq55F3v7EXqmdH11aQsgI/IWeG8xCGJ/uwem9NPkSZONfPvvcrpX/
         EoYJ6wW7pHfsXqZPUDqPQtwWWXuxs9si0hePVlNPE3Yx6TedurHhvO+FeVa+EHHoD8Q/
         krLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FmzDd1k+msdb7L4URpp5egFGYQcwUtHWbHfTo+IyiQg=;
        b=ZTGOCK4oo9t0jzAW5pyb8NscK8ppJO7h1pEhSCxekZ6e3Zr8RtJSXaDW0rcJCyz6r9
         DDKWoFIjucw9TDEQBkLklXNHCkBkDnihkfBGrInFfjlOYGUjAkacvjqjtss2TNRaAz8J
         p4c7Pcz/H97abbmZRJffWbmaD2iWUNYDnv1hX0sy6gTlO0HvmeN2F4lOvT4ATi1H9OcU
         Jwl65iIMLlcrOwGCzqxudghDzVFh24UssNsSfMiwZkF3fg+3AT9DV/PdQR67exlwf6XJ
         6StjCbdYG61NzgHee/NmRyk1UEdE3GF6WIi46XRFRA8ZP5jJZOby0ISsEQKGLi4D/p3D
         pdoA==
X-Gm-Message-State: AOAM533W5d0VyI0gCEum2f1hSTXoakq+F0iJZn5SaiqVI1llVb/Y2cUE
        PRqPyLenkCU/d8MrhuxJ9Qw=
X-Google-Smtp-Source: ABdhPJzUJirBykvPHFc1Qv2oEVKMFFn4PelPet7C0r/j5outkqJ7eJASBK55WnKA11U6KN+1Pa3FTg==
X-Received: by 2002:a17:906:407:: with SMTP id d7mr10903944eja.46.1590216217029;
        Fri, 22 May 2020 23:43:37 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id q22sm3240523edg.97.2020.05.22.23.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 23:43:36 -0700 (PDT)
From:   Michael Kerrisk <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 8/9] Manual pages: unshare.1: fix examples, part 2
Date:   Sat, 23 May 2020 08:43:24 +0200
Message-Id: <20200523064325.78491-8-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523064325.78491-1-mtk.manpages@gmail.com>
References: <20200523064325.78491-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The explanation of the --kill-child example was quite confused and
also the example shell demo was broken because of quoting issues.

It is not the case that the *children* of 'program' would adopted by
init, but rather that 'program' itself (which would be running as PID
1 inside the namespace and is a child of 'unshare') would be adopted
by init.

Rework the --kill-child example. Add a lot more explanation, and
expand the example shell session to give the reader a much better
picture of what is going on.

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 sys-utils/unshare.1 | 56 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index b8ef371a0..38f7a62cf 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -317,16 +317,58 @@ makes sure that the bind mount is created on a shared filesystem.
 .EE
 .in
 .PP
-Reliable killing of subprocesses of the \fIprogram\fR.
-When \fBunshare\fR gets killed, everything below it gets killed as well.
-Without it, the children of \fIprogram\fR would have orphaned and
-been re-parented to PID 1.
+The following commands demonstrate the use of the
+.B \-\-kill-child
+option when creating a PID namespace, in order to ensure that when
+.B unshare
+is killed, all of the processes within the PID namespace are killed.
+.PP
+.in +4n
+.EX
+.BR "# set +m                " "# Don't print job status messages"
+.B # unshare \-\-pid \-\-fork \-\-mount\-proc \-\-kill\-child \-\- \e
+.B "       bash \-\-norc \-c \(aq(sleep 555 &) && (ps a &) && sleep 999\(aq &"
+[1] 53456
+#     PID TTY      STAT   TIME COMMAND
+      1 pts/3    S+     0:00 sleep 999
+      3 pts/3    S+     0:00 sleep 555
+      5 pts/3    R+     0:00 ps a
+
+.BR "# ps h \-o 'comm' $!     " "# Show that background job is unshare(1)"
+unshare
+.BR "# kill $!               " "# Kill unshare(1)
+.B # pidof sleep
+.EE
+.in
+.PP
+The
+.B pidof
+command prints no output, because the
+.B sleep
+processes have been killed.
+More precisely, when the
+.B sleep
+process that has PID 1 in the namespace (i.e., the namespace's init process)
+was killed, this caused all other processes in the namespace to be killed.
+By contrast, a similar series of commands where the
+.B \-\-kill\-child
+option is not used shows that when
+.B unshare
+terminates, the processes in the PID namespace are not killed:
 .PP
 .in +4n
 .EX
-.B # unshare \-pf \-\-kill-child \-\- bash \-c "(sleep 999 &) && sleep 1000" &
-.B # pid=$!
-.B # kill $pid
+.B # unshare \-\-pid \-\-fork \-\-mount\-proc \-\- \e
+.B "       bash \-\-norc \-c \(aq(sleep 555 &) && (ps a &) && sleep 999\(aq &"
+[1] 53479
+#     PID TTY      STAT   TIME COMMAND
+      1 pts/3    S+     0:00 sleep 999
+      3 pts/3    S+     0:00 sleep 555
+      5 pts/3    R+     0:00 ps a
+
+.B # kill $!
+.B # pidof sleep
+53482 53480
 .EE
 .in
 .PP
-- 
2.26.2


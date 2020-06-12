Return-Path: <SRS0=sYuO=7Z=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3925AC433DF
	for <util-linux@archiver.kernel.org>; Fri, 12 Jun 2020 11:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1862020801
	for <util-linux@archiver.kernel.org>; Fri, 12 Jun 2020 11:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/9V1Fux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgFLLTj (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 12 Jun 2020 07:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgFLLTi (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 12 Jun 2020 07:19:38 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8628DC03E96F
        for <util-linux@vger.kernel.org>; Fri, 12 Jun 2020 04:19:38 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h5so9358602wrc.7
        for <util-linux@vger.kernel.org>; Fri, 12 Jun 2020 04:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kI6M1Ejhb8rTJaWbxpRe/2mRj4eTS3Y9J5AyxEIaQQ8=;
        b=S/9V1FuxC+HQghrL02mLp+p5l40EQh9psS5ijmqUarGVxF176688Xi7Mn1ff5ZwJDA
         qt92D1Cg2z9q7ELAwSqyhfG7vkLa5h/OSAUJazgpEsB8IAFJG8MRsmhO6pgUO08cS1HZ
         cdYLCzEEtnpHcjeSGiqvYw9Y3o8uzGn5VH6+sw88TeNlv3cwjQnylR1LCAq+oC++y0+Z
         EwzLsWxdKVeCaQa58+1TYC8WL466eZv0OJbl8yQN4Q2D/Z7tVkaibGLfNSSokButyD97
         dEg3fiunXCkRQ8nUfIgTcE0pLkhRkEdmqy1sFSzS9fPq35i6exOcS9rjH2SiZ1DzUo/d
         +J5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kI6M1Ejhb8rTJaWbxpRe/2mRj4eTS3Y9J5AyxEIaQQ8=;
        b=DQCnp0IJsFb3Ny2SEqAH/YwYgsDigMWGZYMDTye7tY9XkuozDdSVPyF9hlMC1N8UZS
         KdNFKQfRQXJibrH0YmYkyHjvelFxIAuULxSNZcXnJ6L3AWdEhG1D86epB7MDF6Kf6Sjv
         ZojfFuWJwyKmAn7ZEjkRNdnSiuqgFo1CLdKefj4MqLvQ35Wsf1pV9OAhBBQeGjWYWCIe
         ZIzbERWy3Aogkkqjyl13bThkAJWfxIX+L+4vB2mje3uuM8W/tBxSwcEGgs6s8nsDi4/8
         uuy4hvO/uctGZZg+G7wqScvutktJgKltbmeuF3jwvtEO28L87wG/w9QefuXGGg6UcGRn
         64vg==
X-Gm-Message-State: AOAM530fo28UXSmerBCOrlsw5V+BL1UdUaueM/Q1+7tHC72aBCASkbTS
        QgZ/DWj+LuqExV1XsDF6pIc=
X-Google-Smtp-Source: ABdhPJyCtAElRIKQChryL1FkgTt6p0rknuUmOuuOi9eOn3H3IPvuuZQxbcjXLq/7i7KYzwfSZwuXQg==
X-Received: by 2002:a5d:4a0d:: with SMTP id m13mr15254159wrq.12.1591960776850;
        Fri, 12 Jun 2020 04:19:36 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:253c:8201:b2fb:3ef8:ca:1604])
        by smtp.gmail.com with ESMTPSA id o6sm9511433wrp.3.2020.06.12.04.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 04:19:36 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 1/3] Manual pages: runuser.1: Various wording and formatting fixes
Date:   Fri, 12 Jun 2020 13:19:31 +0200
Message-Id: <20200612111933.3043314-1-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Most of this is pretty straightforward English language fix-ups
and formatting fix-ups, so I've rolled it into one patch.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 login-utils/runuser.1 | 70 +++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/login-utils/runuser.1 b/login-utils/runuser.1
index 7bcbbde12..8d38dd7de 100644
--- a/login-utils/runuser.1
+++ b/login-utils/runuser.1
@@ -10,7 +10,7 @@ runuser \- run a command with substitute user and group ID
 .RI [ user " [" argument "...]]"
 .SH DESCRIPTION
 .B runuser
-allows to run commands with a substitute user and group ID.
+can be used to to run commands with a substitute user and group ID.
 If the option \fB\-u\fR is not given, it falls back to
 .BR su -compatible
 semantics and a shell is executed.
@@ -26,7 +26,8 @@ The command
 .B runuser
 does not have to be installed with set-user-ID permissions.
 .PP
-If the PAM session is not required then recommended solution is to use
+If the PAM session is not required,
+then the recommended solution is to use the
 .BR setpriv (1)
 command.
 .PP
@@ -37,7 +38,7 @@ defaults to running an interactive shell as
 .PP
 For backward compatibility,
 .B runuser
-defaults to not change the current directory and to only set the
+defaults to not changing the current directory and to setting only the
 environment variables
 .B HOME
 and
@@ -55,8 +56,10 @@ uses PAM for session management.
 .PP
 Note that
 .B runuser
-in all cases use PAM (pam_getenvlist()) to do final environment modification.  The command line options
-like \fB\-\-login\fR or \fB\-\-preserve\-environment\fR affect environment before it's modified by PAM.
+in all cases use PAM (pam_getenvlist()) to do final environment modification.
+Command-line options
+such as \fB\-\-login\fR or \fB\-\-preserve\-environment\fR affect
+the environment before it is modified by PAM.
 .SH OPTIONS
 .TP
 .BR \-c , " \-\-command" = \fIcommand
@@ -76,48 +79,48 @@ shell.
 The primary group to be used.  This option is allowed for the root user only.
 .TP
 .BR \-G , " \-\-supp\-group" = \fIgroup
-Specify a supplemental group.  This option is available to the root user only.  The first specified
-supplementary group is also used as a primary group if the option \fB\-\-group\fR is unspecified.
+Specify a supplementary group.
+This option is available to the root user only.  The first specified
+supplementary group is also used as a primary group
+if the option \fB\-\-group\fR is not specified.
 .TP
 .BR \- , " \-l" , " \-\-login"
 Start the shell as a login shell with an environment similar to a real
 login:
-.RS 10
-.TP
-o
+.RS
+.IP * 2
 clears all the environment variables except for
 .B TERM
 and variables specified by \fB\-\-whitelist\-environment\fR
-.TP
-o
+.IP *
 initializes the environment variables
 .BR HOME ,
 .BR SHELL ,
 .BR USER ,
 .BR LOGNAME ,
 .B PATH
-.TP
-o
+.IP *
 changes to the target user's home directory
-.TP
-o
+.IP *
 sets argv[0] of the shell to
 .RB ' \- '
 in order to make the shell a login shell
 .RE
 .TP
 .BR \-P , " \-\-pty"
-Create pseudo-terminal for the session. The independent terminal provides
-better security as user does not share terminal with the original
-session.  This allow to avoid TIOCSTI ioctl terminal injection and other
-security attacks against terminal file descriptors. The all session is also
-possible to move to background (e.g., "runuser \-\-pty \-u username \-\- command &").
+Create a pseudo-terminal for the session. The independent terminal provides
+better security as user does not share a terminal with the original
+session.
+This permits the avoidance of TIOCSTI ioctl terminal injection and other
+security attacks against terminal file descriptors. The entire session can also
+be moved to background (e.g., "runuser \-\-pty \-u username \-\- command &").
 If the pseudo-terminal is enabled then runuser command works
 as a proxy between the sessions (copy stdin and stdout).
 .sp
 This feature is mostly designed for interactive sessions. If the standard input
-is not a terminal, but for example pipe (e.g., echo "date" | runuser \-\-pty \-u user)
-than ECHO flag for the pseudo-terminal is disabled to avoid messy output.
+is not a terminal,
+but for example a pipe (e.g., echo "date" | runuser \-\-pty \-u user),
+then the ECHO flag for the pseudo-terminal is disabled to avoid messy output.
 .TP
 .BR \-m , " \-p" , " \-\-preserve\-environment"
 Preserve the entire environment, i.e., it does not set
@@ -131,28 +134,24 @@ The option is ignored if the option \fB\-\-login\fR is specified.
 .BR \-s , " \-\-shell" = \fIshell
 Run the specified \fIshell\fR instead of the default.  The shell to run is
 selected according to the following rules, in order:
-.RS 10
-.TP
-o
+.RS
+.IP * 2
 the shell specified with
 .B \-\-shell
-.TP
-o
+.IP *
 the shell specified in the environment variable
 .B SHELL
 if the
 .B \-\-preserve\-environment
 option is used
-.TP
-o
+.IP *
 the shell listed in the passwd entry of the target user
-.TP
-o
+.IP *
 /bin/sh
 .RE
 .IP
 If the target user has a restricted shell (i.e., not listed in
-/etc/shells) the
+/etc/shells), then the
 .B \-\-shell
 option and the
 .B SHELL
@@ -160,11 +159,12 @@ environment variables are ignored unless the calling user is root.
 .TP
 .BI \-\-session\-command= command
 Same as
-.B \-c ,
+.BR \-c ,
 but do not create a new session.  (Discouraged.)
 .TP
 .BR \-w , " \-\-whitelist\-environment" = \fIlist
-Don't reset environment variables specified in comma separated \fIlist\fR when clears
+Don't reset the environment variables specified in the
+comma-separated \fIlist\fR when clearing the
 environment for \fB\-\-login\fR. The whitelist is ignored for the environment variables
 .BR HOME ,
 .BR SHELL ,
-- 
2.26.2


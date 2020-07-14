Return-Path: <SRS0=vFYQ=AZ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD12CC433DF
	for <util-linux@archiver.kernel.org>; Tue, 14 Jul 2020 12:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0BDA217A0
	for <util-linux@archiver.kernel.org>; Tue, 14 Jul 2020 12:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQPthjJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgGNMUI (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgGNMUH (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Jul 2020 08:20:07 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43162C061755
        for <util-linux@vger.kernel.org>; Tue, 14 Jul 2020 05:20:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id f12so21460732eja.9
        for <util-linux@vger.kernel.org>; Tue, 14 Jul 2020 05:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vevEHpHDu/4m2NzyNB4nv+OkOc7b7DlT1P4+wnxfvM4=;
        b=pQPthjJidv8SFrQK5/7RzwvJReYd/aXW/vKqmaUOJgmZwIDyJI3cZtrSWlgP/U8D2k
         CeCjcqX9JdsBs1qd7ZH2/rol0QXSoTXdwImW3zBUsLefP7pOixsFzDAXDb4LfAinb+RX
         KErXq7UD1L16l3FCD440mb98xvwO+vF89YzP359HeityyN90nwrDLXwwDNESigEgBhoa
         n4h9jrrTL2mIxA2xWveerh4JZ+TXbcuV1mJsVFgrFuTw75NWoEsavQSYz+SsdK2AvzsF
         r1a6cNIO9uMpBgCNyc9qggV9GQmkNvmB43BlFL0dVBEoRZxpW3C/Taa2EHoOdpYPoA4k
         eqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vevEHpHDu/4m2NzyNB4nv+OkOc7b7DlT1P4+wnxfvM4=;
        b=e1mAxXdhz/9Y6EDBuk502D5Jm4BAYYOuJpdCNCRfK9iqkkjd/PdrWyuxK9CVBibcAN
         l3V6oQBSnEbwvaNiLJxmu9gsftzBQcUgOyx/NK1wtSMzDotuGLdZChpmoHCJskweOVnN
         MIz0VG56A8d722oehn6FixmLDUvNo7sOot29AdUPwoFz5bqOtKInAynt6xXga/3I75fr
         gqLmEwh7ySEsBe7izGmkR1mOAN1ZyRXQErR9TnT98YjSYyLnBPKVyl/Lk/bhKi8hIIa/
         7Ls2FCbtLVqw0/Ovx8DDAJOv7LjtKC10GXh9NGizwWYIXTCziqpRAdPnC8X48RbnS6/P
         R0lA==
X-Gm-Message-State: AOAM532X1p+LDUM9iKD6DTu2MuIfp3vTq3hGb808nNFh1uLDdXJcU1+Y
        jW+xzBTg5LzgNe1gW9aieCs=
X-Google-Smtp-Source: ABdhPJw2aJKn8AM7l4Ap8weNSUL6/XxpoXb21OHhkN7WkMJUbWxDwNu7QfU1hRkLO6hGsK3i/hr88A==
X-Received: by 2002:a17:906:d9d9:: with SMTP id qk25mr4455795ejb.448.1594729205732;
        Tue, 14 Jul 2020 05:20:05 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id g21sm14376671edu.2.2020.07.14.05.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 05:20:05 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH] Manual pages: runuser.1, su.1: miscellaneous wording and formatting fixes
Date:   Tue, 14 Jul 2020 14:20:00 +0200
Message-Id: <20200714122000.51849-1-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Various wording and formatting fixes. Nothing too contentnious, I think,
so I rolled these changes into one patch.

Since there is much common text in su.1 and runuser.1, I've combined
the changes to both pages into one patch, and, as far as possible,
ensured that changes to the common pieces of text match across the
two pages.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 login-utils/runuser.1 | 56 +++++++++++++++++---------
 login-utils/su.1      | 93 ++++++++++++++++++++++++++++---------------
 2 files changed, 99 insertions(+), 50 deletions(-)

diff --git a/login-utils/runuser.1 b/login-utils/runuser.1
index 8d38dd7de..49095385b 100644
--- a/login-utils/runuser.1
+++ b/login-utils/runuser.1
@@ -11,7 +11,9 @@ runuser \- run a command with substitute user and group ID
 .SH DESCRIPTION
 .B runuser
 can be used to to run commands with a substitute user and group ID.
-If the option \fB\-u\fR is not given, it falls back to
+If the option \fB\-u\fR is not given,
+.B runuser
+falls back to
 .BR su -compatible
 semantics and a shell is executed.
 The difference between the commands
@@ -56,9 +58,10 @@ uses PAM for session management.
 .PP
 Note that
 .B runuser
-in all cases use PAM (pam_getenvlist()) to do final environment modification.
+in all cases use PAM (pam_getenvlist()) to do
+the final environment modification.
 Command-line options
-such as \fB\-\-login\fR or \fB\-\-preserve\-environment\fR affect
+such as \fB\-\-login\fR and \fB\-\-preserve\-environment\fR affect
 the environment before it is modified by PAM.
 .SH OPTIONS
 .TP
@@ -72,7 +75,7 @@ option.
 .BR \-f , " \-\-fast"
 Pass
 .B \-f
-to the shell, which may or may not be useful depending on the
+to the shell, which may or may not be useful, depending on the
 shell.
 .TP
 .BR \-g , " \-\-group" = \fIgroup
@@ -98,6 +101,7 @@ initializes the environment variables
 .BR SHELL ,
 .BR USER ,
 .BR LOGNAME ,
+and
 .B PATH
 .IP *
 changes to the target user's home directory
@@ -109,25 +113,27 @@ in order to make the shell a login shell
 .TP
 .BR \-P , " \-\-pty"
 Create a pseudo-terminal for the session. The independent terminal provides
-better security as user does not share a terminal with the original
+better security as the user does not share a terminal with the original
 session.
-This permits the avoidance of TIOCSTI ioctl terminal injection and other
-security attacks against terminal file descriptors. The entire session can also
-be moved to background (e.g., "runuser \-\-pty \-u username \-\- command &").
-If the pseudo-terminal is enabled then runuser command works
-as a proxy between the sessions (copy stdin and stdout).
-.sp
-This feature is mostly designed for interactive sessions. If the standard input
-is not a terminal,
+This can be used to avoid TIOCSTI ioctl terminal injection and other
+security attacks against terminal file descriptors.
+The entire session can also be moved to the background
+(e.g., "runuser \-\-pty \-u username \-\- command &").
+If the pseudo-terminal is enabled, then
+.B runuser
+works as a proxy between the sessions (copy stdin and stdout).
+.IP
+This feature is mostly designed for interactive sessions.
+If the standard input is not a terminal,
 but for example a pipe (e.g., echo "date" | runuser \-\-pty \-u user),
 then the ECHO flag for the pseudo-terminal is disabled to avoid messy output.
 .TP
 .BR \-m , " \-p" , " \-\-preserve\-environment"
-Preserve the entire environment, i.e., it does not set
+Preserve the entire environment, i.e., do not set
 .BR HOME ,
 .BR SHELL ,
 .B USER
-nor
+or
 .BR LOGNAME .
 The option is ignored if the option \fB\-\-login\fR is specified.
 .TP
@@ -201,7 +207,11 @@ default value is
 .B ENV_SUPATH
 (string)
 .RS 4
-Defines the PATH environment variable for root.  ENV_SUPATH takes precedence.  The default value is
+Defines the
+.B PATH
+environment variable for root.
+.B ENV_SUPATH
+takes precedence.  The default value is
 .IR /usr/local/sbin:\:/usr/local/bin:\:/sbin:\:/bin:\:/usr/sbin:\:/usr/bin .
 .RE
 .PP
@@ -216,9 +226,17 @@ initializes
 .BR PATH .
 .RE
 .sp
-The environment variable PATH may be different on systems where /bin and /sbin
-are merged into /usr, this variable is also affected by \fB\-\-login\fR command line option and
-PAM system setting (e.g. pam_env).
+The environment variable
+.B PATH
+may be different on systems where
+.I /bin
+and
+.I /sbin
+are merged into
+.IR  /usr ;
+this variable is also affected by the \fB\-\-login\fR command-line option and
+the PAM system setting (e.g.,
+.BR pam_env (8)).
 .SH EXIT STATUS
 .B runuser
 normally returns the exit status of the command it executed.  If the
diff --git a/login-utils/su.1 b/login-utils/su.1
index 80949dae1..df32fd097 100644
--- a/login-utils/su.1
+++ b/login-utils/su.1
@@ -59,8 +59,12 @@ command
 .PP
 Note that
 .B su
-in all cases use PAM (pam_getenvlist()) to do final environment modification.  The command line options
-like \fB\-\-login\fR or \fB\-\-preserve\-environment\fR affect environment before it's modified by PAM.
+in all cases use PAM
+.RB (pam_getenvlist (3))
+to do the final environment modification.
+Command-line options
+such as \fB\-\-login\fR and \fB\-\-preserve\-environment\fR affect
+the environment before it is modified by PAM.
 
 .SH OPTIONS
 .TP
@@ -80,8 +84,10 @@ to the shell, which may or may not be useful, depending on the shell.
 Specify the primary group.  This option is available to the root user only.
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
@@ -111,26 +117,30 @@ in order to make the shell a login shell
 .RE
 .TP
 .BR \-m , " \-p" , " \-\-preserve\-environment"
-Preserve the entire environment, i.e., it does not set
+Preserve the entire environment, i.e., do not set
 .BR HOME ,
 .BR SHELL ,
 .B USER
-nor
+or
 .BR LOGNAME .
 This option is ignored if the option \fB\-\-login\fR is specified.
 .TP
 .BR \-P , " \-\-pty"
-Create pseudo-terminal for the session. The independent terminal provides
-better security as user does not share terminal with the original
-session.  This can be used to avoid TIOCSTI ioctl terminal injection and other
-security attacks against terminal file descriptors. The all session is also
-possible to move to background (e.g., "su \-\-pty \- username \-c
-application &"). If the pseudo-terminal is enabled then su command works
-as a proxy between the sessions (copy stdin and stdout).
-.sp
-This feature is mostly designed for interactive sessions. If the standard input
-is not a terminal, but for example pipe (e.g., echo "date" | su --pty) than ECHO
-flag for the pseudo-terminal is disabled to avoid messy output.
+Create a pseudo-terminal for the session. The independent terminal provides
+better security as the user does not share a terminal with the original
+session.
+This can be used to avoid TIOCSTI ioctl terminal injection and other
+security attacks against terminal file descriptors.
+The entire session can also be moved to the background
+(e.g., "su \-\-pty \- username \-c application &").
+If the pseudo-terminal is enabled, then
+.B su
+works as a proxy between the sessions (copy stdin and stdout).
+.IP
+This feature is mostly designed for interactive sessions.
+If the standard input is not a terminal,
+but for example a pipe (e.g., echo "date" | su \-\-pty),
+then the ECHO flag for the pseudo-terminal is disabled to avoid messy output.
 .TP
 .BR \-s , " \-\-shell" = \fIshell
 Run the specified \fIshell\fR instead of the default.  The shell to run is
@@ -164,11 +174,12 @@ environment variables are ignored unless the calling user is root.
 .TP
 .BI \-\-session\-command= command
 Same as
-.B \-c
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
@@ -199,7 +210,7 @@ and
 .I /etc/login.defs
 configuration files.  The following configuration items are relevant
 for
-.BR su (1):
+.BR su:
 .PP
 .B FAIL_DELAY
 (number)
@@ -211,7 +222,9 @@ a non-negative integer.
 .B ENV_PATH
 (string)
 .RS 4
-Defines the PATH environment variable for a regular user.  The
+Defines the
+.B PATH
+environment variable for a regular user.  The
 default value is
 .IR /usr/local/bin:\:/bin:\:/usr/bin .
 .RE
@@ -222,7 +235,9 @@ default value is
 .B ENV_SUPATH
 (string)
 .RS 4
-Defines the PATH environment variable for root.  ENV_SUPATH takes precedence.  The default value is
+Defines the PATH environment variable for root.
+.B ENV_SUPATH
+takes precedence.  The default value is
 .IR /usr/local/sbin:\:/usr/local/bin:\:/sbin:\:/bin:\:/usr/sbin:\:/usr/bin .
 .RE
 .PP
@@ -237,9 +252,17 @@ initializes
 .BR PATH .
 .RE
 .sp
-The environment variable PATH may be different on systems where /bin and /sbin
-are merged into /usr, this variable is also affected by \fB\-\-login\fR command line option and
-PAM system setting (e.g. pam_env).
+The environment variable
+.B PATH
+may be different on systems where
+.I /bin
+and
+.I /sbin
+are merged into
+.IR  /usr ;
+this variable is also affected by the \fB\-\-login\fR command-line option and
+the PAM system setting (e.g.,
+.BR pam_env (8)).
 .SH EXIT STATUS
 .B su
 normally returns the exit status of the command it executed.  If the
@@ -277,14 +300,22 @@ command specific logindef config file
 global logindef config file
 .PD 1
 .SH NOTES
-For security reasons
+For security reasons,
 .B su
 always logs failed log-in attempts to the btmp file, but it does not write to
-the lastlog file at all.  This solution can be used to control
+the
+.I lastlog
+file at all.  This solution can be used to control
 .B su
-behavior by PAM configuration.  If you want to use the pam_lastlog module to
-print warning message about failed log-in attempts then the pam_lastlog has to
-be configured to update the lastlog file as well. For example by:
+behavior by PAM configuration.  If you want to use the
+.BR pam_lastlog (8)
+module to
+print warning message about failed log-in attempts then
+.BR pam_lastlog (8)
+has to
+be configured to update the
+.I lastlog
+file as well. For example by:
 
 .RS
 .br
@@ -293,7 +324,7 @@ session  required  pam_lastlog.so nowtmp
 .SH HISTORY
 This \fBsu\fR command was
 derived from coreutils' \fBsu\fR, which was based on an implementation by
-David MacKenzie. The util-linux has been refactored by Karel Zak.
+David MacKenzie. The util-linux version has been refactored by Karel Zak.
 .SH SEE ALSO
 .BR setpriv (1),
 .BR login.defs (5),
-- 
2.26.2


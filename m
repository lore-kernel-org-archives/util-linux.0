Return-Path: <SRS0=WWhG=A2=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA222C433E2
	for <util-linux@archiver.kernel.org>; Wed, 15 Jul 2020 08:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A36642067D
	for <util-linux@archiver.kernel.org>; Wed, 15 Jul 2020 08:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xm1p53Xz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbgGOIPz (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729643AbgGOIPy (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 15 Jul 2020 04:15:54 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF2EC061755
        for <util-linux@vger.kernel.org>; Wed, 15 Jul 2020 01:15:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o2so4674451wmh.2
        for <util-linux@vger.kernel.org>; Wed, 15 Jul 2020 01:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l4ybm8+PosGJmH98J38/iHRYyFLla1UXcu0ICNVg4kc=;
        b=Xm1p53Xz69NElZWTGgTdi2H88pMYC8GTDivFbY/2tpjR6k1mAvX9oZGyxOkEEtKXUb
         G1biZd3d17uSTAJKuysfsiYsucbsH8In9OLZG9EFQwBI5yFIDXSp6q5qPb+oox6b7HXC
         TjJiB/0pCcid3BfeVQcSjg4+sWBpRpX7nXz/jjVeBSuuFoAn3/WfW5xdvco8elT/GeOe
         Tb4n0w+2T7kGoxl16og7GEfcVnMk1P7WEzU2vG9TFRJNQ/94C55qs5UKfS/QTWXgCiLN
         VQArg0VCsCBY+X2lxEM2E+G3/Xknf1VxLBFsSelejn2iD7BLVk9jAT/rTNhVytKNbk2e
         YxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l4ybm8+PosGJmH98J38/iHRYyFLla1UXcu0ICNVg4kc=;
        b=PHgVVb1E5WTzd2AyqekJX/iGfit8UacMsjiotKiY4QjLy2innRGSbxhPz5Zs+cXqPG
         XDqRRa+R2qFDMNGJmDhr53AGQb0WLWfh5QZ15bKUg3XQtl62j+RkqedrqDM80sbtUsTj
         dqWkGVZYVqEI4Osvs49y8VvPB8iQT6sqqQdBPA3XnB0tGEBuUKr5ULWQeaoW7wtDv8Oq
         pv0r7IEBK8M132RNfsbe9ZkvutkBgnZykKiiTrnMwlA7kV7bRsl9MEU71E0hzwzlWw1K
         F2KPvdu044Lfax0HrcaY+oT3mUk/ifjGjCaxY2Rt2mP7R4TUE9OZwmjKwcxiTLvNFsnk
         WMsQ==
X-Gm-Message-State: AOAM5312aaVxc+zPuO8AcDh+IrdndUcXvGYl3Iy2QhI/zIUw/NwZ9mN4
        mWyA4WsPo9o/cQXSZBjIZkQ=
X-Google-Smtp-Source: ABdhPJybEnQ3hjnO9VbpPk0UJvtBOd2SNoWdyjopGePwYwubb5qbVn4THq5fCTQVm7vJNg9xGkKGVw==
X-Received: by 2002:a05:600c:258:: with SMTP id 24mr7697209wmj.126.1594800951886;
        Wed, 15 Jul 2020 01:15:51 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id z63sm2487511wmb.2.2020.07.15.01.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:15:51 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 1/3] Manual pages: script.1: Miscellaneous wording, grammar, and formatting fixes
Date:   Wed, 15 Jul 2020 10:15:44 +0200
Message-Id: <20200715081546.112933-1-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Nothing too contentious here, I think, so I'm rolling all
of the edits into one patch.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 term-utils/script.1 | 51 ++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/term-utils/script.1 b/term-utils/script.1
index 8eda4a58b..49ba58224 100644
--- a/term-utils/script.1
+++ b/term-utils/script.1
@@ -44,10 +44,10 @@ makes a typescript of everything on your terminal session.  The terminal
 data are stored in raw form to the log file and information about timing
 to another (optional) structured log file.  The timing log file is necessary to replay
 the session later by
-.B scriptreplay (1)
+.BR scriptreplay (1)
 and to store additional information about the session.
 .PP
-Since version 2.35
+Since version 2.35,
 .B script
 supports multiple streams and allows the logging of input and output to separate
 files or all the one file.  This version also supports new timing file
@@ -63,11 +63,13 @@ or option \fB\-\-log\-out\fR \fIfile\fR is given,
 saves the dialogue in this
 .IR file .
 If no filename is given, the dialogue is saved in the file
-.BR typescript .
+.IR typescript .
 .PP
-Note that log input by \fB\-\-log\-in\fR or \fB\-\-log\-io\fR may be security
-sensitive operation as the log file contains all terminal session input (it
-means also passwords) independently on the terminal echo flag setting.
+Note that logging input using \fB\-\-log\-in\fR or \fB\-\-log\-io\fR
+may record security-sensitive information
+as the log file contains all terminal session input
+(e.g., passwords)
+independently of the terminal echo flag setting.
 .SH OPTIONS
 Below, the \fIsize\fR argument may be followed by the multiplicative
 suffixes KiB (=1024), MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB
@@ -78,7 +80,7 @@ KB (=1000), MB (=1000*1000), and so on for GB, TB, PB, EB, ZB and YB.
 Append the output to
 .I file
 or to
-.BR typescript ,
+.IR typescript ,
 retaining the prior contents.
 .TP
 \fB\-c\fR, \fB\-\-command\fR \fIcommand\fR
@@ -89,8 +91,8 @@ the output of a program that behaves differently when its stdout is not a
 tty.
 .TP
 \fB\-E\fR, \fB\-\-echo\fR \fIwhen\fR
-This option controls the ECHO flag for pseudoterminal within the session.  The
-supported modes are
+This option controls the ECHO flag for the pseudoterminal within the session.
+The supported modes are
 .IR always ,
 .IR never ,
 or
@@ -98,25 +100,28 @@ or
 The default is
 .I auto
 -- in this case, ECHO is disabled if the current standard input is a
-terminal to avoid double-echo, and enabled if standard input is not terminal
+terminal iin order to avoid double-echo,
+and enabled if standard input is not a terminal
 (for example pipe:
 .BR "echo date | script" )
 to avoid missing input in the session log.
 .TP
 \fB\-e\fR, \fB\-\-return\fR
 Return the exit status of the child process.  Uses the same format as bash
-termination on signal termination exit status is 128+n.  The exit status of
-the child process is always stored in type script file too.
+termination on signal termination
+(i.e., exit status is 128 + the signal number).  The exit status of
+the child process is always stored in the type script file too.
 .TP
 \fB\-f\fR, \fB\-\-flush\fR
 Flush output after each write.  This is nice for telecooperation: one person
-does `mkfifo foo; script \-f foo', and another can supervise real-time what is
-being done using `cat foo'.  Note that flush has an impact on performance, it's
+does `mkfifo foo; script \-f foo',
+and another can supervise in real-time what is
+being done using `cat foo'.  Note that flush has an impact on performance; it's
 possible to use SIGUSR1 to flush logs on demand.
 .TP
 \fB\-\-force\fR
 Allow the default output file
-.B typescript
+.I typescript
 to be a hard or symbolic link.  The command will follow a symbolic link.
 .TP
 \fB\-B\fR, \fB\-\-log\-io\fR \fIfile\fR
@@ -130,12 +135,12 @@ Log input to the \fIfile\fR.  The log output is disabled if only \fB\-\-log\-in\
 specified.
 .sp
 Use this logging functionality carefully as it logs all input, including input
-when terminal has disabled echo flag (for example password inputs).
+when terminal has disabled echo flag (for example, password inputs).
 .TP
 \fB\-O\fR, \fB\-\-log\-out\fR \fIfile\fR
 Log output to the \fIfile\fR.  The default is to log output to the file with
 name
-.B typescript
+.I typescript
 if the option \fB\-\-log\-out\fR or \fB\-\-log\-in\fR is not given.  The log
 output is disabled if only \fB\-\-log\-in\fR specified.
 .TP
@@ -147,7 +152,7 @@ is enabled.  The multi-stream format is used on \fB\-\-log\-io\fR or when
 See also \fB\-\-logging\-format\fR.
 .TP
 \fB\-m\fR, \fB\-\-logging\-format\fR \fIformat\fR
-Force use
+Force use of
 .I advanced
 or
 .I classic
@@ -163,8 +168,10 @@ field indicates how many characters were output this time.
 .sp
 .B Advanced (multi-stream) format
 .PP
-The first field is entry type itentifier ('I'nput, 'O'utput, 'H'eader, 'S'ignal).
-The socond field is how much time elapsed since the previous entry, and rest of the entry is type specific data.
+The first field is an entry type identifier
+('I'nput, 'O'utput, 'H'eader, 'S'ignal).
+The socond field is how much time elapsed since the previous entry,
+and the rest of the entry is type-specific data.
 .RE
 .TP
 \fB\-o\fR, \fB\-\-output-limit\fR \fIsize\fR
@@ -252,7 +259,9 @@ fi
 .RE
 .ad
 .PP
-You should also avoid use of script in command pipes, as
+You should also avoid use of
+.B script
+in command pipes, as
 .B script
 can read more input than you would expect.
 .SH HISTORY
-- 
2.26.2


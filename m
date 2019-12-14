Return-Path: <SRS0=wda/=2E=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAF5C3F68F
	for <util-linux@archiver.kernel.org>; Sat, 14 Dec 2019 00:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AF921655
	for <util-linux@archiver.kernel.org>; Sat, 14 Dec 2019 00:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfLNAVD (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 13 Dec 2019 19:21:03 -0500
Received: from outpost.hi.is ([130.208.165.166]:38534 "EHLO outpost.hi.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbfLNAVC (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 13 Dec 2019 19:21:02 -0500
X-Greylist: delayed 507 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Dec 2019 19:21:00 EST
Received: from inpost.hi.is (inpost.hi.is [IPv6:2a00:c88:4000:1650::165:62])
        by outpost.hi.is (8.14.7/8.14.7) with ESMTP id xBE0EgVD014911
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <util-linux@vger.kernel.org>; Sat, 14 Dec 2019 00:14:42 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 outpost.hi.is xBE0EgVD014911
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id xBE0Eeas005050
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Sat, 14 Dec 2019 00:14:40 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 inpost.hi.is xBE0Eeas005050
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id xBE0Ee7R031024
        for <util-linux@vger.kernel.org>; Sat, 14 Dec 2019 00:14:40 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id xBE0EeBB031023
        for util-linux@vger.kernel.org; Sat, 14 Dec 2019 00:14:40 GMT
Date:   Sat, 14 Dec 2019 00:14:40 +0000
From:   Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To:     util-linux@vger.kernel.org
Subject: [PATCH] man pages: Fix misuse of two-fonts macros
Message-ID: <20191214001440.GA30969@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

  Two-fonts macros are made for two or more arguments.

  Remove space at end of lines in the files "term-utils/{script.1,
scriptlive.1, scriptreplay.1}".

  Put "\-\-summary" to the correct indent in the file
"term-utils/script.1"

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 disk-utils/sfdisk.8        | 2 +-
 login-utils/lslogins.1     | 4 ++--
 login-utils/su.1           | 4 ++--
 sys-utils/adjtime_config.5 | 2 +-
 sys-utils/setpriv.1        | 2 +-
 sys-utils/unshare.1        | 2 +-
 term-utils/script.1        | 6 +++---
 term-utils/scriptlive.1    | 8 ++++----
 term-utils/scriptreplay.1  | 6 +++---
 9 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index ff0739a32..8c1fe1622 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -236,7 +236,7 @@ and the last command reorders partitions to match disk order
 .RE
 
 .TP
-.BR \-\-move\-use\-fsync
+.B \-\-move\-use\-fsync
 Use fsync system call after each write when move dara to a new location by
 \fB\-\-move\-data\fR.
 .TP
diff --git a/login-utils/lslogins.1 b/login-utils/lslogins.1
index 1750fa3c0..04237939d 100644
--- a/login-utils/lslogins.1
+++ b/login-utils/lslogins.1
@@ -9,14 +9,14 @@ lslogins \- display information about known users in the system
 .RB [ \-s | \-u [ =\fIUID ]]
 .RB [ \-g " \fIgroups\fR]"
 .RB [ \-l " \fIlogins\fR]"
-.RB [\fIusername\fR]
+.RI [ username ]
 .SH DESCRIPTION
 .PP
 Examine the wtmp and btmp logs, /etc/shadow (if necessary) and /etc/passwd
 and output the desired data.
 
 The optional argument \fIusername\fR forces
-.BR lslogins
+.B lslogins
 to print all available details about the specified user only. In this case the
 output format is different than in case of \fB\-l\fR or \fB\-g\fR and unknown
 is \fIusername\fR reported as an error.
diff --git a/login-utils/su.1 b/login-utils/su.1
index 8bf41b0df..887ca3f27 100644
--- a/login-utils/su.1
+++ b/login-utils/su.1
@@ -9,13 +9,13 @@ su \- run a command with substitute user and group ID
 allows to run commands with a substitute user and group ID.
 .PP
 When called with no
-.IR user
+.I user
 specified,
 .B su
 defaults to running an interactive shell as
 .IR root .
 When
-.IR user
+.I user
 is specified, additional
 .IR argument s
 can be supplied, in which case they are passed to the shell.
diff --git a/sys-utils/adjtime_config.5 b/sys-utils/adjtime_config.5
index 239b90a87..b03aeddfe 100644
--- a/sys-utils/adjtime_config.5
+++ b/sys-utils/adjtime_config.5
@@ -55,7 +55,7 @@ to Coordinated Universal Time or local time.  You can always override this
 value with options on the hwclock command line.
 
 .SH FILES
-.IR /etc/adjtime
+.I /etc/adjtime
 .SH "SEE ALSO"
 .BR hwclock (8),
 .BR rtcwake (8)
diff --git a/sys-utils/setpriv.1 b/sys-utils/setpriv.1
index 9ff9058ec..09092efa7 100644
--- a/sys-utils/setpriv.1
+++ b/sys-utils/setpriv.1
@@ -165,7 +165,7 @@ to abort if AppArmor is not in use, and the transition may be ignored or cause
 .BR execve (2)
 to fail at AppArmor's whim.
 .TP
-.BI \-\-reset\-env
+.B \-\-reset\-env
 Clears all the environment variables except TERM; initializes the environment variables HOME, SHELL, USER, LOGNAME
 according to the user's passwd entry; sets PATH to \fI/usr/local/bin:/bin:/usr/bin\fR for a regual user and to
 \fI/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin\fR for root.
diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 4f1239d7b..8e8d89006 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -138,7 +138,7 @@ by bind mount.
 Fork the specified \fIprogram\fR as a child process of \fBunshare\fR rather than
 running it directly.  This is useful when creating a new PID namespace.
 .TP
-.BR \-\-keep\-caps
+.B \-\-keep\-caps
 When the \fB--user\fP option is given, ensure that capabilities granted
 in the user namespace are preserved in the child process.
 .TP
diff --git a/term-utils/script.1 b/term-utils/script.1
index 5d46de504..815707e91 100644
--- a/term-utils/script.1
+++ b/term-utils/script.1
@@ -50,7 +50,7 @@ and to store additional information about the session.
 Since version 2.35
 .B script
 supports multiple streams and allows to log input and output to separate
-files or all the one file.  This version also supports new timing file 
+files or all the one file.  This version also supports new timing file
 which records additional information.  The command
 .B scriptreplay \-\-summary
 then provides all the information.
@@ -129,7 +129,7 @@ the log \fIfile\fR.
 Log input to the \fIfile\fR.  The log output is disabled if only \fB\-\-log\-in\fR
 specified.
 .sp
-Use this logging functionality carefully as it logs all input, including input 
+Use this logging functionality carefully as it logs all input, including input
 when terminal has disabled echo flag (for example password inputs).
 .TP
 \fB\-O\fR, \fB\-\-log\-out\fR \fIfile\fR
@@ -242,7 +242,7 @@ can read more input than you would expect.
 .PP
 .SH SIGNALS
 Upon receiving
-.BR SIGUSR1,
+.BR SIGUSR1 ,
 .B script
 immediately flushes the output files.
 .PP
diff --git a/term-utils/scriptlive.1 b/term-utils/scriptlive.1
index d41c319d5..5d597a8fc 100644
--- a/term-utils/scriptlive.1
+++ b/term-utils/scriptlive.1
@@ -5,9 +5,9 @@ scriptlive \- re-run session typescripts, using timing information
 .B scriptlive
 [options]
 .RB [ \-t ]
-.RI timingfile
+.I timingfile
 .RB [ \-I|\-B ]
-.RI typescript
+.I typescript
 .SH "DESCRIPTION"
 This program re-run a typescript, using stdin typescript and timing information to ensure that
 input happens in the same rhythm as it originally appeared when the script
@@ -27,9 +27,9 @@ The timing information is what
 outputs to file specified by
 .BR \-\-log\-timing .
 The typescript has to contain stdin information and it is what
-.BR script (1) 
+.BR script (1)
 outputs to file specified by
-.BR \-\-log-in
+.B \-\-log-in
 or
 .BR \-\-log\-io .
 
diff --git a/term-utils/scriptreplay.1 b/term-utils/scriptreplay.1
index 6d983bc73..626b5a1bf 100644
--- a/term-utils/scriptreplay.1
+++ b/term-utils/scriptreplay.1
@@ -35,7 +35,7 @@ but other filenames may be specified, as the second parameter or with option
 .BR \-\-log\-out .
 .PP
 If the third parameter or
-.BR \-\-divisor
+.B \-\-divisor
 is specified, it is used as a speed-up multiplier.
 For example, a speed-up of 2 makes
 .B scriptreplay
@@ -86,8 +86,8 @@ Set the maximum delay between transcript updates to
 of seconds.  The argument is a floating point number.  This can be used to
 avoid long pauses in the transcript replay.
 .TP
-.BR " \-\-summary "
-Display details about session recorded in the specified timing file and exit.  The session has 
+.B \-\-summary
+Display details about session recorded in the specified timing file and exit.  The session has
 to be recorded by
 .I advanced
 format (see
-- 
2.24.0

Return-Path: <SRS0=ZMjy=7B=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DD4C433E0
	for <util-linux@archiver.kernel.org>; Tue, 19 May 2020 12:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8F542081A
	for <util-linux@archiver.kernel.org>; Tue, 19 May 2020 12:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ufkhplmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgESMyK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 19 May 2020 08:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgESMyK (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 19 May 2020 08:54:10 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7633C08C5C0
        for <util-linux@vger.kernel.org>; Tue, 19 May 2020 05:54:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k13so13698355wrx.3
        for <util-linux@vger.kernel.org>; Tue, 19 May 2020 05:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=XOEcLW8FNpZTV1OohC0REExuRxFuEEHTpt8cU+X+kCc=;
        b=ufkhplmHLP1AqNFpRkZMFRcZ3UTFfm1IjCHIEpfdo4C0eCk2M3T/ytNUfC6/MuWaWV
         G1+WTFFFdB/RZ/ePiVGeYF9hKsUysebzg/g8hQSOTgiG/1qvkADby7p3b4MtztpasDvh
         9EkO6J/cJC5ablrIWM4HGulrCX9NJtkbeTETvEIXsl4xHfszb/pABex15j/M4BKgO4Y8
         +Q/YbTuUB/Z5/HTKzV4easo4Mmbt5sOZ7tqObQZb5GytYzcHX85Gmt3X6G1nMQOC+27+
         UXFKpg0s9UDZ39tJD2tzQXqDy6pBrkMwLuSpxt4ibpjLYgul77SFUuBZoT9y9zq9WGaK
         xpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=XOEcLW8FNpZTV1OohC0REExuRxFuEEHTpt8cU+X+kCc=;
        b=EuEqbvvEu48iRWtaIe2qsGDizc3PPuLi5W2fj8Y4dfvDdDu8YN5AfQdzhPS9t0rcwW
         t/yxM5Gw+25ssF3aE3P6uJHOmI0LlzCfZHyVJdc0QeWqYXv4L3QeLHx5FX3LvYpGca8I
         bJuq1vZiTg1Y2H69F46NKBkJQL5emhGsQBaRaT65FLUAvXZrtYmhCM8yED12YWkAxPHO
         cJGNiKT2D9pQPgvLAQeAcd3cman4m2t4glyGoby4ap80EC/jEfJdrOgtytQgz6uhJK/2
         2deZxpH86W15dUXQeDd+ElsWTpeTZ1AXyM7N2+FGktcvkPreRJ8M/HMcCZcLkCAqbc9g
         tJGg==
X-Gm-Message-State: AOAM533ZN7sy2XCw5mLkHG8Bh8b0YWhy4qb9kSAF3/+LtCVWDzViz7rO
        KMEcQIpWeVESeshWsXS5wxDL5humzto=
X-Google-Smtp-Source: ABdhPJwZqR5jRdqgP5cths4drGarwhnsq6zdmvD0hxRJ8B4zg9om7jIGZfgLfnDkPFKmW+0omUAqvw==
X-Received: by 2002:adf:e4d0:: with SMTP id v16mr25761793wrm.294.1589892847953;
        Tue, 19 May 2020 05:54:07 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id z11sm19878511wrr.32.2020.05.19.05.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 05:54:07 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, util-linux@vger.kernel.org
To:     Karel Zak <kzak@redhat.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: [PATCH 7/7] Various manual pages: use the term "exit status"
Message-ID: <528e4b67-68e1-b3e3-01e3-83f395943b4b@gmail.com>
Date:   Tue, 19 May 2020 14:54:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The manual pages currently use a multitude of terms--"exit code",
"error code", "return code", "exit code", and so on--when what
is always meant is "exit status" (the POSIX term). This patch fixes
as many of these erroneous terms as I could find.

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 disk-utils/fsck.8        |  8 ++++----
 disk-utils/fsck.minix.8  |  6 +++---
 disk-utils/mkfs.8        |  2 +-
 disk-utils/mkfs.bfs.8    |  2 +-
 disk-utils/mkfs.cramfs.8 |  2 +-
 disk-utils/mkfs.minix.8  |  2 +-
 login-utils/nologin.8    |  2 +-
 misc-utils/blkid.8       | 12 ++++++------
 misc-utils/kill.1        |  2 +-
 misc-utils/logger.1      |  2 +-
 sys-utils/chcpu.8        |  2 +-
 sys-utils/chmem.8        |  2 +-
 sys-utils/fallocate.1    |  2 +-
 sys-utils/flock.1        | 10 +++++-----
 sys-utils/mount.8        |  2 +-
 sys-utils/setpriv.1      |  2 +-
 sys-utils/setsid.1       |  4 ++--
 term-utils/script.1      |  4 ++--
 18 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/disk-utils/fsck.8 b/disk-utils/fsck.8
index e53333bca..e9eec2851 100644
--- a/disk-utils/fsck.8
+++ b/disk-utils/fsck.8
@@ -41,7 +41,7 @@ serially.  This is equivalent to the
 .B \-As
 options.
 .PP
-The exit code returned by
+The exit status returned by
 .B fsck
 is the sum of the following conditions:
 .PP
@@ -74,8 +74,8 @@ Shared-library error
 .PD
 .RE
 .PP
-The exit code returned when multiple filesystems are checked
-is the bit-wise OR of the exit codes for each
+The exit status returned when multiple filesystems are checked
+is the bit-wise OR of the exit statuses for each
 filesystem that is checked.
 .PP
 In actuality,
@@ -280,7 +280,7 @@ a progress bar at a time.  GUI front-ends may specify a file descriptor
 in which case the progress bar information will be sent to that file descriptor.
 .TP
 .B \-M
-Do not check mounted filesystems and return an exit code of 0
+Do not check mounted filesystems and return an exit status of 0
 for mounted filesystems.
 .TP
 .B \-N
diff --git a/disk-utils/fsck.minix.8 b/disk-utils/fsck.minix.8
index 600b1e2da..0c26ed3ee 100644
--- a/disk-utils/fsck.minix.8
+++ b/disk-utils/fsck.minix.8
@@ -93,7 +93,7 @@ a MINIX filesystem,
 .B fsck.minix
 will print "bad magic number in super-block".
 .SH EXIT STATUS
-The exit code returned by
+The exit status returned by
 .B fsck.minix
 is the sum of the following:
 .PP
@@ -111,7 +111,7 @@ mounted
 Filesystem errors left uncorrected
 .TP
 .B 7
-Combination of exit codes 3 and 4
+Combination of exit statuses 3 and 4
 .TP
 .B 8
 Operational error
@@ -126,7 +126,7 @@ Usage or syntax error
 Linus Torvalds
 .ME
 .br
-Error code values by
+Exit status values by
 .MT faith@\:cs.\:unc.\:edu
 Rik Faith
 .ME
diff --git a/disk-utils/mkfs.8 b/disk-utils/mkfs.8
index e8edb0f4a..deb00b2bb 100644
--- a/disk-utils/mkfs.8
+++ b/disk-utils/mkfs.8
@@ -20,7 +20,7 @@ or a regular file that shall contain the filesystem.  The
 .I size
 argument is the number of blocks to be used for the filesystem.
 .PP
-The exit code returned by
+The exit status returned by
 .B mkfs
 is 0 on success and 1 on failure.
 .PP
diff --git a/disk-utils/mkfs.bfs.8 b/disk-utils/mkfs.bfs.8
index ca0847227..722b8327b 100644
--- a/disk-utils/mkfs.bfs.8
+++ b/disk-utils/mkfs.bfs.8
@@ -48,7 +48,7 @@ only works as
 .B \-\-version
 when it is the only option.
 .SH EXIT STATUS
-The exit code returned by
+The exit status returned by
 .B mkfs.bfs
 is 0 when all went well, and 1 when something went wrong.
 .SH SEE ALSO
diff --git a/disk-utils/mkfs.cramfs.8 b/disk-utils/mkfs.cramfs.8
index da7085027..63158dd34 100644
--- a/disk-utils/mkfs.cramfs.8
+++ b/disk-utils/mkfs.cramfs.8
@@ -34,7 +34,7 @@ will contain the cram file system, which later can be mounted.
 Enable verbose messaging.
 .TP
 \fB\-E\fR
-Treat all warnings as errors, which are reflected as command return value.
+Treat all warnings as errors, which are reflected as command exit status.
 .TP
 \fB\-b\fR \fIblocksize\fR
 Use defined block size, which has to be divisible by page size.
diff --git a/disk-utils/mkfs.minix.8 b/disk-utils/mkfs.minix.8
index 9a6b26c54..a33d844aa 100644
--- a/disk-utils/mkfs.minix.8
+++ b/disk-utils/mkfs.minix.8
@@ -71,7 +71,7 @@ with other options.
 \fB\-h\fR, \fB\-\-help\fR
 Display help text and exit.
 .SH EXIT STATUS
-The exit code returned by
+The exit status returned by
 .B mkfs.minix
 is one of the following:
 .IP 0
diff --git a/login-utils/nologin.8 b/login-utils/nologin.8
index 054ed7344..d7be1f90e 100644
--- a/login-utils/nologin.8
+++ b/login-utils/nologin.8
@@ -13,7 +13,7 @@ intended as a replacement shell field to deny login access to an account.
 If the file /etc/nologin.txt exists, nologin displays its contents to the
 user instead of the default message.
 .PP
-The exit code returned by
+The exit status returned by
 .B nologin
 is always 1.
 .PP
diff --git a/misc-utils/blkid.8 b/misc-utils/blkid.8
index 6c0bbe43d..e6f2ec8fe 100644
--- a/misc-utils/blkid.8
+++ b/misc-utils/blkid.8
@@ -91,7 +91,7 @@ For security reasons
 .B blkid
 silently ignores all devices where the probing result is ambivalent (multiple
 colliding filesystems are detected).  The low-level probing mode (\fB\-p\fR)
-provides more information and extra return code in this case.
+provides more information and extra exit status in this case.
 It's recommended to use
 .BR wipefs (8)
 to get a detailed overview and to erase obsolete stuff (magic strings) from the device.
@@ -289,16 +289,16 @@ Display version number and exit.
 .SH EXIT STATUS
 If the specified device or device addressed by specified token (option
 \fB\-\-match\-token\fR) was found and it's possible to gather any information about the
-device, an exit code 0 is returned.  Note the option \fB\-\-match\-tag\fR filters output
-tags, but it does not affect return code.
+device, an exit status 0 is returned.  Note the option \fB\-\-match\-tag\fR filters output
+tags, but it does not affect exit status.
 
 If the specified token was not found, or no (specified) devices could be
 identified, or it is impossible to gather any information about the device
-identifiers or device content an exit code of 2 is returned.
+identifiers or device content an exit status of 2 is returned.
 
-For usage or other errors, an exit code of 4 is returned.
+For usage or other errors, an exit status of 4 is returned.
 
-If an ambivalent probing result was detected by low-level probing mode (\fB\-p\fR), an exit code of 8 is
+If an ambivalent probing result was detected by low-level probing mode (\fB\-p\fR), an exit status of 8 is
 returned.
 .SH CONFIGURATION FILE
 The standard location of the
diff --git a/misc-utils/kill.1 b/misc-utils/kill.1
index c0383faca..5c74301f5 100644
--- a/misc-utils/kill.1
+++ b/misc-utils/kill.1
@@ -173,7 +173,7 @@ the executable is to use full path when calling the command, for example:
 .B "/bin/kill \-\-version"
 .SH EXIT STATUS
 .B kill
-has the following return codes:
+has the following exit status values:
 .PP
 .RS
 .PD 0
diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index 501ed938d..67ca2111f 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -262,7 +262,7 @@ before version 2.26 used openlog, and hence was unable to detected loss of
 messages sent to Unix sockets.
 .IP
 The default mode is \fBauto\fR.  When errors are not enabled lost messages are
-not communicated and will result to successful return value of
+not communicated and will result to successful exit status of
 .BR logger (1)
 invocation.
 .TP
diff --git a/sys-utils/chcpu.8 b/sys-utils/chcpu.8
index 7f94de535..10273f6e2 100644
--- a/sys-utils/chcpu.8
+++ b/sys-utils/chcpu.8
@@ -79,7 +79,7 @@ Display help text and exit.
 
 .SH EXIT STATUS
 .B chcpu
-has the following return codes:
+has the following exit status values:
 .TP
 .B 0
 success
diff --git a/sys-utils/chmem.8 b/sys-utils/chmem.8
index 21a8152c0..0727ceca1 100644
--- a/sys-utils/chmem.8
+++ b/sys-utils/chmem.8
@@ -81,7 +81,7 @@ progress.
 Print the version number, then exit.
 .SH EXIT STATUS
 .B chmem
-has the following return codes:
+has the following exit status values:
 .TP
 .B 0
 success
diff --git a/sys-utils/fallocate.1 b/sys-utils/fallocate.1
index 0fc2ec97b..9e214c736 100644
--- a/sys-utils/fallocate.1
+++ b/sys-utils/fallocate.1
@@ -33,7 +33,7 @@ preallocation is done quickly by allocating blocks and marking them as
 uninitialized, requiring no IO to the data blocks.
 This is much faster than creating a file by filling it with zeroes.
 .PP
-The exit code returned by
+The exit status returned by
 .B fallocate
 is 0 on success and 1 on failure.
 .SH OPTIONS
diff --git a/sys-utils/flock.1 b/sys-utils/flock.1
index abcbc73ee..0da5ea946 100644
--- a/sys-utils/flock.1
+++ b/sys-utils/flock.1
@@ -66,7 +66,7 @@ Pass a single \fIcommand\fR, without arguments, to the shell with
 .BR \-c .
 .TP
 .BR \-E , " \-\-conflict\-exit\-code " \fInumber
-The exit code used when the \fB\-n\fP option is in use, and the
+The exit status used when the \fB\-n\fP option is in use, and the
 conflicting lock exists, or the \fB\-w\fP option is in use,
 and the timeout is reached.  The default value is \fB1\fR.
 .TP
@@ -87,7 +87,7 @@ Fail rather than wait if the lock cannot be
 immediately acquired.
 See the
 .B \-E
-option for the exit code used.
+option for the exit status used.
 .TP
 .BR \-o , " \-\-close"
 Close the file descriptor on which the lock is held before executing
@@ -111,7 +111,7 @@ Fail if the lock cannot be acquired within
 Decimal fractional values are allowed.
 See the
 .B \-E
-option for the exit code used. The zero number of
+option for the exit status used. The zero number of
 .I seconds
 is interpreted as \fB\-\-nonblock\fR.
 .TP
@@ -178,11 +178,11 @@ then flock is used to lock the descriptor.
 .SH EXIT STATUS
 The command uses
 .B sysexits.h
-return values for everything, except when using either of the options
+exit status values for everything, except when using either of the options
 .B \-n
 or
 .B \-w
-which report a failure to acquire the lock with a return value given by the
+which report a failure to acquire the lock with a exit status given by the
 .B \-E
 option, or 1 by default.
 .PP
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index a9df585ce..d3170ec71 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -2503,7 +2503,7 @@ a filesystem corruption.
 
 .SH EXIT STATUS
 .B mount
-has the following return codes (the bits can be ORed):
+has the following exit status values (the bits can be ORed):
 .TP
 .B 0
 success
diff --git a/sys-utils/setpriv.1 b/sys-utils/setpriv.1
index 5fb4dec20..39d274a2f 100644
--- a/sys-utils/setpriv.1
+++ b/sys-utils/setpriv.1
@@ -184,7 +184,7 @@ If applying any specified option fails,
 .I program
 will not be run and
 .B setpriv
-will return with exit code 127.
+will return with exit status 127.
 .PP
 Be careful with this tool \-\- it may have unexpected security consequences.
 For example, setting no_new_privs and then execing a program that is
diff --git a/sys-utils/setsid.1 b/sys-utils/setsid.1
index e4a915454..e694ef801 100644
--- a/sys-utils/setsid.1
+++ b/sys-utils/setsid.1
@@ -24,8 +24,8 @@ Set the controlling terminal to the current one.
 Always create a new process.
 .TP
 .BR \-w , " \-\-wait"
-Wait for the execution of the program to end, and return the exit value of
-this program as the return value of
+Wait for the execution of the program to end, and return the exit status of
+this program as the exit status of
 .BR setsid .
 .TP
 .BR \-V , " \-\-version"
diff --git a/term-utils/script.1 b/term-utils/script.1
index daf4a6ff3..52f624754 100644
--- a/term-utils/script.1
+++ b/term-utils/script.1
@@ -104,8 +104,8 @@ terminal to avoid double-echo, and enabled if standard input is not terminal
 to avoid missing input in the session log.
 .TP
 \fB\-e\fR, \fB\-\-return\fR
-Return the exit code of the child process.  Uses the same format as bash
-termination on signal termination exit code is 128+n.  The exit code of
+Return the exit status of the child process.  Uses the same format as bash
+termination on signal termination exit status is 128+n.  The exit status of
 the child process is always stored in type script file too.
 .TP
 \fB\-f\fR, \fB\-\-flush\fR
-- 
2.26.2

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

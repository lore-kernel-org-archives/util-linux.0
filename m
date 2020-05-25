Return-Path: <SRS0=uTWB=7H=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32184C433E2
	for <util-linux@archiver.kernel.org>; Mon, 25 May 2020 12:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 112AF2073B
	for <util-linux@archiver.kernel.org>; Mon, 25 May 2020 12:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEm/RlaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388785AbgEYM73 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 25 May 2020 08:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388738AbgEYM73 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 25 May 2020 08:59:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1C2C061A0E
        for <util-linux@vger.kernel.org>; Mon, 25 May 2020 05:59:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a2so20344394ejb.10
        for <util-linux@vger.kernel.org>; Mon, 25 May 2020 05:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yUhSOvUeNwPj+7/t7tyHV13f2gm9lKvcXrBIOlgRt2w=;
        b=dEm/RlaZ672/LfH1E/aGFKMx9KNkhndZ+F9LLR7QkzvUIzf2cP3XYGPY+lKnYQxfCF
         UVXIMl5/8td31PhFBc4GKrMk7vGYxoMNw3GgX+zq+Te2i6GgWLQnwPucKsabK1GRtEEm
         0uMArJddJ6FV9UELCWyQ73ufp+uJbuinctuD6Es8W9/hwOR610EVcNDwylIEBzm6AbDB
         Cdav+FP0aLAcJXRGInxm8YowVsJgagn6tHQnmZjBSV1/VvewAATojAS/cdbUof+v6SJU
         R82R5IpfddyXZrzMxhg0Soq5iCdhPj1y5Vm1dRPhjZNwj94ciMpK1oJKi6SFa+K6lHEJ
         4C9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yUhSOvUeNwPj+7/t7tyHV13f2gm9lKvcXrBIOlgRt2w=;
        b=unULtkBYZ5bRqfXaeR9+LDL8nGqlf7K/ZVHuFhK04XWK5FvssUzTxsphDarAQcupKO
         yt5kukASGgg5VPsgvP1emHE4ucD9UF3KvPxRNepZ9gWEv5o1UOQM+R/CheETb6sUy2E7
         hLT39q6GGh0q0d7yA9JaxIoK/ltPLt42kfnnXHcEUACyht5x+f6mo83HdUb7lCWRE0W3
         jCBHTjxLvkW4reug30FmO4EF4K8i9Kdf369i3GteBaldFw7eMibIyMzJvTqxWiSgNjrK
         0AcNElw7Ti+kUoKGFCqzs1xGtQo3vkUPGaMqANcHln59jaiP+b7smUrelS09Ir2Jw5XT
         YiLQ==
X-Gm-Message-State: AOAM532A3oDNv4bokQTb7RVA9BuzG482qYE0yeotFR9Z2oQMfk46VYlj
        Ktzqrvq0RbwKfldDsZsGfLA=
X-Google-Smtp-Source: ABdhPJwFp/SqgeebGJBqHQ+owJQhPfVkQsaWL3h9dTswNEfqiXWsdLs+m1N9Ta1ciw0xpgyHdI2mAw==
X-Received: by 2002:a17:906:5f98:: with SMTP id a24mr19131979eju.214.1590411567175;
        Mon, 25 May 2020 05:59:27 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id b14sm15709719edx.93.2020.05.25.05.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 05:59:26 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 5/5] Manual pages: rename EXAMPLE section to EXAMPLES
Date:   Mon, 25 May 2020 14:59:12 +0200
Message-Id: <20200525125912.43748-5-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525125912.43748-1-mtk.manpages@gmail.com>
References: <20200525125912.43748-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Earlier, I patched various pages to consistently use EXAMPLE as a
section heading, rather than EXAMPLES.  (At that time, both headings
occurred in util-linux, with roughly equal frequency.)

Since then, I've observed that EXAMPLES is the more common usage
across a large corpus of manual pages. So, in Linux the man-pages
project, I switched to using EXAMPLES also. This patch makes the same
change for util-linux.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 misc-utils/logger.1       | 2 +-
 misc-utils/look.1         | 2 +-
 misc-utils/rename.1       | 2 +-
 misc-utils/uuidgen.1      | 2 +-
 misc-utils/whereis.1      | 2 +-
 schedutils/ionice.1       | 2 +-
 sys-utils/flock.1         | 2 +-
 sys-utils/prlimit.1       | 2 +-
 sys-utils/renice.1        | 2 +-
 sys-utils/setpriv.1       | 2 +-
 sys-utils/unshare.1       | 4 ++--
 term-utils/scriptlive.1   | 2 +-
 term-utils/scriptreplay.1 | 2 +-
 text-utils/colcrt.1       | 2 +-
 text-utils/column.1       | 2 +-
 text-utils/hexdump.1      | 2 +-
 16 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index 6dd53705d..3cf6b0b1e 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -349,7 +349,7 @@ For the priority order and intended purposes of these facilities and levels, see
 The
 .B logger
 command is expected to be IEEE Std 1003.2 ("POSIX.2") compatible.
-.SH EXAMPLE
+.SH EXAMPLES
 .B logger System rebooted
 .br
 .B logger \-p local0.notice \-t HOSTIDM \-f /dev/idmc
diff --git a/misc-utils/look.1 b/misc-utils/look.1
index d33139e98..4367fa5eb 100644
--- a/misc-utils/look.1
+++ b/misc-utils/look.1
@@ -108,7 +108,7 @@ the alternative dictionary
 The
 .B look
 utility appeared in Version 7 AT&T Unix.
-.SH EXAMPLE
+.SH EXAMPLES
 .RS
 .nf
 sort \-d /etc/passwd \-o /tmp/look.dict
diff --git a/misc-utils/rename.1 b/misc-utils/rename.1
index 64c70f7e4..701bc4f18 100644
--- a/misc-utils/rename.1
+++ b/misc-utils/rename.1
@@ -84,7 +84,7 @@ nothing was renamed
 unanticipated error occurred
 .PD
 .RE
-.SH EXAMPLE
+.SH EXAMPLES
 Given the files
 .IR foo1 ", ..., " foo9 ", " foo10 ", ..., " foo278 ,
 the commands
diff --git a/misc-utils/uuidgen.1 b/misc-utils/uuidgen.1
index 07d646104..0189587a3 100644
--- a/misc-utils/uuidgen.1
+++ b/misc-utils/uuidgen.1
@@ -89,7 +89,7 @@ Generate the hash of the \fIname\fR.
 Interpret name \fIname\fR as a hexadecimal string.
 .SH CONFORMING TO
 OSF DCE 1.1
-.SH EXAMPLE
+.SH EXAMPLES
 uuidgen \-\-sha1 \-\-namespace @dns \-\-name "www.example.com"
 .SH AUTHORS
 .B uuidgen
diff --git a/misc-utils/whereis.1 b/misc-utils/whereis.1
index 8da51d8e9..1b8c3be7c 100644
--- a/misc-utils/whereis.1
+++ b/misc-utils/whereis.1
@@ -153,7 +153,7 @@ are displayed with
 .SH ENVIRONMENT
 .IP WHEREIS_DEBUG=all
 enables debug output.
-.SH EXAMPLE
+.SH EXAMPLES
 To find all files in
 .I /usr/\:bin
 which are not documented
diff --git a/schedutils/ionice.1 b/schedutils/ionice.1
index 415def55a..72dbae6af 100644
--- a/schedutils/ionice.1
+++ b/schedutils/ionice.1
@@ -116,7 +116,7 @@ Display version information and exit.
 .SH NOTES
 Linux supports I/O scheduling priorities and classes since 2.6.13 with the CFQ
 I/O scheduler.
-.SH EXAMPLE
+.SH EXAMPLES
 .LP
 .TP 7
 # \fBionice\fP \-c 3 \-p 89
diff --git a/sys-utils/flock.1 b/sys-utils/flock.1
index bea70c6be..def273dbd 100644
--- a/sys-utils/flock.1
+++ b/sys-utils/flock.1
@@ -137,7 +137,7 @@ option, or 1 by default.
 .PP
 When using the \fIcommand\fR variant, and executing the child worked, then
 the exit status is that of the child command.
-.SH EXAMPLE
+.SH EXAMPLES
 Note that "shell> " in examples is a command line prompt.
 .TP
 shell1> flock /tmp \-c cat
diff --git a/sys-utils/prlimit.1 b/sys-utils/prlimit.1
index 89933d90a..0bf2db008 100644
--- a/sys-utils/prlimit.1
+++ b/sys-utils/prlimit.1
@@ -93,7 +93,7 @@ Timeout for real-time tasks.
 The prlimit system call is supported since Linux 2.6.36, older kernels will
 break this program.
 
-.SH EXAMPLE
+.SH EXAMPLES
 .IP "\fBprlimit \-\-pid 13134\fP"
 Display limit values for all current resources.
 .IP "\fBprlimit \-\-pid 13134 \-\-rss \-\-nofile=1024:4095\fP"
diff --git a/sys-utils/renice.1 b/sys-utils/renice.1
index 99cc61f21..cb9863143 100644
--- a/sys-utils/renice.1
+++ b/sys-utils/renice.1
@@ -101,7 +101,7 @@ negative (to make things go very fast).
 The
 .B renice
 command appeared in 4.0BSD.
-.SH EXAMPLE
+.SH EXAMPLES
 The following command would change the priority of the processes with
 PIDs 987 and 32, plus all processes owned by the users daemon and root:
 .TP
diff --git a/sys-utils/setpriv.1 b/sys-utils/setpriv.1
index 222fa6388..d1bd5efda 100644
--- a/sys-utils/setpriv.1
+++ b/sys-utils/setpriv.1
@@ -190,7 +190,7 @@ Be careful with this tool \-\- it may have unexpected security consequences.
 For example, setting no_new_privs and then execing a program that is
 SELinux\-confined (as this tool would do) may prevent the SELinux
 restrictions from taking effect.
-.SH EXAMPLE
+.SH EXAMPLES
 If you're looking for behaviour similar to
 .BR su (1)/ runuser "(1), or " sudo (8)
 (without the
diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 679f93715..ea170b13a 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -28,7 +28,7 @@ Once a persistent \%namespace is no longer needed,
 it can be unpersisted by using
 .BR umount (8)
 to remove the bind mount.
-See the \fBEXAMPLE\fR section for more details.
+See the \fBEXAMPLES\fR section for more details.
 .PP
 .B unshare
 since util-linux version 2.36 uses /\fIproc/[pid]/ns/pid_for_children\fP and \fI/proc/[pid]/ns/time_for_children\fP
@@ -243,7 +243,7 @@ The proc and sysfs filesystems mounting as root in a user namespace have to be
 restricted so that a less privileged user can not get more access to sensitive
 files that a more privileged user made unavailable. In short the rule for proc
 and sysfs is as close to a bind mount as possible.
-.SH EXAMPLE
+.SH EXAMPLES
 .PP
 The following command creates a PID namespace, using
 .B \-\-fork
diff --git a/term-utils/scriptlive.1 b/term-utils/scriptlive.1
index 6639c73d1..78694dcbb 100644
--- a/term-utils/scriptlive.1
+++ b/term-utils/scriptlive.1
@@ -65,7 +65,7 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
-.SH EXAMPLE
+.SH EXAMPLES
 .nf
 % script --log-timing file.tm --log-in script.in
 Script started, file is script.out
diff --git a/term-utils/scriptreplay.1 b/term-utils/scriptreplay.1
index 4505ef836..a93b8a790 100644
--- a/term-utils/scriptreplay.1
+++ b/term-utils/scriptreplay.1
@@ -110,7 +110,7 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
-.SH EXAMPLE
+.SH EXAMPLES
 .nf
 % script --log-timing file.tm --log-out script.out
 Script started, file is script.out
diff --git a/text-utils/colcrt.1 b/text-utils/colcrt.1
index 90ded9577..46c612bb7 100644
--- a/text-utils/colcrt.1
+++ b/text-utils/colcrt.1
@@ -84,7 +84,7 @@ Lines are trimmed to 132 characters.
 .PP
 Some provision should be made for processing superscripts and subscripts in
 documents which are already double-spaced.
-.SH EXAMPLE
+.SH EXAMPLES
 A typical use of
 .B colcrt
 would be:
diff --git a/text-utils/column.1 b/text-utils/column.1
index e43d6fee4..5e4e29e68 100644
--- a/text-utils/column.1
+++ b/text-utils/column.1
@@ -157,7 +157,7 @@ has since been corrected (see above). Other implementations of
 .B column
 may continue to use the older documentation, but the behavior should be
 identical in any case.
-.SH EXAMPLE
+.SH EXAMPLES
 Print fstab with header line and align number to the right:
 .EX
 \fBsed 's/#.*//' /etc/fstab | column \-\-table \-\-table-columns SOURCE,TARGET,TYPE,OPTIONS,PASS,FREQ \-\-table-right PASS,FREQ\fR
diff --git a/text-utils/hexdump.1 b/text-utils/hexdump.1
index f5728f939..abf1b8370 100644
--- a/text-utils/hexdump.1
+++ b/text-utils/hexdump.1
@@ -347,7 +347,7 @@ exits 0 on success and >0 if an error occurred.
 The
 .B hexdump
 utility is expected to be IEEE Std 1003.2 ("POSIX.2") compatible.
-.SH EXAMPLE
+.SH EXAMPLES
 Display the input in perusal format:
 .nf
    "%06.6_ao "  12/1 "%3_u "
-- 
2.26.2


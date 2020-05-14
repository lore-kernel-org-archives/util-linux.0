Return-Path: <SRS0=ViFG=64=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3F5C433E0
	for <util-linux@archiver.kernel.org>; Thu, 14 May 2020 23:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F412065D
	for <util-linux@archiver.kernel.org>; Thu, 14 May 2020 23:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgENXzo (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 14 May 2020 19:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgENXzn (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 14 May 2020 19:55:43 -0400
X-Greylist: delayed 249 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 May 2020 16:55:43 PDT
Received: from outpost.hi.is (outpost.hi.is [IPv6:2a00:c88:4000:1650::165:166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190BDC061A0C
        for <util-linux@vger.kernel.org>; Thu, 14 May 2020 16:55:42 -0700 (PDT)
Received: from inpost.hi.is (inpost.hi.is [IPv6:2a00:c88:4000:1650::165:62])
        by outpost.hi.is (8.14.7/8.14.7) with ESMTP id 04ENpYTq013294
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <util-linux@vger.kernel.org>; Thu, 14 May 2020 23:51:34 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 outpost.hi.is 04ENpYTq013294
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id 04ENpU8Y000856
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Thu, 14 May 2020 23:51:30 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 inpost.hi.is 04ENpU8Y000856
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id 04ENpUhJ008438
        for <util-linux@vger.kernel.org>; Thu, 14 May 2020 23:51:30 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id 04ENpUbx008437
        for util-linux@vger.kernel.org; Thu, 14 May 2020 23:51:30 GMT
Date:   Thu, 14 May 2020 23:51:29 +0000
From:   Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To:     util-linux@vger.kernel.org
Subject: [PATCH] util-linux: Some minor fixes in some manuals
Message-ID: <20200514235129.GA8403@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Output is from: test-groff -b -e -mandoc -T utf8 -rF0 -t -w w -z

  [ "test-groff" is a developmental version of "groff" ]

Input file is ././misc-utils/kill.1

<./misc-utils/kill.1>:173 (macro BR): only 1 argument, but more are expected
####

Input file is ././misc-utils/lsblk.8

troff: backtrace: '/home/bg/git/groff/build/s-tmac/an-old.tmac':478: macro 'BR'
troff: backtrace: file '<./misc-utils/lsblk.8>':122
troff: <./misc-utils/lsblk.8>:122: warning: trailing space
####

Input file is ././sys-utils/mount.8

an-old.tmac: <./sys-utils/mount.8>:2427 (.RE): warning: extra .RE or .RS is missing before it; "an-RS-open" is 0.

####

Input file is ././sys-utils/unshare.1

<./sys-utils/unshare.1>:176 (macro BR): only 1 argument, but more are expected
<./sys-utils/unshare.1>:181 (macro BR): only 1 argument, but more are expected
<./sys-utils/unshare.1>:240 (macro BR): only 1 argument, but more are expected
<./sys-utils/unshare.1>:246 (macro BR): only 1 argument, but more are expected
####

Input file is ././term-utils/agetty.8

troff: backtrace: file '<./term-utils/agetty.8>':130
troff: <./term-utils/agetty.8>:130: warning: trailing space
####

Input file is ././text-utils/more.1

troff: backtrace: file '<./text-utils/more.1>':91
troff: <./text-utils/more.1>:91: warning: macro 'b' not defined

####

  The output from nroff and troff is unchanged, except for the word
"number" in text-utils/more.1, that was missing.

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 misc-utils/kill.1   | 2 +-
 misc-utils/lsblk.8  | 2 +-
 sys-utils/mount.8   | 1 -
 sys-utils/unshare.1 | 8 ++++----
 term-utils/agetty.8 | 2 +-
 text-utils/more.1   | 4 ++--
 6 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/misc-utils/kill.1 b/misc-utils/kill.1
index 65872ce19..27258d293 100644
--- a/misc-utils/kill.1
+++ b/misc-utils/kill.1
@@ -170,7 +170,7 @@ preferred in relation to the
 .BR kill (1)
 executable described by this manual.  Easiest way to ensure one is executing
 the executable is to use full path when calling the command, for example:
-.BR "/bin/kill --version"
+.B "/bin/kill \-\-version"
 .SH RETURN CODES
 .B kill
 has the following return codes:
diff --git a/misc-utils/lsblk.8 b/misc-utils/lsblk.8
index 416b28298..1b73e6f25 100644
--- a/misc-utils/lsblk.8
+++ b/misc-utils/lsblk.8
@@ -119,7 +119,7 @@ The default is to use tree for the column 'NAME' (see also \fB\-\-tree\fR).
 The default list of columns may be extended if \fIlist\fP is
 specified in the format \fI+list\fP (e.g., \fBlsblk \-o +UUID\fP).
 .TP
-.BR \-O , " \-\-output\-all "
+.BR \-O , " \-\-output\-all"
 Output all available columns.
 .TP
 .BR \-P , " \-\-pairs"
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 54af6c2b1..05117c727 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -2424,7 +2424,6 @@ Parity bytes for FEC (default: 2). Optional.
 Path to pkcs7 signature of root hash hex string. Requires crypt_activate_by_signed_key() from cryptsetup and
 kernel built with CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG. For device reuse, signatures have to be either used by all
 mounts of a device or by none. Optional.
-.RE
 .PP
 Supported since util-linux v2.35.
 .PP
diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index a58821921..86506ffa3 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -173,12 +173,12 @@ implies creating a new mount namespace since the /proc mount would otherwise
 mess up existing programs on the system.  The new proc filesystem is explicitly
 mounted as private (with MS_PRIVATE|MS_REC).
 .TP
-.BR \-\-map\-user=\fIuid|name
+.BI \-\-map\-user= uid|name
 Run the program only after the current effective user ID has been mapped to \fIuid\fP.
 If this option is specified multiple times, the last occurrence takes precedence.
 This option implies \fB\-\-user\fR.
 .TP
-.BR \-\-map\-group=\fIgid|name
+.BI \-\-map\-group= gid|name
 Run the program only after the current effective group ID has been mapped to \fIgid\fP.
 If this option is specified multiple times, the last occurrence takes precedence.
 This option implies \fB\-\-setgroups=deny\fR and \fB\-\-user\fR.
@@ -237,13 +237,13 @@ Set the user ID which will be used in the entered namespace.
 Set the group ID which will be used in the entered namespace and drop
 supplementary groups.
 .TP
-.BR "\-\-monotonic \fIoffset"
+.BI \-\-monotonic " offset"
 Set the offset of
 .B CLOCK_MONOTONIC
 which will be used in the entered time namespace. This option requires
 unsharing a time namespace with \fB\-\-time\fP.
 .TP
-.BR "\-\-boottime \fIoffset"
+.BI \-\-boottime " offset"
 Set the offset of
 .B CLOCK_BOOTTIME
 which will be used in the entered time namespace. This option requires
diff --git a/term-utils/agetty.8 b/term-utils/agetty.8
index fa92df09c..fd6cf4b44 100644
--- a/term-utils/agetty.8
+++ b/term-utils/agetty.8
@@ -127,7 +127,7 @@ messages to be displayed on different terminals.  The
 \-\-show\-issue
 Display the current issue file (or other) on the current terminal and exit.
 Use this option to review the current setting, it is not designed for any other
-purpose.  Note that output may use some default or incomplete information as 
+purpose.  Note that output may use some default or incomplete information as
 proper output depends on terminal and agetty command line.
 .TP
 \-h, \-\-flow\-control
diff --git a/text-utils/more.1 b/text-utils/more.1
index 2176d5528..4cf445f87 100644
--- a/text-utils/more.1
+++ b/text-utils/more.1
@@ -88,9 +88,9 @@ compatibility.
 .TP
 \fB\-n\fR, \fB\-\-lines \fInumber\fR
 Specify the
-.b number
+.I number
 of lines per screenful.  The
-.b number
+.I number
 argument is a positive decimal integer.  The
 .B \-\-lines
 option shall override any values obtained from any other source, such as
-- 
2.26.2

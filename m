Return-Path: <SRS0=K2/4=7Y=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C428CC433E0
	for <util-linux@archiver.kernel.org>; Thu, 11 Jun 2020 01:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F3F1206A4
	for <util-linux@archiver.kernel.org>; Thu, 11 Jun 2020 01:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgFKB0k (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 10 Jun 2020 21:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFKB0k (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 10 Jun 2020 21:26:40 -0400
Received: from inpost.hi.is (inpost.hi.is [IPv6:2a00:c88:4000:1650::165:62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA28C08C5C1
        for <util-linux@vger.kernel.org>; Wed, 10 Jun 2020 18:26:39 -0700 (PDT)
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id 05B1QbJU020841
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Thu, 11 Jun 2020 01:26:37 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 inpost.hi.is 05B1QbJU020841
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id 05B1QbZj028579
        for <util-linux@vger.kernel.org>; Thu, 11 Jun 2020 01:26:37 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id 05B1QbCd028578
        for util-linux@vger.kernel.org; Thu, 11 Jun 2020 01:26:37 GMT
Date:   Thu, 11 Jun 2020 01:26:37 +0000
From:   Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To:     util-linux@vger.kernel.org
Subject: [PATCH] doc: term-utils/*: fix some warnings from "mandoc -T lint"
Message-ID: <20200611012637.GA28369@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

mandoc: ./term-utils/agetty.8:224:36: WARNING: undefined escape, printing literally: \\
mandoc: ./term-utils/agetty.8:12:2: STYLE: fill mode already enabled, skipping: fi
mandoc: ./term-utils/agetty.8:307:2: WARNING: skipping paragraph macro: PP empty
mandoc: ./term-utils/agetty.8:489:2: STYLE: fill mode already enabled, skipping: fi
mandoc: ./term-utils/agetty.8:503:2: STYLE: fill mode already enabled, skipping: fi

mandoc: ./term-utils/script.1:198:2: WARNING: skipping paragraph macro: PP empty
mandoc: ./term-utils/script.1:244:2: WARNING: empty block: RS
mandoc: ./term-utils/script.1:261:2: WARNING: skipping paragraph macro: PP empty

mandoc: ./term-utils/scriptlive.1:77:2: STYLE: fill mode already disabled, skipping: nf

mandoc: ./term-utils/scriptreplay.1:122:2: STYLE: fill mode already disabled, skipping: nf

###

  Additional change:

1)  Changed '  ' once to ' ' in "agetty.8"

2)  Change in the output from "groff":

'-' changed to '\-' in "agetty.8".

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 term-utils/agetty.8       | 8 ++------
 term-utils/script.1       | 4 ----
 term-utils/scriptlive.1   | 2 +-
 term-utils/scriptreplay.1 | 2 +-
 4 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/term-utils/agetty.8 b/term-utils/agetty.8
index c8d9796c5..76ba9e280 100644
--- a/term-utils/agetty.8
+++ b/term-utils/agetty.8
@@ -9,7 +9,6 @@ agetty \- alternative Linux getty
 
 .SH DESCRIPTION
 .ad
-.fi
 \fBagetty\fP opens a tty port, prompts for a login name and invokes
 the /bin/login command.  It is normally invoked by \fBinit\fP(8).
 
@@ -217,11 +216,11 @@ program that \fBagetty\fR starts (usually /bin/login) is run as root.
 Do not print a newline before writing out /etc/issue.
 .TP
 \-o, \-\-login\-options "\fIlogin_options\fP"
-Options  and arguments that  are passed to \fBlogin\fP(1). Where \\u is
+Options and arguments that  are passed to \fBlogin\fP(1). Where \eu is
 replaced by the login name. For example:
 .RS
 .IP "" 4
-.B "\-\-login\-options '-h darkstar -- \\\u'"
+.B "\-\-login\-options '\-h darkstar \-\- \eu'"
 .PP
 See \fB\-\-autologin\fR, \fB\-\-login\-program\fR and \fB\-\-remote\fR.
 .PP
@@ -304,7 +303,6 @@ Display version information and exit.
 .TP
 \-\-help
 Display help text and exit.
-.PP
 .SH EXAMPLE
 This section shows examples for the process field of an entry in the
 \fI/etc/inittab\fP file.  You'll have to prepend appropriate values
@@ -486,7 +484,6 @@ problem reports (if syslog(3) is not used).
 \fIinit\fP(8) configuration file for SysV-style init daemon.
 .SH BUGS
 .ad
-.fi
 The baud-rate detection feature (the \fB\-\-extract\-baud\fP option) requires that
 \fBagetty\fP be scheduled soon enough after completion of a dial-in
 call (within 30 ms with modems that talk at 2400 baud).  For robustness,
@@ -500,7 +497,6 @@ The baud-rate detection feature (the \fB\-\-extract\-baud\fP option) requires th
 the modem emits its status message \fIafter\fP raising the DCD line.
 .SH DIAGNOSTICS
 .ad
-.fi
 Depending on how the program was configured, all diagnostics are
 written to the console device or reported via the \fBsyslog\fR(3) facility.
 Error messages are produced if the \fIport\fP argument does not
diff --git a/term-utils/script.1 b/term-utils/script.1
index ce6b124a4..59c8b2572 100644
--- a/term-utils/script.1
+++ b/term-utils/script.1
@@ -195,7 +195,6 @@ Upon receiving
 .BR SIGUSR1 ,
 .B script
 immediately flushes the output files.
-.PP
 .SH ENVIRONMENT
 The following environment variable is utilized by
 .BR script :
@@ -241,8 +240,6 @@ is always interactive, and this could lead to unexpected results.  If you use
 in the shell initialization file, you have to avoid entering an infinite
 loop.  You can use for example the \fB\%.profile\fR file, which is read
 by login shells only:
-.RS
-.RE
 .sp
 .na
 .RS
@@ -258,7 +255,6 @@ fi
 You should also avoid use of script in command pipes, as
 .B script
 can read more input than you would expect.
-.PP
 .SH HISTORY
 The
 .B script
diff --git a/term-utils/scriptlive.1 b/term-utils/scriptlive.1
index 78694dcbb..236868b8f 100644
--- a/term-utils/scriptlive.1
+++ b/term-utils/scriptlive.1
@@ -74,7 +74,7 @@ Script started, file is script.out
 % exit
 Script done, file is script.out
 % scriptlive --log-timing file.tm --log-in script.in
-.nf
+.fi
 .SH AUTHORS
 .MT kzak@\:redhat.com
 Karel Zak
diff --git a/term-utils/scriptreplay.1 b/term-utils/scriptreplay.1
index 7f1487561..99bf9c3d2 100644
--- a/term-utils/scriptreplay.1
+++ b/term-utils/scriptreplay.1
@@ -119,7 +119,7 @@ Script started, file is script.out
 % exit
 Script done, file is script.out
 % scriptreplay --log-timing file.tm --log-out script.out
-.nf
+.fi
 .SH AUTHORS
 The original
 .B scriptreplay
-- 
2.26.2

-- 
Bjarni I. Gíslason

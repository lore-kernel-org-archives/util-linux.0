Return-Path: <SRS0=l+by=AU=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75332C433DF
	for <util-linux@archiver.kernel.org>; Thu,  9 Jul 2020 23:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 572DB20578
	for <util-linux@archiver.kernel.org>; Thu,  9 Jul 2020 23:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgGIXYa (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgGIXY3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 9 Jul 2020 19:24:29 -0400
Received: from inpost.hi.is (inpost.hi.is [IPv6:2a00:c88:4000:1650::165:62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A74C08C5CE
        for <util-linux@vger.kernel.org>; Thu,  9 Jul 2020 16:24:29 -0700 (PDT)
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id 069NORnZ028681
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Thu, 9 Jul 2020 23:24:27 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 inpost.hi.is 069NORnZ028681
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id 069NORsf028544
        for <util-linux@vger.kernel.org>; Thu, 9 Jul 2020 23:24:27 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id 069NOROH028543
        for util-linux@vger.kernel.org; Thu, 9 Jul 2020 23:24:27 GMT
Date:   Thu, 9 Jul 2020 23:24:27 +0000
From:   Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To:     util-linux@vger.kernel.org
Subject: [PATCH] docs: remove trailing space in strings
Message-ID: <20200709232427.GA28505@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

  Trim trailing space in strings.

  There is no change in the output of "nroff" and "groff".

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 misc-utils/uuidd.8.in | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/misc-utils/uuidd.8.in b/misc-utils/uuidd.8.in
index 75bcc7c67..3c8e2025b 100644
--- a/misc-utils/uuidd.8.in
+++ b/misc-utils/uuidd.8.in
@@ -17,13 +17,13 @@ in a secure and guaranteed-unique fashion, even in the face of large
 numbers of threads running on different CPUs trying to grab UUIDs.
 .SH OPTIONS
 .TP
-.BR \-d , " \-\-debug "
+.BR \-d , " \-\-debug"
 Run uuidd in debugging mode.  This prevents uuidd from running as a daemon.
 .TP
-.BR \-F , " \-\-no-fork "
+.BR \-F , " \-\-no-fork"
 Do not daemonize using a double-fork.
 .TP
-.BR \-k , " \-\-kill "
+.BR \-k , " \-\-kill"
 If currently a uuidd daemon is running, kill it.
 .TP
 .BR \-n , " \-\-uuids " \fInumber\fR
@@ -32,21 +32,21 @@ of
 .I number
 UUIDs.
 .TP
-.BR \-P , " \-\-no-pid "
+.BR \-P , " \-\-no-pid"
 Do not create a pid file.
 .TP
 .BR \-p , " \-\-pid " \fIpath\fR
 Specify the pathname where the pid file should be written.  By default,
 the pid file is written to @runstatedir@/uuidd/uuidd.pid.
 .TP
-.BR \-q , " \-\-quiet "
+.BR \-q , " \-\-quiet"
 Suppress some failure messages.
 .TP
-.BR \-r , " \-\-random "
+.BR \-r , " \-\-random"
 Test uuidd by trying to connect to a running uuidd daemon and
 request it to return a random-based UUID.
 .TP
-.BR \-S , " \-\-socket-activation "
+.BR \-S , " \-\-socket-activation"
 Do not create a socket but instead expect it to be provided by the calling
 process.  This implies \fB\-\-no-fork\fR and \fB\-\-no-pid\fR.  This option is
 intended to be used only with \fBsystemd\fR(1).  It needs to be enabled with
@@ -61,14 +61,14 @@ library.
 .BR \-T , " \-\-timeout " \fInumber\fR
 Make uuidd exit after \fInumber\fR seconds of inactivity.
 .TP
-.BR \-t , " \-\-time "
+.BR \-t , " \-\-time"
 Test uuidd by trying to connect to a running uuidd daemon and
 request it to return a time-based UUID.
 .TP
-.BR \-V , " \-\-version "
+.BR \-V , " \-\-version"
 Output version information and exit.
 .TP
-.BR \-h , " \-\-help "
+.BR \-h , " \-\-help"
 Display help screen and exit.
 .SH EXAMPLE
 Start up a daemon, print 42 random keys, and then stop the daemon:
-- 
2.27.0

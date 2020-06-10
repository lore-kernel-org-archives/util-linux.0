Return-Path: <SRS0=qkB4=7X=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52588C433DF
	for <util-linux@archiver.kernel.org>; Wed, 10 Jun 2020 22:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3413820760
	for <util-linux@archiver.kernel.org>; Wed, 10 Jun 2020 22:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgFJWuC (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgFJWuB (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 10 Jun 2020 18:50:01 -0400
Received: from inpost.hi.is (inpost.hi.is [IPv6:2a00:c88:4000:1650::165:62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584DDC03E96B
        for <util-linux@vger.kernel.org>; Wed, 10 Jun 2020 15:50:01 -0700 (PDT)
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id 05AMnxLO013176
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Wed, 10 Jun 2020 22:49:59 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 inpost.hi.is 05AMnxLO013176
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id 05AMnxQn021148
        for <util-linux@vger.kernel.org>; Wed, 10 Jun 2020 22:49:59 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id 05AMnxKu021147
        for util-linux@vger.kernel.org; Wed, 10 Jun 2020 22:49:59 GMT
Date:   Wed, 10 Jun 2020 22:49:59 +0000
From:   Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To:     util-linux@vger.kernel.org
Subject: [PATCH] doc: login-utils/*: Fix some warnings from "mandoc -T lint"
Message-ID: <20200610224959.GA21138@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

mandoc: ./login-utils/chfn.1:96:2: WARNING: skipping paragraph macro: PP empty

mandoc: ./login-utils/lslogins.1:14:2: WARNING: skipping paragraph macro: PP after SH

mandoc: ./login-utils/newgrp.1:18:2: WARNING: skipping paragraph macro: PP empty

mandoc: ./login-utils/nologin.8:19:2: WARNING: skipping paragraph macro: PP empty

mandoc: ./login-utils/sulogin.8:57:2: WARNING: skipping paragraph macro: PP empty

mandoc: ./login-utils/utmpdump.1:61:2: WARNING: skipping paragraph macro: PP after SS

mandoc: ./login-utils/vipw.8:65:2: WARNING: line scope broken: TP breaks I

####

  There is no change in output from "nroff" or "groff".

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 login-utils/chfn.1     | 1 -
 login-utils/lslogins.1 | 1 -
 login-utils/newgrp.1   | 1 -
 login-utils/nologin.8  | 1 -
 login-utils/sulogin.8  | 1 -
 login-utils/utmpdump.1 | 1 -
 login-utils/vipw.8     | 1 -
 7 files changed, 7 deletions(-)

diff --git a/login-utils/chfn.1 b/login-utils/chfn.1
index 23f048325..9e4569622 100644
--- a/login-utils/chfn.1
+++ b/login-utils/chfn.1
@@ -93,7 +93,6 @@ r = Office (room), w = Office (work) Phone, h = Home Phone.  For example,
 If CHFN_RESTRICT is undefined, then all finger information is read-only.
 This is the default.
 .RE
-.PP
 .SH EXIT STATUS
 Returns 0 if operation was successful, 1 if operation failed or command syntax was not valid.
 .SH AUTHORS
diff --git a/login-utils/lslogins.1 b/login-utils/lslogins.1
index 123f61ccf..6824001d4 100644
--- a/login-utils/lslogins.1
+++ b/login-utils/lslogins.1
@@ -11,7 +11,6 @@ lslogins \- display information about known users in the system
 .RB [ \-l " \fIlogins\fR]"
 .RI [ username ]
 .SH DESCRIPTION
-.PP
 Examine the wtmp and btmp logs, /etc/shadow (if necessary) and /etc/passwd
 and output the desired data.
 
diff --git a/login-utils/newgrp.1 b/login-utils/newgrp.1
index 9902cd547..dc89b3cc2 100644
--- a/login-utils/newgrp.1
+++ b/login-utils/newgrp.1
@@ -15,7 +15,6 @@ is unchanged, but calculations of access permissions to files are performed
 with respect to the new group ID.
 .LP
 If no group is specified, the GID is changed to the login GID.
-.LP
 .SH FILES
 .I /etc/group
 .br
diff --git a/login-utils/nologin.8 b/login-utils/nologin.8
index 6fc6fc68f..a95ff2ba1 100644
--- a/login-utils/nologin.8
+++ b/login-utils/nologin.8
@@ -16,7 +16,6 @@ user instead of the default message.
 The exit status returned by
 .B nologin
 is always 1.
-.PP
 .SH OPTIONS
 \fB\-c\fR, \fB\-\-command\fR \fIcommand\fR
 .br
diff --git a/login-utils/sulogin.8 b/login-utils/sulogin.8
index 7e77cd541..0ba003ad3 100644
--- a/login-utils/sulogin.8
+++ b/login-utils/sulogin.8
@@ -54,7 +54,6 @@ to get the password.  If these files are damaged or nonexistent, or when
 root account is locked by '!' or '*' at the begin of the password then
 .B sulogin
 will \fBstart a root shell without asking for a password\fP.
-.PP
 .IP
 Only use the
 .B \-e
diff --git a/login-utils/utmpdump.1 b/login-utils/utmpdump.1
index 4085f1760..c11a28fcc 100644
--- a/login-utils/utmpdump.1
+++ b/login-utils/utmpdump.1
@@ -58,7 +58,6 @@ But be warned,
 .B utmpdump
 was written for debugging purposes only.
 .SS File formats
-.PP
 Only the binary version of the
 .BR utmp (5)
 is standardised.  Textual dumps may become incompatible in future.
diff --git a/login-utils/vipw.8 b/login-utils/vipw.8
index 6f9695ae4..e3d9eebf0 100644
--- a/login-utils/vipw.8
+++ b/login-utils/vipw.8
@@ -62,7 +62,6 @@ If the following environment variable exists, it will be utilized by
 .B vipw
 and
 .BR vigr :
-.I
 .TP
 .B EDITOR
 The editor specified by the string
-- 
2.26.2

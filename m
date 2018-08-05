Return-Path: util-linux-owner@vger.kernel.org
Received: from inpost.hi.is ([130.208.165.62]:32832 "EHLO inpost.hi.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbeHEU46 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 5 Aug 2018 16:56:58 -0400
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id w75IpP7X007814
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Sun, 5 Aug 2018 18:51:25 GMT
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id w75IpPkn025472
        for <util-linux@vger.kernel.org>; Sun, 5 Aug 2018 18:51:25 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id w75IpPoj025471
        for util-linux@vger.kernel.org; Sun, 5 Aug 2018 18:51:25 GMT
Date: Sun, 5 Aug 2018 18:51:25 +0000
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Subject: [PATCH] man pages: fix formatting of long lines in tables
Message-ID: <20180805185125.GA25444@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  Define the allowed length of the last (second) column to use the
whole line for text.

  Use text blocks for long lines.

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---

  Warning from "test-groff -b -e -mandoc -T utf8 -rF0 -t -w w -z"

warning: file '<./misc-utils/logger.1>', around line 308:
  table wider than line width

  [ "test-groff" is a developmental version of "groff" ]

 misc-utils/logger.1    |  7 +++++--
 misc-utils/uuidparse.1 | 19 ++++++++++++++-----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index bbadd3ddc..9fee5d327 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -293,15 +293,18 @@ utility exits 0 on success, and >0 if an error occurs.
 .SH FACILITIES AND LEVELS
 Valid facility names are:
 .IP
+.nr WI \n(.lu-\n(.iu-\w'\fBauthpriv\fR'u-3n
 .TS
 tab(:);
-l l.
+l lw(\n(WIu).
 \fBauth
 \fBauthpriv\fR:for security information of a sensitive nature
 \fBcron
 \fBdaemon
 \fBftp
-\fBkern\fR:cannot be generated from userspace process, automatically converted to \fBuser
+\fBkern\fR:T{
+cannot be generated from userspace process, automatically converted to \fBuser
+T}
 \fBlpr
 \fBmail
 \fBnews
diff --git a/misc-utils/uuidparse.1 b/misc-utils/uuidparse.1
index 979926755..b3362d401 100644
--- a/misc-utils/uuidparse.1
+++ b/misc-utils/uuidparse.1
@@ -12,13 +12,22 @@ This command will parse unique identifier inputs from either command line
 arguments or standard input.  The inputs are white-space separated.
 .SH OUTPUT
 .SS Variants
+.nr WI \n(.lu-\n(.iu-\w'Microsoft'u-3n
 .TS
 tab(:);
-l l.
-NCS:Network Computing System identifier.  These were the original UUIDs.
-DCE:The Open Software Foundation's (OSF) Distributed Computing Environment UUIDs.
-Microsoft:Microsoft Windows platform globally unique identifier (GUID).
-other:Unknown variant.  Usually invalid input data.
+l lw(\n(WIu).
+NCS:T{
+Network Computing System identifier.  These were the original UUIDs.
+T}
+DCE:T{
+The Open Software Foundation's (OSF) Distributed Computing Environment UUIDs.
+T}
+Microsoft:T{
+Microsoft Windows platform globally unique identifier (GUID).
+T}
+other:T{
+Unknown variant.  Usually invalid input data.
+T}
 .TE
 .SS Types
 .TS
-- 
2.18.0

-- 
Bjarni I. Gislason

Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37026 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbdKZR12 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 26 Nov 2017 12:27:28 -0500
Received: by mail-wr0-f194.google.com with SMTP id k61so24284038wrc.4
        for <util-linux@vger.kernel.org>; Sun, 26 Nov 2017 09:27:28 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/2] man: use long options in text and add example to uuidgen
Date: Sun, 26 Nov 2017 17:27:21 +0000
Message-Id: <20171126172721.9504-2-kerolasa@iki.fi>
In-Reply-To: <20171126172721.9504-1-kerolasa@iki.fi>
References: <20171126172721.9504-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/uuidgen.1 | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/misc-utils/uuidgen.1 b/misc-utils/uuidgen.1
index 4b0fcb60c..d5e1a5675 100644
--- a/misc-utils/uuidgen.1
+++ b/misc-utils/uuidgen.1
@@ -27,19 +27,19 @@ will generate a random-based UUID if a high-quality random number
 generator is present.  Otherwise, it will choose a time-based UUID.
 It is possible to force the generation of one of these first two
 UUID types by using the
-.B \-r
+.B \-\-random
 or
-.B \-t
+.B \-\-time
 options.
 .PP
 The third type of UUID is generated with the
-.B \-m
+.B \-\-md5
 or
-.B \-s
-options (MD5 or SHA1, respectively), followed by
-.BR "\-n " \fInamespace
+.B \-\-sha1
+options, followed by
+\fB\-\-namespace\fR \fInamespace\fR
 and
-.BR "\-N " \fIname\fR.
+\fB\-\-name\fR \fIname\fR.
 The \fInamespace\fR may either be a well-known UUID, or else
 an alias to one of the well-known UUIDs defined in RFC 4122, that is
 .BR @dns ,
@@ -89,6 +89,8 @@ Generate the hash of the \fIname\fR.
 Interpret name \fIname\fR as a hexidecimal string.
 .SH "CONFORMING TO"
 OSF DCE 1.1
+.SH EXAMPLES
+uuidgen \-\-sha1 \-\-namespace @dns \-\-name "www.example.com"
 .SH AUTHOR
 .B uuidgen
 was written by Andreas Dilger for libuuid.
-- 
2.15.0


Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753071AbdKXKbn (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 24 Nov 2017 05:31:43 -0500
From: Masatake YAMATO <yamato@redhat.com>
To: util-linux@vger.kernel.org
Cc: yamato@redhat.com
Subject: [PATCH v2 7/7] man: write about using multi-line in NSFS cell of lsns
Date: Fri, 24 Nov 2017 19:31:10 +0900
Message-Id: <20171124103110.17077-9-yamato@redhat.com>
In-Reply-To: <20171124103110.17077-1-yamato@redhat.com>
References: <20171124103110.17077-1-yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 sys-utils/lsns.8 | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sys-utils/lsns.8 b/sys-utils/lsns.8
index ebdc1df04..4d108a48c 100644
--- a/sys-utils/lsns.8
+++ b/sys-utils/lsns.8
@@ -20,6 +20,11 @@ avoid using default outputs in your scripts.  Always explicitly define expected
 columns by using the \fB\-\-output\fR option together with a columns list in
 environments where a stable output is required.
 
+\fBNSFS\fP column, printed when \fBnet\fP is specified for
+\fB\-\-type\fR option, is specifal; it uses multi-line cells.
+\fB\-\-nowrap\fR is for switching to "," separated single-line
+representation.
+
 Note that \fBlsns\fR reads information directly from the /proc filesystem and
 for non-root users it may return incomplete information.  The current /proc
 filesystem may be unshared and affected by a PID namespace
@@ -60,6 +65,9 @@ Display the specified \fItype\fP of namespaces only.  The supported types are
 .BR \-u , " \-\-notruncate"
 Do not truncate text in columns.
 .TP
+.BR \-W , " \-\-nowrap"
+Do not use multi-line text in columns.
+.TP
 .BR \-V , " \-\-version"
 Display version information and exit.
 .TP
-- 
2.13.6


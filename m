Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-ch2-06v.sys.comcast.net ([69.252.207.38]:57610 "EHLO
        resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753900AbdFWVim (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Jun 2017 17:38:42 -0400
From: "W. Trevor King" <wking@tremily.us>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 8/8] sys-utils/mount.8: Document libmount defaults
Date: Fri, 23 Jun 2017 14:30:26 -0700
Message-Id: <17bff7efa55b6ff4f04cf795de8b5d771cf43441.1498252231.git.wking@tremily.us>
In-Reply-To: <cover.1498252231.git.wking@tremily.us>
References: <cover.1498252231.git.wking@tremily.us>
In-Reply-To: <cover.1498252231.git.wking@tremily.us>
References: <cover.1498252231.git.wking@tremily.us>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

For filesystem-independent kernel options (e.g. rw/ro) we're punting
to mount(2).  But these libmount options dare only defined in
util-linux, so we need to document the defaults locally.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 sys-utils/mount.8 | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index a589f76..2b03cbe 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -1121,7 +1121,7 @@ Can be mounted with the
 .B \-a
 option (e.g., at boot time).
 .TP
-.B noauto
+.B noauto \fR(default)
 Can only be mounted explicitly (i.e., the
 .B \-a
 option will not cause the filesystem to be mounted).
@@ -1146,7 +1146,7 @@ This option implies the options
 (unless overridden by subsequent options, as in the option line
 .BR group,dev,suid ).
 .TP
-.B nogroup
+.B nogroup \fR(default)
 Unset \fBgroup\fR.
 .TP
 .B owner
@@ -1157,7 +1157,7 @@ This option implies the options
 (unless overridden by subsequent options, as in the option line
 .BR owner,dev,suid ).
 .TP
-.B noowner
+.B noowner \fR(default)
 Unset \fBowner\fR.
 .TP
 .B user
@@ -1170,7 +1170,7 @@ This option implies the options
 (unless overridden by subsequent options, as in the option line
 .BR user,exec,dev,suid ).
 .TP
-.B nouser
+.B nouser \fR(default)
 Unset \fBuser\fR.
 .TP
 .B users
@@ -1181,7 +1181,7 @@ This option implies the options
 (unless overridden by subsequent options, as in the option line
 .BR users,exec,dev,suid ).
 .TP
-.B nousers
+.B nousers \fR(default)
 Unset \fBusers\fR.
 .TP
 .B X-*
-- 
2.1.0.60.g85f0837


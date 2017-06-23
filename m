Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-ch2-03v.sys.comcast.net ([69.252.207.35]:59386 "EHLO
        resqmta-ch2-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753900AbdFWVik (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Jun 2017 17:38:40 -0400
From: "W. Trevor King" <wking@tremily.us>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 4/8] sys-utils/mount.8: Simplify nouser
Date: Fri, 23 Jun 2017 14:30:22 -0700
Message-Id: <2f9424002b9b0c3a570dd2cc54ad1ad3844960ef.1498252231.git.wking@tremily.us>
In-Reply-To: <cover.1498252231.git.wking@tremily.us>
References: <cover.1498252231.git.wking@tremily.us>
In-Reply-To: <cover.1498252231.git.wking@tremily.us>
References: <cover.1498252231.git.wking@tremily.us>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Don't try to explain how this happens in isolation, since "unsets any
previous user option", is sufficient.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 sys-utils/mount.8 | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 26e6ce0..d20e35d 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -1158,8 +1158,7 @@ This option implies the options
 .BR user,exec,dev,suid ).
 .TP
 .B nouser
-Forbid an ordinary user to mount the filesystem.
-This is the default; it does not imply any other options.
+Unset \fBuser\fR.
 .TP
 .B users
 Allow any user to mount and to unmount the filesystem, even
-- 
2.1.0.60.g85f0837


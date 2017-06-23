Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-ch2-06v.sys.comcast.net ([69.252.207.38]:57126 "EHLO
        resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754558AbdFWVhX (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Jun 2017 17:37:23 -0400
From: "W. Trevor King" <wking@tremily.us>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 6/8] sys-utils/mount.8: Clarify x-mount.mkdir deprecation
Date: Fri, 23 Jun 2017 14:30:24 -0700
Message-Id: <577835f6ef07d05e37c5886d5e9cb2efd88192cf.1498252231.git.wking@tremily.us>
In-Reply-To: <cover.1498252231.git.wking@tremily.us>
References: <cover.1498252231.git.wking@tremily.us>
In-Reply-To: <cover.1498252231.git.wking@tremily.us>
References: <cover.1498252231.git.wking@tremily.us>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The old wording seemed less clear about whether both X- and x- forms
of mount.mkdir were deprecated.  Also:

* Bold x-mount.mkdir so it matches the markup for X-mount.mkdir.
* Prefix "v2.30" with "util-linux" to match the other util-linux
  version references in this man page.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 sys-utils/mount.8 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 2bcb12a..d5ca65e 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -1192,8 +1192,9 @@ Allow to make a target directory (mountpoint).  The optional argument
 specifies the filesystem access mode used for
 .BR mkdir (2)
 in octal notation.  The default mode is 0755.  This functionality is supported
-only for root users.  The option is also supported as x-mount.mkdir, this notation
-is deprecated for mount.mkdir since v2.30.
+only for root users.  The option is also supported as
+.B x-mount.mkdir\fR,
+but that notation is deprecated since util-linux v2.30.
 
 .SH "FILESYSTEM-SPECIFIC MOUNT OPTIONS"
 The following options apply only to certain filesystems.
-- 
2.1.0.60.g85f0837


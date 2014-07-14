Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:56462 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756387AbaGNUxw (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Jul 2014 16:53:52 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/3] docs: mount -o nouser is not useful, be clearer about that
Date: Mon, 14 Jul 2014 22:53:35 +0200
Message-Id: <1405371216-7774-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1405371216-7774-1-git-send-email-bensberg@justemail.net>
References: <1405371216-7774-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/mount.8 |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index fc8225a..ae29ea8 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -858,7 +858,7 @@ flag followed by a comma separated string of options. For example:
 .RS
 .RS
 .sp
-.B "mount LABEL=mydisk \-o noatime,nouser"
+.B "mount LABEL=mydisk \-o noatime,nodev,nosuid"
 .sp
 .RE
 
@@ -1158,7 +1158,7 @@ This option implies the options
 .TP
 .B nouser
 Forbid an ordinary (i.e., non-root) user to mount the filesystem.
-This is the default.
+This is the default; it does not imply any other options.
 .TP
 .B users
 Allow every user to mount and unmount the filesystem.
-- 
1.7.0.4


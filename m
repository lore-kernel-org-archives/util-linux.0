Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:59027 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932159AbcCHJVc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 8 Mar 2016 04:21:32 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/9] mount: hardwrap an overlong example in the man page
Date: Tue,  8 Mar 2016 10:07:48 +0100
Message-Id: <1457428072-2619-5-git-send-email-bensberg@justemail.net>
In-Reply-To: <1457428072-2619-1-git-send-email-bensberg@justemail.net>
References: <1457428072-2619-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/mount.8 |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 46c934a..1903253 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -2410,7 +2410,10 @@ directory by using:
 
 .RS
 .br
-.BR "mount \-t overlay overlay \-olowerdir=/lower,upperdir=/upper,workdir=/work  /merged"
+.nf
+.B "mount \-t overlay  overlay  \e"
+.B "  \-olowerdir=/lower,upperdir=/upper,workdir=/work  /merged"
+.fi
 .br
 .RE
 
-- 
1.7.0.4


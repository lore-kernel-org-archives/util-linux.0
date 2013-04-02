Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f47.google.com ([74.125.82.47]:35460 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760521Ab3DBTnF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Apr 2013 15:43:05 -0400
Received: by mail-wg0-f47.google.com with SMTP id y10so835160wgg.26
        for <util-linux@vger.kernel.org>; Tue, 02 Apr 2013 12:43:04 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 01/13] docs: fix type in mkfs.8
Date: Tue,  2 Apr 2013 20:42:45 +0100
Message-Id: <1364931777-2645-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
References: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkfs.8 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/disk-utils/mkfs.8 b/disk-utils/mkfs.8
index a4cdf71..4bc45ff 100644
--- a/disk-utils/mkfs.8
+++ b/disk-utils/mkfs.8
@@ -3,7 +3,6 @@
 .SH NAME
 mkfs \- build a Linux filesystem
 .SH SYNOPSIS
-.SH SYNOPSIS
 .B mkfs
 .RI [ options ]
 .RB [ \-t
-- 
1.8.2


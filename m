Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f171.google.com ([74.125.82.171]:65249 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab3HQSP5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 17 Aug 2013 14:15:57 -0400
Received: by mail-we0-f171.google.com with SMTP id q55so2591273wes.2
        for <util-linux@vger.kernel.org>; Sat, 17 Aug 2013 11:15:56 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/16] build-sys: complete elvtune removal
Date: Sat, 17 Aug 2013 19:15:08 +0100
Message-Id: <1376763321-22782-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
References: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The first removal managed to remove only most of the elvtune, this commit
will complete the task.

Original-removal: 7f1fe74248290c50f5447c2c09fcf0f0575a7666
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 .gitignore                   | 1 -
 Documentation/deprecated.txt | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/.gitignore b/.gitignore
index deda9a5..74f0ff1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -84,7 +84,6 @@ tests/run.sh.trs
 /delpart
 /dmesg
 /eject
-/elvtune
 /fallocate
 /fdformat
 /fdisk
diff --git a/Documentation/deprecated.txt b/Documentation/deprecated.txt
index 1266957..f78965c 100644
--- a/Documentation/deprecated.txt
+++ b/Documentation/deprecated.txt
@@ -51,11 +51,6 @@ Why:	parallel port printers are probably almost extinct devices
 
 --------------------------
 
-What:	elvtune
-Why:	useless for kernel >= 2.6.9
-
----------------------------
-
 What:	last(1)
 Why:	nobody uses this implementation
 
-- 
1.8.3.4


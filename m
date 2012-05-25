Return-Path: util-linux-owner@vger.kernel.org
Received: from relay1.mentorg.com ([192.94.38.131]:55104 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab2EYSl1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 25 May 2012 14:41:27 -0400
From: Thomas Schwinge <thomas@codesourcery.com>
To: util-linux@vger.kernel.org, ludwig.nussel@suse.de
Cc: Thomas Schwinge <thomas@codesourcery.com>
Subject: [PATCH 3/3] su: Mention SUID_* feature.
Date: Fri, 25 May 2012 20:41:01 +0200
Message-Id: <1337971261-20684-4-git-send-email-thomas@codesourcery.com>
In-Reply-To: <1337971261-20684-1-git-send-email-thomas@codesourcery.com>
References: <87zk8wboif.fsf@schwinge.name>
 <1337971261-20684-1-git-send-email-thomas@codesourcery.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
---
 Documentation/howto-compilation.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/howto-compilation.txt b/Documentation/howto-compilation.txt
index 3617b34..bebe0d2 100644
--- a/Documentation/howto-compilation.txt
+++ b/Documentation/howto-compilation.txt
@@ -25,7 +25,7 @@ Compiling
 	./configure SUID_CFLAGS="-fpie" SUID_LDFLAGS="-pie"
 
 	The SUID_* feature is currently supported for chfn, chsh,
-	newgrp, write, mount, and umount.
+	newgrp, su, write, mount, and umount.
 
 	Preferred compilation options for developers, when
 	using gcc, are:
-- 
1.7.9


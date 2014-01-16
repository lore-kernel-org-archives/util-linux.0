Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bk0-f47.google.com ([209.85.214.47]:62047 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbaAPAGr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 15 Jan 2014 19:06:47 -0500
Received: by mail-bk0-f47.google.com with SMTP id mx12so941204bkb.6
        for <util-linux@vger.kernel.org>; Wed, 15 Jan 2014 16:06:46 -0800 (PST)
From: Wieland Hoffmann <themineo@gmail.com>
To: util-linux@vger.kernel.org
Cc: Wieland Hoffmann <themineo@gmail.com>
Subject: [PATCH] flock.1: Change the 'exit status' section to make more sense
Date: Thu, 16 Jan 2014 01:06:32 +0100
Message-Id: <1389830792-12240-1-git-send-email-themineo@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Wieland Hoffmann <themineo@gmail.com>
---
 sys-utils/flock.1 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/flock.1 b/sys-utils/flock.1
index d9f7d86..99ae682 100644
--- a/sys-utils/flock.1
+++ b/sys-utils/flock.1
@@ -152,11 +152,11 @@ also sets the FLOCKER env var to the right value so it doesn't run again.
 .SH "EXIT STATUS"
 The command uses
 .B sysexits.h
-return values for everything else but an options
+return values for everything, except when using either of the options
 .I \-n
 or
 .I \-w
-failures which return either the value given by the
+which report a failure to acquire the lock with a return value given by the
 .I \-E
 option, or 1 by default.
 .SH AUTHOR
-- 
1.8.5.2


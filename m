Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:62198 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935672Ab3DHTeK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Apr 2013 15:34:10 -0400
Received: by mail-wi0-f181.google.com with SMTP id hj8so2937297wib.14
        for <util-linux@vger.kernel.org>; Mon, 08 Apr 2013 12:34:08 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 11/14] docs: remove repeated words [checkmans.sh]
Date: Mon,  8 Apr 2013 20:32:56 +0100
Message-Id: <1365449579-13238-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
References: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/elvtune.8        | 2 +-
 libuuid/man/uuid_generate.3 | 2 +-
 sys-utils/cytune.8          | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/disk-utils/elvtune.8 b/disk-utils/elvtune.8
index f71b1d4..0554269 100644
--- a/disk-utils/elvtune.8
+++ b/disk-utils/elvtune.8
@@ -45,7 +45,7 @@ pending in the queue.
 Display help text and exit.
 .TP
 .BI -v
-Display version version information and exit.
+Display version information and exit.
 .SH NOTE
 Actually, the only fields tunable are those relative
 to the IO scheduler.  It's not possible to select
diff --git a/libuuid/man/uuid_generate.3 b/libuuid/man/uuid_generate.3
index 07ad94c..3bb789c 100644
--- a/libuuid/man/uuid_generate.3
+++ b/libuuid/man/uuid_generate.3
@@ -79,7 +79,7 @@ by concurrently running processes, the uuid library uses global
 clock state counter (if the process has permissions to gain exclusive access
 to this file) and/or the
 .B uuidd
-daemon, if it is running already or can be be spawned by the process (if
+daemon, if it is running already or can be spawned by the process (if
 installed and the process has enough permissions to run it).  If neither of
 these two synchronization mechanisms can be used, it is theoretically possible
 that two concurrently running processes obtain the same UUID(s).  To tell
diff --git a/sys-utils/cytune.8 b/sys-utils/cytune.8
index fd82391..940fa28 100644
--- a/sys-utils/cytune.8
+++ b/sys-utils/cytune.8
@@ -154,7 +154,7 @@ units.  When the
 .I tty
 is next opened, this value will be used instead of the default.  If
 .I value
-is zero, then the the value will default to 0x20 (160ms), soon to be 0x02
+is zero, then the value will default to 0x20 (160ms), soon to be 0x02
 (10ms).
 .TP
 \fB\-G\fR, \fB\-\-get\-glush\fR
-- 
1.8.2.1


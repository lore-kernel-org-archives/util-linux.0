Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54541 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758785Ab2FULUt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 21 Jun 2012 07:20:49 -0400
From: Zheng Liu <gnehzuil.liu@gmail.com>
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        util-linux@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Rob Landley <rob@landley.net>,
        Bernhard Voelker <mail@bernhard-voelker.de>,
        Sami Kerola <kerolasa@iki.fi>, Karel Zak <kzak@redhat.com>,
        Zheng Liu <wenqing.lz@taobao.com>
Subject: [PATCH v2] docs: block: update ioprio.txt
Date: Thu, 21 Jun 2012 19:28:29 +0800
Message-Id: <1340278109-18761-1-git-send-email-wenqing.lz@taobao.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Zheng Liu <wenqing.lz@taobao.com>

The ionice.c in ioprio.txt document needed updating for the latest util-linux
version.

CC: Jens Axboe <axboe@kernel.dk>
CC: Rob Landley <rob@landley.net>
CC: Bernhard Voelker <mail@bernhard-voelker.de>
CC: Sami Kerola <kerolasa@iki.fi>
CC: Karel Zak <kzak@redhat.com>
Signed-off-by: Zheng Liu <wenqing.lz@taobao.com>
---
Hi Rob,

Could you please review this patch again?  I only fix the reference code
according to your feedback.

Regards,
Zheng

 Documentation/block/ioprio.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/block/ioprio.txt b/Documentation/block/ioprio.txt
index 8ed8c59..55970a1 100644
--- a/Documentation/block/ioprio.txt
+++ b/Documentation/block/ioprio.txt
@@ -136,7 +136,7 @@ int main(int argc, char *argv[])
 
 	switch (ioprio_class) {
 		case IOPRIO_CLASS_NONE:
-			ioprio_class = IOPRIO_CLASS_BE;
+			ioprio = 0;
 			break;
 		case IOPRIO_CLASS_RT:
 		case IOPRIO_CLASS_BE:
-- 
1.7.4.1


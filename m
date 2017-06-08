Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36432 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751675AbdFHTwf (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 8 Jun 2017 15:52:35 -0400
Received: by mail-wr0-f194.google.com with SMTP id e23so4713499wre.3
        for <util-linux@vger.kernel.org>; Thu, 08 Jun 2017 12:52:30 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 08/11] losetup: add missing initializer [clang]
Date: Thu,  8 Jun 2017 20:52:12 +0100
Message-Id: <20170608195215.1702-9-kerolasa@iki.fi>
In-Reply-To: <20170608195215.1702-1-kerolasa@iki.fi>
References: <20170608195215.1702-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

FIXME: I am not entirely sure if rc should be initialized to 1 or 0.

sys-utils/losetup.c:290:12: warning: variable 'rc' is used uninitialized
	whenever 'if' condition is false [-Wsometimes-uninitialized]
sys-utils/losetup.c:293:7: note: uninitialized use occurs here
sys-utils/losetup.c:290:8: note: remove the 'if' if its condition is always true
sys-utils/losetup.c:228:9: note: initialize the variable 'rc' to silence
	this warning

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/losetup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index e0676c9fd..8ed9a1e4b 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -225,7 +225,7 @@ static int set_scols_data(struct loopdev_cxt *lc, struct libscols_line *ln)
 		const char *p = NULL;			/* external data */
 		char *np = NULL;			/* allocated here */
 		uint64_t x = 0;
-		int rc;
+		int rc = 0;
 
 		switch(get_column_id(i)) {
 		case COL_NAME:
-- 
2.13.1


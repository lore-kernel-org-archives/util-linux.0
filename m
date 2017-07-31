Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36728 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbdGaTzV (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 31 Jul 2017 15:55:21 -0400
Received: by mail-wr0-f193.google.com with SMTP id y67so31617159wrb.3
        for <util-linux@vger.kernel.org>; Mon, 31 Jul 2017 12:55:21 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 4/9] uuidparse: nil uuid have all bits set to zero
Date: Mon, 31 Jul 2017 20:55:03 +0100
Message-Id: <20170731195508.11661-5-kerolasa@iki.fi>
In-Reply-To: <20170731195508.11661-1-kerolasa@iki.fi>
References: <20170731195508.11661-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The nil UUID is special form of UUID that is specified to have all 128 bits
set to zero.

Reference: https://tools.ietf.org/html/rfc4122#section-4.1.7
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/uuidparse.c        | 5 ++++-
 tests/expected/uuid/uuidparse | 6 +++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/misc-utils/uuidparse.c b/misc-utils/uuidparse.c
index 49225ae2c..5fa34b23d 100644
--- a/misc-utils/uuidparse.c
+++ b/misc-utils/uuidparse.c
@@ -195,7 +195,10 @@ static void fill_table_row(struct libscols_table *tb, char const *const uuid)
 			}
 			switch (type) {
 			case 0:
-				str = xstrdup(_("nil"));
+				if (strspn(uuid, "0-") == 36)
+					str = xstrdup(_("nil"));
+				else
+					str = xstrdup(_("unknown"));
 				break;
 			case 1:
 				str = xstrdup(_("time-based"));
diff --git a/tests/expected/uuid/uuidparse b/tests/expected/uuid/uuidparse
index 7fc64bcd2..c4959be8d 100644
--- a/tests/expected/uuid/uuidparse
+++ b/tests/expected/uuid/uuidparse
@@ -6,20 +6,20 @@ UUID                                  VARIANT   TYPE       TIME
 00000000-0000-4000-0000-000000000000  NCS       random     
 00000000-0000-5000-0000-000000000000  NCS       sha1-based 
 00000000-0000-6000-0000-000000000000  NCS       unknown    
-00000000-0000-0000-8000-000000000000  DCE       nil        
+00000000-0000-0000-8000-000000000000  DCE       unknown    
 00000000-0000-2000-8000-000000000000  DCE       DCE        
 00000000-0000-3000-8000-000000000000  DCE       name-based 
 00000000-0000-4000-8000-000000000000  DCE       random     
 00000000-0000-5000-8000-000000000000  DCE       sha1-based 
 00000000-0000-6000-8000-000000000000  DCE       unknown    
-00000000-0000-0000-d000-000000000000  Microsoft nil        
+00000000-0000-0000-d000-000000000000  Microsoft unknown    
 00000000-0000-1000-d000-000000000000  Microsoft time-based 
 00000000-0000-2000-d000-000000000000  Microsoft DCE        
 00000000-0000-3000-d000-000000000000  Microsoft name-based 
 00000000-0000-4000-d000-000000000000  Microsoft random     
 00000000-0000-5000-d000-000000000000  Microsoft sha1-based 
 00000000-0000-6000-d000-000000000000  Microsoft unknown    
-00000000-0000-0000-f000-000000000000  other     nil        
+00000000-0000-0000-f000-000000000000  other     unknown    
 00000000-0000-1000-f000-000000000000  other     time-based 
 00000000-0000-2000-f000-000000000000  other     DCE        
 00000000-0000-3000-f000-000000000000  other     name-based 
-- 
2.13.3


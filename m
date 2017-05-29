Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36536 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbdE2SuR (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 29 May 2017 14:50:17 -0400
Received: by mail-lf0-f66.google.com with SMTP id h4so7029705lfj.3
        for <util-linux@vger.kernel.org>; Mon, 29 May 2017 11:50:16 -0700 (PDT)
From: Alexander Kuleshov <kuleshovmail@gmail.com>
To: util-linux@vger.kernel.org
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] column: add missed semicolons in case of !HAVE_WIDECHAR
Date: Tue, 30 May 2017 00:49:17 +0600
Message-Id: <20170529184917.18559-1-kuleshovmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In other case we will get:

  error: expected ‘;’ before ‘}’ token

error.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 text-utils/column.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/text-utils/column.c b/text-utils/column.c
index 421823d..c315f91 100644
--- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -129,7 +129,7 @@ static wchar_t *mbs_to_wcs(const char *s)
 	}
 	return wcs;
 #else
-	return xstrdup(s)
+	return xstrdup(s);
 #endif
 }
 
@@ -150,7 +150,7 @@ static char *wcs_to_mbs(const wchar_t *s)
 	}
 	return str;
 #else
-	return xstrdup(s)
+	return xstrdup(s);
 #endif
 }
 
-- 
2.9.4


Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38865 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbdIUOXh (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 21 Sep 2017 10:23:37 -0400
Received: by mail-pg0-f65.google.com with SMTP id m30so3509105pgn.5
        for <util-linux@vger.kernel.org>; Thu, 21 Sep 2017 07:23:37 -0700 (PDT)
From: Masanari Iida <standby24x7@gmail.com>
To: translation-team-ja@lists.sourceforge.net,
        hmatrjp@users.sourceforge.jp
Cc: util-linux@vger.kernel.org, Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH 2/2] po: Fix translation in ja.po
Date: Thu, 21 Sep 2017 23:23:25 +0900
Message-Id: <20170921142325.1825-2-standby24x7@gmail.com>
In-Reply-To: <20170921142325.1825-1-standby24x7@gmail.com>
References: <20170921142325.1825-1-standby24x7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

English message and Japanese translation are unmatch.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 po/ja.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/ja.po b/po/ja.po
index 9b8dc587d860..ee25823d941b 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -3060,7 +3060,7 @@ msgstr " -C, --cylinders <数値>        シリンダ数を指定します\n"
 #: disk-utils/mkfs.minix.c:145
 #, fuzzy
 msgid " -c, --check             check the device for bad blocks\n"
-msgstr " -u, --unlock             ロックを解除します\n"
+msgstr " -c, --check            デバイスの不良ブロックを調べます\n"
 
 #: disk-utils/mkfs.minix.c:146
 msgid " -l, --badblocks <file>  list of bad blocks from file\n"
-- 
2.14.1.459.g238e487ea943


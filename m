Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33088 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbdIUOXg (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 21 Sep 2017 10:23:36 -0400
Received: by mail-pg0-f66.google.com with SMTP id i130so3523872pgc.0
        for <util-linux@vger.kernel.org>; Thu, 21 Sep 2017 07:23:36 -0700 (PDT)
From: Masanari Iida <standby24x7@gmail.com>
To: translation-team-ja@lists.sourceforge.net,
        hmatrjp@users.sourceforge.jp
Cc: util-linux@vger.kernel.org, Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH 1/2] po:Fix a typo
Date: Thu, 21 Sep 2017 23:23:24 +0900
Message-Id: <20170921142325.1825-1-standby24x7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 po/ja.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/ja.po b/po/ja.po
index e3bae1fd079c..9b8dc587d860 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -2275,7 +2275,7 @@ msgstr "ファイル `%s' 内で Zone nr が FIRSTZONE より小さくなって
 #: disk-utils/fsck.minix.c:322 disk-utils/fsck.minix.c:343
 #, c-format
 msgid "Zone nr >= ZONES in file `%s'."
-msgstr "ファイル `%s' 内で Zone nr が ZONES と久しいか、より大きくなっています。"
+msgstr "ファイル `%s' 内で Zone nr が ZONES と等しいか、より大きくなっています。"
 
 #: disk-utils/fsck.minix.c:326 disk-utils/fsck.minix.c:347
 msgid "Remove block"
-- 
2.14.1.459.g238e487ea943


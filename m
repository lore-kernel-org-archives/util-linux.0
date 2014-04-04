Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f45.google.com ([209.85.160.45]:39413 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbaDDNIa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 4 Apr 2014 09:08:30 -0400
Received: by mail-pb0-f45.google.com with SMTP id uo5so3434853pbc.4
        for <util-linux@vger.kernel.org>; Fri, 04 Apr 2014 06:08:30 -0700 (PDT)
From: Jonathan Liu <net147@gmail.com>
To: util-linux@vger.kernel.org
Cc: Jonathan Liu <net147@gmail.com>
Subject: [PATCH v2] umount: fix typo in usage
Date: Sat,  5 Apr 2014 00:14:59 +1100
Message-Id: <1396617299-32123-1-git-send-email-net147@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 po/ca.po           | 2 +-
 po/cs.po           | 2 +-
 po/da.po           | 2 +-
 po/de.po           | 2 +-
 po/es.po           | 2 +-
 po/et.po           | 2 +-
 po/eu.po           | 2 +-
 po/fi.po           | 2 +-
 po/fr.po           | 3 +--
 po/gl.po           | 2 +-
 po/hr.po           | 2 +-
 po/hu.po           | 2 +-
 po/id.po           | 2 +-
 po/it.po           | 2 +-
 po/ja.po           | 2 +-
 po/nl.po           | 2 +-
 po/pl.po           | 2 +-
 po/pt_BR.po        | 2 +-
 po/ru.po           | 2 +-
 po/sl.po           | 2 +-
 po/sv.po           | 2 +-
 po/tr.po           | 2 +-
 po/uk.po           | 2 +-
 po/util-linux.pot  | 2 +-
 po/vi.po           | 2 +-
 po/zh_CN.po        | 2 +-
 po/zh_TW.po        | 2 +-
 sys-utils/umount.c | 2 +-
 28 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/po/ca.po b/po/ca.po
index e38952b..c2e9ef3 100644
--- a/po/ca.po
+++ b/po/ca.po
@@ -16350,7 +16350,7 @@ msgstr "  -h, --help                   Aquesta petita guia d'ús\n"
 
 #: sys-utils/umount.c:83
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 
diff --git a/po/cs.po b/po/cs.po
index 3f6d6ad..869b66c 100644
--- a/po/cs.po
+++ b/po/cs.po
@@ -16222,7 +16222,7 @@ msgstr " -a, --all               odpojí všechny souborové systémy\n"
 
 #: sys-utils/umount.c:83
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 " -A, --all-targets       odpojí všechny body přípojení pro zadané zařízení\n"
diff --git a/po/da.po b/po/da.po
index 6a8bf03..c397316 100644
--- a/po/da.po
+++ b/po/da.po
@@ -16034,7 +16034,7 @@ msgstr "  -h, --help                   Denne lille manual\n"
 
 #: sys-utils/umount.c:83
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 
diff --git a/po/de.po b/po/de.po
index aa9ad55..6a82044 100644
--- a/po/de.po
+++ b/po/de.po
@@ -16477,7 +16477,7 @@ msgstr "  -h, --help                 dieser kleine Hilfe\n"
 
 #: sys-utils/umount.c:83
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 
diff --git a/po/es.po b/po/es.po
index d00ba85..460694e 100644
--- a/po/es.po
+++ b/po/es.po
@@ -16336,7 +16336,7 @@ msgstr "  -h, --help                   Esta peque
 
 #: sys-utils/umount.c:83
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 
diff --git a/po/et.po b/po/et.po
index 995a189..0230177 100644
--- a/po/et.po
+++ b/po/et.po
@@ -15903,7 +15903,7 @@ msgstr ""
 
 #: sys-utils/umount.c:83
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 
diff --git a/po/eu.po b/po/eu.po
index ce11f82..5535f9f 100644
--- a/po/eu.po
+++ b/po/eu.po
@@ -15717,7 +15717,7 @@ msgstr ""
 
 #: sys-utils/umount.c:83
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 
diff --git a/po/fi.po b/po/fi.po
index 2854abe..f510663 100644
--- a/po/fi.po
+++ b/po/fi.po
@@ -16167,7 +16167,7 @@ msgstr "  -h, --help                   Tämä pieni käyttöopas\n"
 
 #: sys-utils/umount.c:83
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 
diff --git a/po/fr.po b/po/fr.po
index 25497b2..0663400 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -16520,10 +16520,9 @@ msgstr ""
 msgid " -a, --all               unmount all filesystems\n"
 msgstr " -a, --all               démonter tous les systèmes de fichiers\n"
 
-# NOTE: s/mountpoins/mountpoints/
 #: sys-utils/umount.c:83
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 " -A, --all-targets       démonter tous les points de montage pour le\n"
diff --git a/po/gl.po b/po/gl.po
index 05c2948..ab24315 100644
--- a/po/gl.po
+++ b/po/gl.po
@@ -15429,7 +15429,7 @@ msgstr ""
 
 #: sys-utils/umount.c:83
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 
diff --git a/po/hr.po b/po/hr.po
index 21bbc5e..52efeb9 100644
--- a/po/hr.po
+++ b/po/hr.po
@@ -15124,7 +15124,7 @@ msgstr ""
 
 #: sys-utils/umount.c:83
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 
diff --git a/po/hu.po b/po/hu.po
index 90338f9..5a7230f 100644
--- a/po/hu.po
+++ b/po/hu.po
@@ -16339,7 +16339,7 @@ msgstr "  -h, --help                       Ez a súgószöveg\n"
 
 #: sys-utils/umount.c:83
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 
diff --git a/po/id.po b/po/id.po
index ccf1751..116d350 100644
--- a/po/id.po
+++ b/po/id.po
@@ -16369,7 +16369,7 @@ msgstr "  -h, --help                   Ini sedikit petunjuk penggunaan\n"
 
 #: sys-utils/umount.c:83
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 
diff --git a/po/it.po b/po/it.po
index 969fbe0..f55e9dd 100644
--- a/po/it.po
+++ b/po/it.po
@@ -16243,7 +16243,7 @@ msgstr "  -h, --help                   Questa piccola guida all'utilizzo\n"
 
 #: sys-utils/umount.c:83
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 
diff --git a/po/ja.po b/po/ja.po
index 6d08ab5..6e7b986 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -16220,7 +16220,7 @@ msgstr "  -h, --help                   このちょっとした使い方を表
 
 #: sys-utils/umount.c:83
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 
diff --git a/po/nl.po b/po/nl.po
index 26c7276..10bfef6 100644
--- a/po/nl.po
+++ b/po/nl.po
@@ -16159,7 +16159,7 @@ msgstr "  -a, --all                 alle bestandssystemen afkoppelen\n"
 
 #: sys-utils/umount.c:83
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 "  -A, --all-targets         alle aankoppelingspunten van gegeven apparaat\n"
diff --git a/po/pl.po b/po/pl.po
index 26b53ef..d8f03c2 100644
--- a/po/pl.po
+++ b/po/pl.po
@@ -16200,7 +16200,7 @@ msgstr " -a, --all               odmontowanie wszystkich systemów plików\n"
 
 #: sys-utils/umount.c:83
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 " -A, --all-targets       odmontowanie wszystkich punktów montowania dla\n"
diff --git a/po/pt_BR.po b/po/pt_BR.po
index ed9207d..73c2d9e 100644
--- a/po/pt_BR.po
+++ b/po/pt_BR.po
@@ -16331,7 +16331,7 @@ msgstr " -A         verifica todos os sistemas de arquivos\n"
 
 #: sys-utils/umount.c:83
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 
diff --git a/po/ru.po b/po/ru.po
index 79b0c00..7d36d7a 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -16303,7 +16303,7 @@ msgstr ""
 
 #: sys-utils/umount.c:83
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 
diff --git a/po/sl.po b/po/sl.po
index 5b1113b..b74ba4a 100644
--- a/po/sl.po
+++ b/po/sl.po
@@ -16200,7 +16200,7 @@ msgstr "  -h  --help                   Manj
 
 #: sys-utils/umount.c:83
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 
diff --git a/po/sv.po b/po/sv.po
index 4bf594d..124ff78 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -16248,7 +16248,7 @@ msgstr "  -h, --help                   Denna enkla användningsguide\n"
 
 #: sys-utils/umount.c:83
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 
diff --git a/po/tr.po b/po/tr.po
index 92c6e13..0db6441 100644
--- a/po/tr.po
+++ b/po/tr.po
@@ -16256,7 +16256,7 @@ msgstr "  -h, --help                    Bu yardım iletisini gösterir\n"
 
 #: sys-utils/umount.c:83
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 
diff --git a/po/uk.po b/po/uk.po
index ac6c90f..f27c736 100644
--- a/po/uk.po
+++ b/po/uk.po
@@ -16418,7 +16418,7 @@ msgstr " -a, --all               демонтувати всі файлові с
 
 #: sys-utils/umount.c:83
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 " -A, --all-targets       демонтувати всі точки монтування вказаного "
diff --git a/po/util-linux.pot b/po/util-linux.pot
index b577d84..f149ed9 100644
--- a/po/util-linux.pot
+++ b/po/util-linux.pot
@@ -14968,7 +14968,7 @@ msgstr ""
 
 #: sys-utils/umount.c:83
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 
diff --git a/po/vi.po b/po/vi.po
index 85e689d..848f4d9 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -16145,7 +16145,7 @@ msgstr " -a, --all               bỏ gắn tất cả các hệ thống tập t
 
 #: sys-utils/umount.c:83
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 " -A, --all-targets       bỏ gắn mọi điểm gắn cho thiết bị đã cho\n"
diff --git a/po/zh_CN.po b/po/zh_CN.po
index f649381..00b379a 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -15735,7 +15735,7 @@ msgstr " -a, --all               卸载所有文件系统\n"
 #: sys-utils/umount.c:83
 #, fuzzy
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 " -A, --all-targets       卸载当前名字空间内指定设备\n"
diff --git a/po/zh_TW.po b/po/zh_TW.po
index 4a546be..9b4ac6d 100644
--- a/po/zh_TW.po
+++ b/po/zh_TW.po
@@ -16824,7 +16824,7 @@ msgstr " -a, --all                 列印所有符號，即使計數是 0\n"
 
 #: sys-utils/umount.c:83
 msgid ""
-" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 "                           current namespace\n"
 msgstr ""
 
diff --git a/sys-utils/umount.c b/sys-utils/umount.c
index fe120db..f3bac0f 100644
--- a/sys-utils/umount.c
+++ b/sys-utils/umount.c
@@ -80,7 +80,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -a, --all               unmount all filesystems\n"), out);
-	fputs(_(" -A, --all-targets       unmount all mountpoins for the given device in the\n"
+	fputs(_(" -A, --all-targets       unmount all mountpoints for the given device in the\n"
 	        "                           current namespace\n"), out);
 	fputs(_(" -c, --no-canonicalize   don't canonicalize paths\n"), out);
 	fputs(_(" -d, --detach-loop       if mounted loop device, also free this loop device\n"), out);
-- 
1.9.0


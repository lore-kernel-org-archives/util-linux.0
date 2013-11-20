Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f52.google.com ([209.85.220.52]:54288 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152Ab3KTA5P (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 19 Nov 2013 19:57:15 -0500
Received: by mail-pa0-f52.google.com with SMTP id ld10so4558353pab.25
        for <util-linux@vger.kernel.org>; Tue, 19 Nov 2013 16:57:14 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/2] namei: align missing files with rest of the print out
Date: Wed, 20 Nov 2013 00:57:04 +0000
Message-Id: <1384909024-562-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1384909024-562-1-git-send-email-kerolasa@iki.fi>
References: <1384909024-562-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This change should make namei output more readable when multiple
arguments are supplied.

The old:

$ namei -l /usr/foo
f: /usr/foo
drwxr-xr-x root root /
drwxr-xr-x root root usr
foo - No such file or directory

The new:

$ namei -l /usr/foo
f: /usr/foo
drwxr-xr-x root root /
drwxr-xr-x root root usr
                     foo - No such file or directory

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/namei.c         | 9 +++++++++
 tests/expected/namei/logic | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/misc-utils/namei.c b/misc-utils/namei.c
index a9c8301..1152ea7 100644
--- a/misc-utils/namei.c
+++ b/misc-utils/namei.c
@@ -367,6 +367,15 @@ print_namei(struct namei *nm, char *path)
 		char md[11];
 
 		if (nm->noent) {
+			int blanks = 1;
+			if (flags & NAMEI_MODES)
+				blanks += 9;
+			if (flags & NAMEI_OWNERS)
+				blanks += uwidth + gwidth + 2;
+			if (!(flags & NAMEI_VERTICAL))
+				blanks += 1;
+			blanks += nm->level * 2;
+			printf("%*s ", blanks, "");
 			printf(_("%s - No such file or directory\n"), nm->name);
 			return -1;
 		}
diff --git a/tests/expected/namei/logic b/tests/expected/namei/logic
index 9632db0..8e217d9 100644
--- a/tests/expected/namei/logic
+++ b/tests/expected/namei/logic
@@ -10,4 +10,4 @@ f: namei1/namei2/a/b
  d namei1
  d namei2
  - a
-b - No such file or directory
+   b - No such file or directory
-- 
1.8.4.2


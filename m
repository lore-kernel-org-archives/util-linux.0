Return-Path: util-linux-owner@vger.kernel.org
Received: from c-83-233-174-181.cust.bredband2.com ([83.233.174.181]:48218
	"EHLO pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbbFVQXN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Jun 2015 12:23:13 -0400
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas.henriksson@endian.se>,
        Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] rename: allow full-path renames
Date: Mon, 22 Jun 2015 18:23:05 +0200
Message-Id: <1434990185-19883-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Andreas Henriksson <andreas.henriksson@endian.se>

The command "touch b0;rename.ul -v ./b0 ./b1 ./b0" used to work
before "allow renaming in subdirectories" change.
(regression in commit bd9ced628bb86)

Addresses: https://bugs.debian.org/789240
Reported-by: gregrwm <bug-grub@whitleymott.net>
Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 misc-utils/rename.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/misc-utils/rename.c b/misc-utils/rename.c
index 7ac068d..c8a4f8c 100644
--- a/misc-utils/rename.c
+++ b/misc-utils/rename.c
@@ -92,10 +92,11 @@ static int do_symlink(char *from, char *to, char *s, int verbose)
 
 static int do_file(char *from, char *to, char *s, int verbose)
 {
-	char *newname = NULL, *file;
+	char *newname = NULL, *file=NULL;
 	int ret = 1;
 
-	file = strrchr(s, '/');
+	if (strchr(from, '/') == NULL && strchr(to, '/') == NULL)
+		file = strrchr(s, '/');
 	if (file == NULL)
 		file = s;
 	if (string_replace(from, to, file, s, &newname))
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe util-linux" in

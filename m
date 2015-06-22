Return-Path: util-linux-owner@vger.kernel.org
Received: from c-83-233-174-181.cust.bredband2.com ([83.233.174.181]:48227
	"EHLO pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932159AbbFVR0j (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Jun 2015 13:26:39 -0400
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>, Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH v2] rename: allow full-path renames
Date: Mon, 22 Jun 2015 19:26:22 +0200
Message-Id: <1434993982-20741-1-git-send-email-andreas@fatal.se>
In-Reply-To: <CAG27Bk353ASGr0hyDe4oQvAZ3Swf_HbgonENtkOPFE_qcjE7MQ@mail.gmail.com>
References: <CAG27Bk353ASGr0hyDe4oQvAZ3Swf_HbgonENtkOPFE_qcjE7MQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The command "touch b0;rename.ul -v ./b0 ./b1 ./b0" used to work
before "allow renaming in subdirectories" change.
(regression in commit bd9ced628bb86)

Addresses: https://bugs.debian.org/789240
Reported-by: gregrwm <bug-grub@whitleymott.net>
Reviewed-by: Sami Kerola <kerolasa@iki.fi>
Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 misc-utils/rename.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

v2: fixed my email address, add reviewed by.

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

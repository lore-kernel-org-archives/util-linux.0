Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39284 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbeFVLze (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 22 Jun 2018 07:55:34 -0400
From: Alban Crequy <alban.crequy@gmail.com>
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        Alban Crequy <alban@kinvolk.io>
Cc: linux-fsdevel@vger.kernel.org, dongsu@kinvolk.io
Subject: [PATCH] mountinfo: parse empty strings in source
Date: Fri, 22 Jun 2018 13:54:25 +0200
Message-Id: <20180622115425.26183-1-alban@kinvolk.io>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Alban Crequy <alban@kinvolk.io>

The source of a mount in /proc/self/mountinfo can unfortunately be an
empty string. Before this patch, 'mount' and 'mountpoint' fail as
following:

  $ sudo mount -t tmpfs "" /tmp/bb
  $ mount
  mount: /proc/self/mountinfo: parse error at line 64 -- ignored
  $ mountpoint /tmp/bb
  /tmp/bb is not a mountpoint

This patch fixes the parsing. It is unfortunately more complex because
sscanf() does not handle fields with empty strings easily.

Other projects have their own parser for mountinfo and have similar
issues. I know of runc and runtime-tools (I'll send a patch for those
two) but there are probably others.

Signed-off-by: Alban Crequy <alban@kinvolk.io>
---
 libmount/src/tab_parse.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/libmount/src/tab_parse.c b/libmount/src/tab_parse.c
index 3ed84ebc2..4944d5f8c 100644
--- a/libmount/src/tab_parse.c
+++ b/libmount/src/tab_parse.c
@@ -173,13 +173,36 @@ static int mnt_parse_mountinfo_line(struct libmnt_fs *fs, char *s)
 		fs->opt_fields = strndup(s + 1, p - s - 1);
 	s = p + 3;
 
-	rc += sscanf(s,	UL_SCNsA" "	/* (8) FS type */
-			UL_SCNsA" "	/* (9) source */
-			UL_SCNsA,	/* (10) fs options (fs specific) */
+	end = 0;
+	rc += sscanf(s,	UL_SCNsA"%n",	/* (8) FS type */
 
 			&fstype,
-			&src,
-			&fs->fs_optstr);
+			&end);
+
+	if (rc >= 8 && end > 0)
+		s += end;
+	if (s[0] == ' ')
+		s++;
+
+	/* (9) source can unfortunately be an empty string "" and scanf does
+	 * not work well with empty string. Test with:
+	 *     $ sudo mount -t tmpfs "" /tmp/bb
+	 *     $ mountpoint /tmp/bb
+	 * */
+	if (s[0] == ' ') {
+		src = strdup("");
+		s++;
+		rc++;
+		rc += sscanf(s,	UL_SCNsA,	/* (10) fs options (fs specific) */
+
+				&fs->fs_optstr);
+	} else {
+		rc += sscanf(s,	UL_SCNsA" "	/* (9) source */
+				UL_SCNsA,	/* (10) fs options (fs specific) */
+
+				&src,
+				&fs->fs_optstr);
+	}
 
 	if (rc >= 10) {
 		size_t sz;
-- 
2.14.3


Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:16550 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766Ab2GZMOr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jul 2012 08:14:47 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q6QCEls5023379
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Thu, 26 Jul 2012 08:14:47 -0400
From: Milan Broz <mbroz@redhat.com>
To: util-linux@vger.kernel.org
Cc: Milan Broz <mbroz@redhat.com>
Subject: [PATCH] lsblk: support -o +<attr> for adding attribute to output fields.
Date: Thu, 26 Jul 2012 14:14:44 +0200
Message-Id: <1343304884-14297-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

E.g. lsblk -o +model
(Maybe it would be nice to add this to other tools as well?)

Signed-off-by: Milan Broz <mbroz@redhat.com>
---
 misc-utils/lsblk.c |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index cb2b768..471f2d5 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -1213,6 +1213,7 @@ int main(int argc, char *argv[])
 	struct lsblk _ls;
 	int tt_flags = TT_FL_TREE;
 	int i, c, status = EXIT_FAILURE;
+	char *outarg = NULL;
 
 	enum {
 		EXCL_NONE,
@@ -1290,11 +1291,7 @@ int main(int argc, char *argv[])
 			tt_flags |= TT_FL_NOHEADINGS;
 			break;
 		case 'o':
-			ncolumns = string_to_idarray(optarg,
-						columns, ARRAY_SIZE(columns),
-						column_name_to_id);
-			if (ncolumns < 0)
-				return EXIT_FAILURE;
+			outarg = optarg;
 			break;
 		case 'P':
 			exclusive_option(&excl_rlP, EXCL_PAIRS, "--{raw,list,pairs}");
@@ -1363,6 +1360,21 @@ int main(int argc, char *argv[])
 		columns[ncolumns++] = COL_TARGET;
 	}
 
+	if (outarg) {
+		if (outarg[0] == '+')
+			outarg++;
+		else
+			ncolumns = 0;
+
+		c = string_to_idarray(outarg, &columns[ncolumns],
+					ARRAY_SIZE(columns) - ncolumns,
+					column_name_to_id);
+		if (c < 0)
+			return EXIT_FAILURE;
+
+		ncolumns += c;
+	}
+
 	if (nexcludes == 0 && nincludes == 0)
 		excludes[nexcludes++] = 1;	/* default: ignore RAM disks */
 
-- 
1.7.10.4


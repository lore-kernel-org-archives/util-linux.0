Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:62320 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966Ab2GZNwb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jul 2012 09:52:31 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q6QDqVle027356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Thu, 26 Jul 2012 09:52:31 -0400
From: Milan Broz <mbroz@redhat.com>
To: util-linux@vger.kernel.org
Cc: Milan Broz <mbroz@redhat.com>
Subject: [PATCH 4/5] findmnt: support -o +<attr> for adding attribute to output fields.
Date: Thu, 26 Jul 2012 15:52:07 +0200
Message-Id: <1343310728-16624-4-git-send-email-mbroz@redhat.com>
In-Reply-To: <1343310728-16624-1-git-send-email-mbroz@redhat.com>
References: <1343304884-14297-1-git-send-email-mbroz@redhat.com>
 <1343310728-16624-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Milan Broz <mbroz@redhat.com>
---
 misc-utils/findmnt.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 6df2f06..482466b 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -1041,6 +1041,7 @@ int main(int argc, char *argv[])
 	int direction = MNT_ITER_FORWARD;
 	int i, c, rc = -1, timeout = -1;
 	int ntabfiles = 0, tabtype = 0;
+	char *outarg = NULL;
 
 	enum {
 		EXCL_NONE,
@@ -1150,11 +1151,7 @@ int main(int argc, char *argv[])
 			disable_columns_truncate();
 			break;
 		case 'o':
-			ncolumns = string_to_idarray(optarg,
-						columns, ARRAY_SIZE(columns),
-						column_name_to_id);
-			if (ncolumns < 0)
-				exit(EXIT_FAILURE);
+			outarg = optarg;
 			break;
 		case 'O':
 			set_match(COL_OPTIONS, optarg);
@@ -1260,6 +1257,10 @@ int main(int argc, char *argv[])
 		columns[ncolumns++] = COL_OPTIONS;
 	}
 
+	if (outarg && string_add_to_idarray(outarg, columns, ARRAY_SIZE(columns),
+					 &ncolumns, column_name_to_id) < 0)
+		return EXIT_FAILURE;
+
 	if (!tabtype)
 		tabtype = TABTYPE_KERNEL;
 
-- 
1.7.10.4


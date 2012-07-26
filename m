Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:24503 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752328Ab2GZNwc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jul 2012 09:52:32 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q6QDqWOm030580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Thu, 26 Jul 2012 09:52:32 -0400
From: Milan Broz <mbroz@redhat.com>
To: util-linux@vger.kernel.org
Cc: Milan Broz <mbroz@redhat.com>
Subject: [PATCH 5/5] wdctl: support -o +<attr> for adding attribute to output fields.
Date: Thu, 26 Jul 2012 15:52:08 +0200
Message-Id: <1343310728-16624-5-git-send-email-mbroz@redhat.com>
In-Reply-To: <1343310728-16624-1-git-send-email-mbroz@redhat.com>
References: <1343304884-14297-1-git-send-email-mbroz@redhat.com>
 <1343310728-16624-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Milan Broz <mbroz@redhat.com>
---
 sys-utils/wdctl.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sys-utils/wdctl.c b/sys-utils/wdctl.c
index ebe55b4..6367130 100644
--- a/sys-utils/wdctl.c
+++ b/sys-utils/wdctl.c
@@ -381,6 +381,7 @@ int main(int argc, char *argv[])
 	int c, tt_flags = 0, res = EXIT_SUCCESS, count = 0;
 	char noflags = 0, noident = 0, notimeouts = 0, oneline = 0;
 	uint32_t wanted = 0;
+	char *outarg = NULL;
 
 	enum {
 		EXCL_NONE,
@@ -413,11 +414,7 @@ int main(int argc, char *argv[])
 				"d:f:hFnITo:OrVx", long_opts, NULL)) != -1) {
 		switch(c) {
 		case 'o':
-			ncolumns = string_to_idarray(optarg,
-						     columns, ARRAY_SIZE(columns),
-						     column2id);
-			if (ncolumns < 0)
-				return EXIT_FAILURE;
+			outarg = optarg;
 			break;
 		case 'f':
 			exclusive_option(&excl_flag, EXCL_FLAGS, "--{flags,noflags}");
@@ -467,6 +464,10 @@ int main(int argc, char *argv[])
 		columns[ncolumns++] = COL_BSTATUS;
 	}
 
+	if (outarg && string_add_to_idarray(outarg, columns, ARRAY_SIZE(columns),
+					 &ncolumns, column2id) < 0)
+		return EXIT_FAILURE;
+
 	do {
 		int rc;
 
-- 
1.7.10.4


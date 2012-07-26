Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1982 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752314Ab2GZNwa (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jul 2012 09:52:30 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q6QDqUsb001853
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Thu, 26 Jul 2012 09:52:30 -0400
From: Milan Broz <mbroz@redhat.com>
To: util-linux@vger.kernel.org
Cc: Milan Broz <mbroz@redhat.com>
Subject: [PATCH 3/5] partx: support -o +<attr> for adding attribute to output fields.
Date: Thu, 26 Jul 2012 15:52:06 +0200
Message-Id: <1343310728-16624-3-git-send-email-mbroz@redhat.com>
In-Reply-To: <1343310728-16624-1-git-send-email-mbroz@redhat.com>
References: <1343304884-14297-1-git-send-email-mbroz@redhat.com>
 <1343310728-16624-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Milan Broz <mbroz@redhat.com>
---
 disk-utils/partx.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/disk-utils/partx.c b/disk-utils/partx.c
index 69c559d..8af33ab 100644
--- a/disk-utils/partx.c
+++ b/disk-utils/partx.c
@@ -643,6 +643,7 @@ int main(int argc, char **argv)
 	char *type = NULL;
 	char *device = NULL; /* pointer to argv[], ie: /dev/sda1 */
 	char *wholedisk = NULL; /* allocated, ie: /dev/sda */
+	char *outarg = NULL;
 	dev_t disk_devno = 0, part_devno = 0;
 
 	static const struct option long_opts[] = {
@@ -691,11 +692,7 @@ int main(int argc, char **argv)
 				errx(EXIT_FAILURE, _("failed to parse --nr <M-N> range"));
 			break;
 		case 'o':
-			ncolumns = string_to_idarray(optarg,
-						columns, ARRAY_SIZE(columns),
-						column_name_to_id);
-			if (ncolumns < 0)
-				return EXIT_FAILURE;
+			outarg = optarg;
 			exclusive_option(&what, ACT_SHOW, ACT_ERROR);
 			break;
 		case 'P':
@@ -740,6 +737,11 @@ int main(int argc, char **argv)
 		columns[ncolumns++] = COL_UUID;
 	}
 
+	if (what == ACT_SHOW && outarg &&
+	    string_add_to_idarray(outarg, columns, ARRAY_SIZE(columns),
+				   &ncolumns, column_name_to_id) < 0)
+		return EXIT_FAILURE;
+
 	/*
 	 * Note that 'partx /dev/sda1' == 'partx /dev/sda1 /dev/sda'
 	 * so assume that the device and/or disk are always the last
-- 
1.7.10.4


Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:61869 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751985AbdFVCht (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 21 Jun 2017 22:37:49 -0400
Received: from tenfore.ga-group.nl ([92.195.15.151]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M3d9B-1dfOos2XLt-00rKrl for
 <util-linux@vger.kernel.org>; Thu, 22 Jun 2017 04:37:47 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 04/13] blkid: use errtryhelp instead of errtryh
Date: Thu, 22 Jun 2017 04:37:37 +0200
Message-Id: <1498099066-24235-5-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
References: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

We have a --help option and this is preferred.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 misc-utils/blkid.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 1dc8f40..f95f673 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -762,7 +762,7 @@ int main(int argc, char **argv)
 		case 's':
 			if (numtag + 1 >= sizeof(ctl.show) / sizeof(*ctl.show)) {
 				warnx(_("Too many tags specified"));
-				errtryh(err);
+				errtryhelp(err);
 			}
 			ctl.show[numtag++] = optarg;
 			break;
@@ -773,13 +773,13 @@ int main(int argc, char **argv)
 			if (search_type) {
 				warnx(_("Can only search for "
 					"one NAME=value pair"));
-				errtryh(err);
+				errtryhelp(err);
 			}
 			if (blkid_parse_tag_string(optarg,
 						   &search_type,
 						   &search_value)) {
 				warnx(_("-t needs NAME=value pair"));
-				errtryh(err);
+				errtryhelp(err);
 			}
 			break;
 		case 'V':
@@ -794,7 +794,7 @@ int main(int argc, char **argv)
 			usage(0);
 			break;
 		default:
-			errtryh(EXIT_FAILURE);
+			errtryhelp(EXIT_FAILURE);
 		}
 	}
 
-- 
1.8.5.6


Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:65406 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751645AbcBURzR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 21 Feb 2016 12:55:17 -0500
Received: from assos.lan ([84.185.150.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LanoO-1a4lzg21qS-00kNNv for
 <util-linux@vger.kernel.org>; Sun, 21 Feb 2016 18:55:16 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/4] lib/strutils: parse_size(), sync errno and return value
Date: Sun, 21 Feb 2016 18:55:13 +0100
Message-Id: <1456077314-17910-4-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456077314-17910-1-git-send-email-sweet_f_a@gmx.de>
References: <1456077314-17910-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Maybe strtosize_or_err() is the only function which uses
this errno (wrongly). But it doesnt hurt to maintain rc
as well as errno.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 lib/strutils.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/strutils.c b/lib/strutils.c
index 03a367b9..64a6b99 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -91,7 +91,7 @@ int parse_size(const char *str, uintmax_t *res, int *power)
 
 	if (p == str ||
 	    (errno != 0 && (x == UINTMAX_MAX || x == 0))) {
-		rc = errno ? -errno : -1;
+		rc = errno ? -errno : -EINVAL;
 		goto err;
 	}
 	if (!p || !*p)
@@ -119,7 +119,7 @@ check_suffix:
 			frac = strtoumax(fstr, &p, 0);
 			if (p == fstr ||
 			    (errno != 0 && (frac == UINTMAX_MAX || frac == 0))) {
-				rc = errno ? -errno : -1;
+				rc = errno ? -errno : -EINVAL;
 				goto err;
 			}
 			if (frac && (!p  || !*p)) {
@@ -164,6 +164,8 @@ check_suffix:
 done:
 	*res = x;
 err:
+	if (rc < 0)
+		errno = -rc;
 	return rc;
 }
 
-- 
1.9.1


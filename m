Return-Path: util-linux-owner@vger.kernel.org
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:56558 "EHLO
	demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757416AbaIRGKF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 18 Sep 2014 02:10:05 -0400
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
	by demumfd001.nsn-inter.net (8.14.3/8.14.3) with ESMTP id s8I6A0ba009749
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Thu, 18 Sep 2014 06:10:00 GMT
Received: from ulegcprs1.emea.nsn-net.net ([10.151.15.253])
	by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id s8I69x5j009536
	for <util-linux@vger.kernel.org>; Thu, 18 Sep 2014 08:09:59 +0200
Date: Thu, 18 Sep 2014 08:09:59 +0200
From: Robert Schiele <rschiele@gmail.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] umount: read mountinfo if --detach-loop given
Message-ID: <20140918060959.GA25333@ulegcprs1.emea.nsn-net.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Don't use the optimization not to read mountinfo from commit
6a52473ecd877227f6f7da2b95da0b51593ffec1 if --detach-loop was given
since we need the name of the loop device in that case and with the
optimization this is not present and thus the detach operation
obviously fails.

Signed-off-by: Robert Schiele <rschiele@gmail.com>
---
 libmount/src/context_umount.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libmount/src/context_umount.c b/libmount/src/context_umount.c
index 73e8214..6c1d9a2 100644
--- a/libmount/src/context_umount.c
+++ b/libmount/src/context_umount.c
@@ -254,7 +254,8 @@ static int lookup_umount_fs(struct libmnt_context *cxt)
 	 * options for the target (e.g. helper=udisks to call /sbin/umount.udisks).
 	 *
 	 * So, let's use statfs() if possible (it's bad idea for --lazy/--force
-	 * umounts as target is probably unreachable NFS).
+	 * umounts as target is probably unreachable NFS, also for --detach-loop
+	 * as this additionally needs to know the name of the loop device).
 	 */
 	if (!mnt_context_is_restricted(cxt)
 	    && *tgt == '/'
@@ -262,6 +263,7 @@ static int lookup_umount_fs(struct libmnt_context *cxt)
 	    && !mnt_context_mtab_writable(cxt)
 	    && !mnt_context_is_force(cxt)
 	    && !mnt_context_is_lazy(cxt)
+	    && !mnt_context_is_loopdel(cxt)
 	    && stat(tgt, &st) == 0 && S_ISDIR(st.st_mode)
 	    && !has_utab_entry(cxt, tgt)) {
 
-- 
1.8.4.5

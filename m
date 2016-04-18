Return-Path: util-linux-owner@vger.kernel.org
Received: from shell.v3.sk ([92.60.52.57]:34387 "EHLO shell.v3.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422AbcDRHBn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Apr 2016 03:01:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.v3.sk (Postfix) with ESMTP id E059E77965
	for <util-linux@vger.kernel.org>; Mon, 18 Apr 2016 09:01:36 +0200 (CEST)
From: Lubomir Rintel <lkundrak@v3.sk>
To: util-linux@vger.kernel.org
Cc: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] mkswap: tolerate ENOTSUP when failing to relabel
Date: Mon, 18 Apr 2016 09:01:23 +0200
Message-Id: <1460962883-6380-1-git-send-email-lkundrak@v3.sk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

It might be that the underlying filesystem just doesn't support SELinux
labeling. This fixes creating swap on vfat live media:

  # livecd-iso-to-disk.sh --msdos --swap-size-mb 666 ...

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 disk-utils/mkswap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index a7c6a70..e44d039 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -522,7 +522,7 @@ int main(int argc, char **argv)
 		context_string = context_str(newcontext);
 
 		if (strcmp(context_string, oldcontext)!=0) {
-			if (fsetfilecon(ctl.fd, context_string))
+			if (fsetfilecon(ctl.fd, context_string) && errno != ENOTSUP)
 				err(EXIT_FAILURE, _("unable to relabel %s to %s"),
 						ctl.devname, context_string);
 		}
-- 
2.7.3


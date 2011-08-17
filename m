Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.date.uni-paderborn.de ([131.234.158.22]:39990 "EHLO
	mail.date.uni-paderborn.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752774Ab1HQSm3 convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 17 Aug 2011 14:42:29 -0400
Received: from mail.date.uni-paderborn.de (localhost [127.0.0.1])
	by mail.date.uni-paderborn.de (Postfix) with ESMTP id 1C6664182
	for <util-linux@vger.kernel.org>; Wed, 17 Aug 2011 20:40:52 +0200 (CEST)
Received: from arch.localnet (p5486AB3B.dip.t-dialin.net [84.134.171.59])
	by mail.date.uni-paderborn.de (Postfix) with ESMTPSA id 87DC74182
	for <util-linux@vger.kernel.org>; Wed, 17 Aug 2011 20:40:51 +0200 (CEST)
From: Nick Erdmann <erdmann@date.upb.de>
To: util-linux@vger.kernel.org
Subject: [PATCH] ddate: St. Tib's Day in other languages
Date: Wed, 17 Aug 2011 20:35:02 +0200
Message-ID: <1976757.PW98uZrV7g@arch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In other languages than english, the translation of "St. Tib's Day" may not
be 13 bytes long. Example of what happens in german:
$ ddate 29 2 2008
St. Tib’s D, 3174 YOLD

Signed-off-by: Nick Erdmann <erdmann@date.upb.de>
--- a/misc-utils/ddate.c	2011-07-20 21:55:23.000000000 +0200
+++ b/misc-utils/ddate.c	2011-08-17 18:11:12.437504258 +0200
@@ -223,6 +223,7 @@
     int tib_start=-1, tib_end=0;
     int i, fmtlen=strlen(fmt);
     char *bufptr=buf;
+    char *foo;
 
 /*    fprintf(stderr, "format(%p, \"%s\", dt)\n", buf, fmt);*/
 
@@ -249,7 +250,9 @@
     for(i=0; i<fmtlen; i++) {
 	if((i==tib_start) && (dt.day==-1)) {
 	    /* handle St. Tib's Day */
-	    strcpy(bufptr, _("St. Tib's Day")); bufptr += 13;
+	    foo = _("St. Tib's Day");
+	    while((*bufptr++=*foo++));
+	    --bufptr;
 	    i=tib_end;
 	} else {
 	    if(fmt[i]=='%') {

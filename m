Return-Path: util-linux-owner@vger.kernel.org
Received: from hedwig.cmf.nrl.navy.mil ([134.207.12.162]:49118 "EHLO
	hedwig.cmf.nrl.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895Ab2DTPEt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 20 Apr 2012 11:04:49 -0400
Received: from thirdoffive.cmf.nrl.navy.mil (thirdoffive.cmf.nrl.navy.mil [134.207.12.180])
	by hedwig.cmf.nrl.navy.mil (8.14.2/8.14.2) with ESMTP id q3KEwTtR002381
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <util-linux@vger.kernel.org>; Fri, 20 Apr 2012 10:58:30 -0400
Received: from cmf.nrl.navy.mil (localhost [127.0.0.1])
	by thirdoffive.cmf.nrl.navy.mil (8.14.4/8.14.4) with ESMTP id q3KEwSRd004262
	for <util-linux@vger.kernel.org>; Fri, 20 Apr 2012 10:58:28 -0400
Date: Fri, 20 Apr 2012 10:58:28 -0400
From: chas williams - CONTRACTOR <chas@cmf.nrl.navy.mil>
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: [PATCH] login-utils: use getdtablesize() correctly in login.c
Message-ID: <20120420105828.554ce55a@thirdoffive.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

while it might seem harmless to close a non-existent descriptor, we have
a local configuration that protects a certain descriptor by lowering
rlim_cur to prevent child processes from closing said descriptor. this
descriptor points to a ticket cache which we need later for the user.

Author: chas williams - CONTRACTOR <chas@cmf.nrl.navy.mil>
Date:   Fri Apr 20 10:49:51 2012 -0400

    login-utils: use getdtablesize() correctly in login.c
    
    getdtablesize() is the number of descriptors and since decriptors start
    at 0, its value isnt the largest descriptors possible.  One should use
    getdtablesize() - 1 instead.
    
    Signed-off-by: Chas Williams - CONTRACTOR <chas@cmf.nrl.navy.mil>

diff --git a/login-utils/login.c b/login-utils/login.c
index 6c3b6f7..026c72b 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -1290,7 +1290,7 @@ int main(int argc, char **argv)
 			*p++ = ' ';
 	}
 
-	for (cnt = getdtablesize(); cnt > 2; cnt--)
+	for (cnt = (getdtablesize() - 1); cnt > 2; cnt--)
 		close(cnt);
 
 	setpgrp();	 /* set pgid to pid this means that setsid() will fail */

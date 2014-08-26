Return-Path: util-linux-owner@vger.kernel.org
Received: from edony.tuxfamily.net ([212.85.158.2]:44747 "EHLO
	edony.tuxfamily.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932467AbaHZJlJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 26 Aug 2014 05:41:09 -0400
Received: from vodka.tf-data.net ([192.168.1.100] helo=webmail.tuxfamily.org)
	by edony.tuxfamily.net with esmtp (Exim 4.80)
	(envelope-from <tnut@nutyx.org>)
	id 1XMCtF-0002IN-Nd
	for util-linux@vger.kernel.org; Tue, 26 Aug 2014 11:18:09 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 26 Aug 2014 11:18:09 +0200
From: tnut@nutyx.org
To: <util-linux@vger.kernel.org>
Subject: cfdisk, wrong interpretation of yes in non-english language
Message-ID: <d8263f3bc98929c82bbd0962ca77a159@nutyx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I'm building a new installer for the NuTyX distribution.

If another language then english is choose as native language, some 
answer are wrong interpreted

I think you should check both cases are wrong instead of one of them or 
do the test in the opposite way

Here is a proposal of patch:


--- util-linux-2.25/disk-utils/cfdisk.c 2014-07-21 13:36:21.000000000 
+0000
+++ util-linux-2.25-new/disk-utils/cfdisk.c     2014-08-25 
18:52:17.000000000 +0000
@@ -1834,8 +1834,8 @@
                           buf, sizeof(buf));

                 ref = 1;
-               if (rc <= 0 || strcasecmp(buf, "yes") != 0
-                           || strcasecmp(buf, _("yes")) != 0) {
+               if (rc <= 0 ||  (strcasecmp(buf, "yes") != 0
+                           && strcasecmp(buf, _("yes")) != 0)) {
                         info = _("Did not write partition table to 
disk");
                         break;
                 }

Regards


Thierry Nuttens

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:55787 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750731AbdALOpK (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 12 Jan 2017 09:45:10 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 07E7175011
        for <util-linux@vger.kernel.org>; Thu, 12 Jan 2017 14:45:08 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 0/3] fix side effects of loop reuse
Message-ID: <47fc1410-17bf-6fe2-a396-93cf47ab6ac2@suse.cz>
Date: Thu, 12 Jan 2017 15:45:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Detailed testing discovered some regressions in the loop reuse code:


1) mount -oloop=/dev/loop1 changed its behavior

Note that the proposed solution keeps overlay checks active. There is
another possible solution: disable all checks:

--- a/libmount/src/context_loopdev.c
+++ b/libmount/src/context_loopdev.c
@@ -215,7 +215,7 @@ int mnt_context_setup_loopdev(struct libmnt_context *cxt)
 	 * mechanism to detect it. To prevent data corruption, the same loop
 	 * device has to be recycled.
 	*/
-	if (backing_file) {
+	if (backing_file && !loopval) {
 		rc = loopcxt_init(&lc, 0);
 		if (rc)
 			goto done_no_deinit;

There is still a small regression that could be fixed in the future:
If both the existing and the requested devices are read-only, it is
safe to not reuse existing loop device.

So we can think about allowing of:
losetup --read-only /dev/loop0 file.img
mount -oro,loop=/dev/loop1 file.img /mnt

2) If mount re-uses an existing loop device, then the loop device is
detached, even if autoclean flag is off.

Note that I was not able to find a mechanism, how mount gets the "loop"
in the output, so I did the change in mount, and not umount.


-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

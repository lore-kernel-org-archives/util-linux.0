Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:56036 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753344Ab3FNSBW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 14 Jun 2013 14:01:22 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 03DAEA341E
	for <util-linux@vger.kernel.org>; Fri, 14 Jun 2013 20:01:21 +0200 (CEST)
Message-ID: <1371232880.11619.1.camel@oct.suse.cz>
Subject: [PATCH] eject: Check host_status and driver_status when using SG_IO.
From: Stanislav Brabec <sbrabec@suse.cz>
To: util-linux@vger.kernel.org
Date: Fri, 14 Jun 2013 20:01:20 +0200
Content-Type: text/plain; charset="ISO-8859-2"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I just reviewed patches from SUSE eject package. I found one which
probably still applies. It was written by Anna Bernathova (now
Maresova).

>From c8a15b1f325a20a33233f56815cf3c6e71b86031 Mon Sep 17 00:00:00 2001
From: Anna Bernathova <anicka@suse.cz>
Date: Tue, 27 May 2008 09:39:49 +0200
Subject: [PATCH] eject: Check host_status and driver_status when using SG_IO.

Detailed description from https://bugzilla.novell.com/show_bug.cgi?id=358033

Tejun Heo 2008-05-23 11:54:01 UTC:

ioctl(4, SG_IO, {'S', SG_DXFER_NONE, cmd[6]=[1b, 00, 00, 00, 02, 00],
mx_sb_len=32, iovec_count=0, dxfer_len=0, timeout=8000, flags=0, status=00,
masked_status=00, sb[0]=[], host_status=0x4, driver_status=0, resid=0,
duration=0, info=0x1}) = 0

The SG_IO succeeded with host_status=0x4 which is DID_BAD_TARGET meaning that
there was no such device.  SG_IO completion status is weird but still well
defined.  You'll need to check both host_status, driver_status and status to
determine that a command actually succeeded.

Please take a look at http://sg.torque.net/sg/sg_io.html and
include/scsi/scsi.h for details.

Signed-off-by: Anna Bernathova <anicka@suse.cz>
---
 sys-utils/eject.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index 4ec69e7..b319dd2 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -41,6 +41,7 @@
 #include <scsi/scsi.h>
 #include <scsi/sg.h>
 #include <scsi/scsi_ioctl.h>
+#include <scsi/sg_io_linux.h>
 #include <sys/time.h>
 
 #include <libmount.h>
@@ -604,17 +605,17 @@ static int eject_scsi(int fd)
 
 	io_hdr.cmdp = allowRmBlk;
 	status = ioctl(fd, SG_IO, (void *)&io_hdr);
-	if (status < 0)
+	if (status < 0 || io_hdr.host_status != DID_OK || io_hdr.driver_status != DRIVER_OK)
 		return 0;
 
 	io_hdr.cmdp = startStop1Blk;
 	status = ioctl(fd, SG_IO, (void *)&io_hdr);
-	if (status < 0)
+	if (status < 0 || io_hdr.host_status != DID_OK || io_hdr.driver_status != DRIVER_OK)
 		return 0;
 
 	io_hdr.cmdp = startStop2Blk;
 	status = ioctl(fd, SG_IO, (void *)&io_hdr);
-	if (status < 0)
+	if (status < 0 || io_hdr.host_status != DID_OK || io_hdr.driver_status != DRIVER_OK)
 		return 0;
 
 	/* force kernel to reread partition table when new disc inserted */
-- 
1.8.1.4

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                  fax: +420 284 028 951
Czech Republic                                    http://www.suse.cz/

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                  fax: +420 284 028 951
Czech Republic                                    http://www.suse.cz/


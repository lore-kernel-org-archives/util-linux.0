Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34911 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752106Ab3FRKr0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 18 Jun 2013 06:47:26 -0400
Date: Tue, 18 Jun 2013 12:47:21 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] eject: Check host_status and driver_status when using
 SG_IO.
Message-ID: <20130618104721.GD29243@x2.net.home>
References: <1371232880.11619.1.camel@oct.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371232880.11619.1.camel@oct.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jun 14, 2013 at 08:01:20PM +0200, Stanislav Brabec wrote:
> diff --git a/sys-utils/eject.c b/sys-utils/eject.c
> index 4ec69e7..b319dd2 100644
> --- a/sys-utils/eject.c
> +++ b/sys-utils/eject.c
> @@ -41,6 +41,7 @@
>  #include <scsi/scsi.h>
>  #include <scsi/sg.h>
>  #include <scsi/scsi_ioctl.h>
> +#include <scsi/sg_io_linux.h>

I don't see this file on Fedora and it seems that the *_OK macros are
defined in include/scsi/scsi.h in kernel tree. Anyway it seems that
the *_OK macros are unnecessary as zero means OK.
 
>  #include <sys/time.h>
>  
>  #include <libmount.h>
> @@ -604,17 +605,17 @@ static int eject_scsi(int fd)
>  
>  	io_hdr.cmdp = allowRmBlk;
>  	status = ioctl(fd, SG_IO, (void *)&io_hdr);
> -	if (status < 0)
> +	if (status < 0 || io_hdr.host_status != DID_OK || io_hdr.driver_status != DRIVER_OK)
>  		return 0;
>  
>  	io_hdr.cmdp = startStop1Blk;
>  	status = ioctl(fd, SG_IO, (void *)&io_hdr);
> -	if (status < 0)
> +	if (status < 0 || io_hdr.host_status != DID_OK || io_hdr.driver_status != DRIVER_OK)
>  		return 0;

This makes "eject --scsi" useless when you want to open empty (with no medium)
device. Strace:

  ioctl(3, SG_IO, {'S', SG_DXFER_NONE, cmd[6]=[1b, 00, 00, 00, 01,
  00], mx_sb_len=32, iovec_count=0, dxfer_len=0, timeout=10000,
  flags=0, status=02, masked_status=01, sb[18]=[70, 00, 02, 00, 00,
  00, 00, 0a, 00, 00, 00, 00, 3a, 00, 00, 00, 00, 00], host_status=0,
  driver_status=0x8, resid=0, duration=3, info=0x1}) = 0

driver_status is DRIVER_SENSE in this situation, and according to
sb[12] (additional sense code 3a) it's MEDIUM NOT PRESENT.

I have applied a little different patch, see below.

Thanks!

    Karel

>From 90a0e97c7be9da39fd54600228e006b98667ad56 Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Tue, 18 Jun 2013 12:24:28 +0200
Subject: [PATCH] eject: Check host_status and driver_status when using SG_IO.

Based on Suse patch, originally from
	Anna Bernathova <anicka@suse.cz>, May 2008

  SG_IO completion status is weird but still well defined. You'll need
  to check both host_status, driver_status and status to determine that
  a command actually succeeded. -- Tejun Heo, May 2008

Note that we also need to check driver_status and sense_buffer to
detect situation when there is no medium. It's valid request to call
eject(8) for device with no medium.

References: https://bugzilla.novell.com/show_bug.cgi?id=358033
Signed-off-by: Anna Bernathova <anicka@suse.cz>
Signed-off-by: Karel Zak <kzak@redhat.com>
---
 sys-utils/eject.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index 4ec69e7..f98f227 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -53,6 +53,14 @@
 #include "pathnames.h"
 #include "sysfs.h"
 
+/*
+ * sg_io_hdr_t driver_status -- see kernel include/scsi/scsi.h
+ */
+#ifndef DRIVER_SENSE
+# define DRIVER_SENSE	0x08
+#endif
+
+
 #define EJECT_DEFAULT_DEVICE "/dev/cdrom"
 
 
@@ -604,17 +612,27 @@ static int eject_scsi(int fd)
 
 	io_hdr.cmdp = allowRmBlk;
 	status = ioctl(fd, SG_IO, (void *)&io_hdr);
-	if (status < 0)
+	if (status < 0 || io_hdr.host_status || io_hdr.driver_status)
 		return 0;
 
 	io_hdr.cmdp = startStop1Blk;
 	status = ioctl(fd, SG_IO, (void *)&io_hdr);
-	if (status < 0)
+	if (status < 0 || io_hdr.host_status)
+		return 0;
+
+	/* Ignore errors when there is not medium -- in this case driver sense
+	 * buffer sets MEDIUM NOT PRESENT (3a) bit. For more details see:
+	 * http://www.tldp.org/HOWTO/archived/SCSI-Programming-HOWTO/SCSI-Programming-HOWTO-22.html#sec-sensecodes
+	 * -- kzak Jun 2013
+	 */
+	if (io_hdr.driver_status != 0 &&
+	    !(io_hdr.driver_status == DRIVER_SENSE && io_hdr.sbp &&
+		                                      io_hdr.sbp[12] == 0x3a))
 		return 0;
 
 	io_hdr.cmdp = startStop2Blk;
 	status = ioctl(fd, SG_IO, (void *)&io_hdr);
-	if (status < 0)
+	if (status < 0 || io_hdr.host_status || io_hdr.driver_status)
 		return 0;
 
 	/* force kernel to reread partition table when new disc inserted */
-- 
1.8.1.4


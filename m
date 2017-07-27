Return-Path: util-linux-owner@vger.kernel.org
Received: from [195.159.176.226] ([195.159.176.226]:54472 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbdG0I6q (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 27 Jul 2017 04:58:46 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcuu-util-linux-ng@m.gmane.org>)
        id 1daecw-0007xb-97
        for util-linux@vger.kernel.org; Thu, 27 Jul 2017 10:58:38 +0200
To: util-linux@vger.kernel.org
From: yumkam@gmail.com (Yuriy M. Kaminskiy)
Subject: Re: [PATCH] libmount: if ENOMEDIUM and tray is open, close tray and retry
Date: Thu, 27 Jul 2017 11:58:36 +0300
Message-ID: <m3wp6u5k8z.fsf@gmail.com>
References: <0e40cb41-a64a-93b1-0c06-620cca40a575@suse.cz>
        <f29ab5ef-753d-2ea8-e348-d53cdf4262cf@suse.cz>
        <db7a8eaa-3519-234c-72c9-428ca1b80ff0@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 07/21/17 21:44 , Stanislav Brabec wrote:
> In past, d50c5917 introduced an interesting behavior: If mount was called on a
> CDROM with open tray, the tray was closed and mount was retried. But the
> implementation caused 15 seconds delay, so ca55a451 reverted it.
>
> This is another attempt to implement that:
> If tray is closed: No delay, no retry, simply fail.
> If tray is open: Check, whether the drive can close tray.
>   If yes, close tray and retry after 3 seconds.
>   If not, no delay, no retry, simply fail.
>
> It can never cause delay more than time to close tray + 3 sec.
>
> Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
> ---
>  libmount/src/context_mount.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
> index 65f7dbfd0..ed0b84080 100644
> --- a/libmount/src/context_mount.c
> +++ b/libmount/src/context_mount.c
> @@ -18,11 +18,15 @@
>  
>  #include <sys/wait.h>
>  #include <sys/mount.h>
> +#include <linux/cdrom.h>
>  
>  #include "linux_version.h"
>  #include "mountP.h"
>  #include "strutils.h"
>  
> +/* open() retries when errno is ENOMEDIUM and tray is open */
> +#define CRDOM_TRAYOPEN_RETRIES    5
> +
>  /*
>   * Kernel supports only one MS_PROPAGATION flag change by one mount(2) syscall,
>   * to bypass this restriction we call mount(2) per flag. It's really not a perfect
> @@ -1292,6 +1296,8 @@ int mnt_context_get_mount_excode(
>  	int syserr;
>  	struct stat st;
>  	unsigned long uflags = 0, mflags = 0;
> +	int cdrom;
> +	unsigned int retries = 0;
>  
>  	int restricted = mnt_context_is_restricted(cxt);
>  	const char *tgt = mnt_context_get_target(cxt);
> @@ -1399,6 +1405,7 @@ int mnt_context_get_mount_excode(
>  	/*
>  	 * mount(2) errors
>  	 */
> +mount_retry:
>  	syserr = mnt_context_get_syscall_errno(cxt);
>  
>  
> @@ -1563,6 +1570,19 @@ int mnt_context_get_mount_excode(
>  		break;
>  
>  	case ENOMEDIUM:
> +		cdrom = open(mnt_context_get_source(cxt), O_RDONLY | O_NONBLOCK);
> +		if (cdrom != -1) {
> +			if (retries < CRDOM_TRAYOPEN_RETRIES &&
> +			    (ioctl(cdrom, CDROM_GET_CAPABILITY, NULL) & CDC_CLOSE_TRAY) &&

If ioctl is not supported, and ioctl() returns -1, (ioctl() & FOO) is
true.
I guess this should be something like
+                            (rc = ioctl(cdrom, CDROM_GET_CAPABILITY, NULL)) != -1 &&
+                             (rc & CDC_CLOSE_TRAY) &&
instead.

> +			    ioctl(cdrom, CDROM_DRIVE_STATUS, NULL) == CDS_TRAY_OPEN) {
> +				ioctl(cdrom, CDROMCLOSETRAY);

Error check missing?

(And, I used cdrom a long time ago, but IIRC there were some driver
settings to automatically close tray on device open, so that this patch
should not be needed?)

> +				close(cdrom);
> +				sleep(3);
> +				++retries;
> +				goto mount_retry;
> +			} else
> +				close(cdrom);
> +		}
>  		if (uflags & MNT_MS_NOFAIL)
>  			return MNT_EX_SUCCESS;
>  		if (buf)


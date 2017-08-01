Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751610AbdHAMQT (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 1 Aug 2017 08:16:19 -0400
Date: Tue, 1 Aug 2017 14:16:15 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount: if ENOMEDIUM and tray is open, close tray and
 retry
Message-ID: <20170801121615.nxqolue5qv3rwlrh@ws.net.home>
References: <0e40cb41-a64a-93b1-0c06-620cca40a575@suse.cz>
 <f29ab5ef-753d-2ea8-e348-d53cdf4262cf@suse.cz>
 <db7a8eaa-3519-234c-72c9-428ca1b80ff0@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <db7a8eaa-3519-234c-72c9-428ca1b80ff0@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 21, 2017 at 08:44:03PM +0200, Stanislav Brabec wrote:
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
> +			    ioctl(cdrom, CDROM_DRIVE_STATUS, NULL) == CDS_TRAY_OPEN) {
> +				ioctl(cdrom, CDROMCLOSETRAY);
> +				close(cdrom);
> +				sleep(3);
> +				++retries;
> +				goto mount_retry;
> +			} else
> +				close(cdrom);
> +		}

This cannot work.

It seem you have tested the tray-close only, but I guess your goal is
also *mount* the device. The "goto mount_retry" does not call any
mount(2) stuff :-)

The function mnt_context_get_mount_excode() is wrong place. This
optional function is there to generate error message and exit code.
Nothing else.

The right place for your code is mnt_context_mount() where we already
have the same logic ("try mount again") for read-only devices. You
need something like:

 if (mnt_context_syscall_called(cxt) &&
     mnt_context_get_syscall_errno(cxt) == ENOMEDIUM) {

    ... your open() and ioctls ...

    goto again;
 }


Use findmnt(8) to be sure that CDROM is really mounted.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

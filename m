Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:55113 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757473AbdELOF6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 12 May 2017 10:05:58 -0400
Subject: Re: [PATCH] Re: [ANNOUNCE] util-linux v2.30-rc1
To: J William Piggott <elseifthen@gmx.com>,
        Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <20170512120310.s7mmuciunmftd5en@ws.net.home>
 <15e27e95-29e2-3362-265f-635666d59230@gmx.com>
From: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>
Message-ID: <ff208f01-8d5e-49e7-bbbe-782fdec4b616@gmx.de>
Date: Fri, 12 May 2017 16:05:46 +0200
MIME-Version: 1.0
In-Reply-To: <15e27e95-29e2-3362-265f-635666d59230@gmx.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 05/12/2017 04:03 PM, J William Piggott wrote:
> 
> --- v2.30-ReleaseNotes-orig	2017-05-12 08:39:25.300530082 -0400
> +++ v2.30-ReleaseNotes-new	2017-05-12 09:47:51.345896434 -0400
> @@ -9,7 +9,6 @@
>   
>   The deprecated command tailf has been removed. Use "tail -f" from coreutils.
>   
> -
>   blkzone -- NEW COMMAND to run zone commands on block device that support Zoned
>   Block Commands (ZBC) or Zoned-device ATA Commands (ZAC). The currently
>   supported functionality is 'report' and 'reset'.
> @@ -19,13 +18,12 @@
>   [thanks to Masatake YAMATO (Red Hat)]
>   
>   lsmem -- NEW COMMAND to list the ranges of available memory with their online
> -status (originally implementd in Perl for s390-tools). [thanks to Clemens von Mann
> +status (originally implemented in Perl for s390-tools). [thanks to Clemens von Mann
>   and Heiko Carstens (IBM)]
>   
> -chmem -- NEW COMMAND to set memeory online/offline status [thanks to Heiko
> +chmem -- NEW COMMAND to set memory online/offline status [thanks to Heiko
>   Carstens (IBM)]
>   
> -
>   The old and dead Alpha and Cmos code has been removed from hwclock command.
>   
>   The command fallocate supports "insert range" operation now.
> @@ -39,21 +37,36 @@
>   messages compatible with mount(8).
>   
>   
> +Security issues
> +---------------
> +
> +hwclock - no longer makes any internal permission checks. The System
> +  Administrator must set proper permissions to control user access to
> +  the RTC. It is NOT recommended to use set-user-ID.
> +
> +CVE-2016-2779 - This security issue is NOT FIXED yet.  It is possible to
> +  disable the ioctl TIOCSTI by setsid() only.  Unfortunately, setsid()
> +  has well-defined use cases in su(1) and runuser(1) and any changes
> +  would introduce regressions.  It seems we need a better way -- ideally
> +  another ioctl to disable TIOCSTI without setsid() or in userspace
> +  implemented pty container (planned as experimental su(1) feature).
> +
> +
>   Stable maintenance releases between v2.29 and v2.30
>   ---------------------------------------------------
> -
> -util-linux 2.29.2 [Fed 02 2017]
> -
> +
> +util-linux 2.29.2 [Fed 02 2017]

s/Fed/Feb/

> +
>    * https://www.kernel.org/pub/linux/utils/util-linux/v2.29/v2.29.2-ReleaseNotes
>      https://www.kernel.org/pub/linux/utils/util-linux/v2.29/v2.29.2-ChangeLog
> -
> -util-linux 2.29.1 [Jan 01 2017]
> -
> +
> +util-linux 2.29.1 [Jan 01 2017]
> +
>    * https://www.kernel.org/pub/linux/utils/util-linux/v2.29/v2.29.1-ReleaseNotes
>      https://www.kernel.org/pub/linux/utils/util-linux/v2.29/v2.29.1-ChangeLog
> -
> +
>   Changes between v2.29 and v2.30
> --------------------------------
> +-------------------------------
>   
>   agetty:
>      - fix a memory leak when parsing \S in issue files  [Matthias Gerstner]
> @@ -274,7 +287,7 @@
>      - clarify cmos inb and outb preprocessor directives  [Sami Kerola]
>      - clarify set_cmos_epoch() code  [Sami Kerola]
>      - do not hardcode date command magic string twice  [Sami Kerola]
> -   - don't check for permissions  [Karel Zak]
> +   - *SECURITY* don't check for permissions  [Karel Zak] See 'Security issues'
>      - extra messages for debug only  [J William Piggott]
>      - fix rtc atexit registration  [Sami Kerola]
>      - fix whitespace in hwclock-rtc.c  [J William Piggott]
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

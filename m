Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751311AbeECIqc (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 3 May 2018 04:46:32 -0400
Date: Thu, 3 May 2018 10:46:29 +0200
From: Karel Zak <kzak@redhat.com>
To: L A Walsh <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Subject: Re: FYI...build "ok", thought some warnings, annoyances in 2.32...
Message-ID: <20180503084629.q75x7bjvgw67rrsp@ws.net.home>
References: <5AE93E2E.9040506@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <5AE93E2E.9040506@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 01, 2018 at 09:27:26PM -0700, L A Walsh wrote:
> At the annoyance level: of the 8 utils I tried to build statically,
> 0 worked: "complete static linking is impossible in this configuration".
> I wonder if this is a 'SUSE-ism'?

This is usually glibc issue where for some stuff (like work with
users) is required modules, etc.

> libblkid/src/superblocks/zfs.c: In function ‘probe_zfs’:
> libblkid/src/superblocks/zfs.c:254:14: warning: ‘offset’ may be used
> uninitialized in this function [-Wmaybe-uninitialized]

Fixed.

> libmount/src/monitor.c:202:62: warning: unused parameter ‘mn’
> [-Wunused-parameter]
> --
> libmount/src/monitor.c: In function ‘kernel_monitor_close_fd’:
> libmount/src/monitor.c:433:59: warning: unused parameter ‘mn’
> [-Wunused-parameter]
> --
> libfdisk/src/sun.c: In function ‘fdisk_new_sun_label’:
> libfdisk/src/sun.c:1152:63: warning: unused parameter ‘cxt’
> [-Wunused-parameter]
> --
> libfdisk/src/sgi.c: In function ‘fdisk_new_sgi_label’:
> libfdisk/src/sgi.c:1181:63: warning: unused parameter ‘cxt’
> [-Wunused-parameter]
> --
> libfdisk/src/dos.c: In function ‘fdisk_new_dos_label’:
> libfdisk/src/dos.c:2467:63: warning: unused parameter ‘cxt’
> [-Wunused-parameter]
> --
> libfdisk/src/bsd.c: In function ‘fdisk_new_bsd_label’:
> libfdisk/src/bsd.c:1031:63: warning: unused parameter ‘cxt’
> [-Wunused-parameter]
> --
> libfdisk/src/gpt.c: In function ‘fdisk_new_gpt_label’:
> libfdisk/src/gpt.c:3143:63: warning: unused parameter ‘cxt’
> [-Wunused-parameter]

 --disable-assert right? :-)

Fixed.

> disk-utils/fdisk.c: In function ‘ask_number’:
> disk-utils/fdisk.c:294:11: warning: ‘num’ may be used uninitialized in this
> function [-Wmaybe-uninitialized]
> --
> disk-utils/fdisk.c: In function ‘ask_number’:
> disk-utils/fdisk.c:294:11: warning: ‘num’ may be used uninitialized in this
> function [-Wmaybe-uninitialized]

Fixed.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

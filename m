Return-Path: util-linux-owner@vger.kernel.org
Received: from mailout-de.gmx.net ([213.165.64.22]:53554 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750826Ab2IEL1Y (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 5 Sep 2012 07:27:24 -0400
Date: Wed, 5 Sep 2012 13:27:17 +0200
From: Moritz Barsnick <barsnick@gmx.net>
To: util-linux list <util-linux@vger.kernel.org>
Subject: util-linux-2.22: backward compatibility of wdctl
Message-ID: <20120905112717.GA14130@sunshine.barsnick.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi everyone,
congratulations on util-linux 2.22. BTW, I recently took the liberty of
refreshing the freshmeat aka freecode entry, and submitted an update
for 2.22 today. I hope that's okay.

Anyway, just for the fun of it, I was trying to compile util-linux on
an SLES10 (SUSE Linux Enterprise) machine. That's one of those
enterprise distributions with somewhat ancient environments. ;-) But
nothing out of the ordinary nowadays, I think.

I didn't succeed, because wdctl makes use of #defines which are not
defined on this OS:

  make[2]: Entering directory `/tmp/Bui/util-linux/util-linux-2.22'
    CC     sys-utils/wdctl.o
  sys-utils/wdctl.c:53:4: error: 'WDIOF_PRETIMEOUT' undeclared here (not in a function)
  sys-utils/wdctl.c: In function 'read_watchdog':
  sys-utils/wdctl.c:352:17: error: 'WDIOC_GETPRETIMEOUT' undeclared (first use in this function)
  sys-utils/wdctl.c:352:17: note: each undeclared identifier is reported only once for each function it appears in
  sys-utils/wdctl.c:352:3: warning: passing argument 2 of 'ioctl' makes integer from pointer without a cast [enabled by default]
  In file included from sys-utils/wdctl.c:21:0:
  /usr/include/sys/ioctl.h:42:12: note: expected 'long unsigned int' but argument is of type 'const struct wdflag *'
  sys-utils/wdctl.c:354:17: error: 'WDIOC_GETTIMELEFT' undeclared (first use in this function)
  sys-utils/wdctl.c:354:3: warning: passing argument 2 of 'ioctl' makes integer from pointer without a cast [enabled by default]
  In file included from sys-utils/wdctl.c:21:0:
  /usr/include/sys/ioctl.h:42:12: note: expected 'long unsigned int' but argument is of type 'const struct wdflag *'
  make[2]: *** [sys-utils/wdctl.o] Error 1

This system's/kernel's watchdog.h doesn't have those #defines:

  > grep -rFn WDIOC_ /usr/include/
  /usr/include/linux/compat_ioctl.h:603:COMPATIBLE_IOCTL(WDIOC_GETSUPPORT)
  /usr/include/linux/compat_ioctl.h:604:COMPATIBLE_IOCTL(WDIOC_GETSTATUS)
  /usr/include/linux/compat_ioctl.h:605:COMPATIBLE_IOCTL(WDIOC_GETBOOTSTATUS)
  /usr/include/linux/compat_ioctl.h:606:COMPATIBLE_IOCTL(WDIOC_GETTEMP)
  /usr/include/linux/compat_ioctl.h:607:COMPATIBLE_IOCTL(WDIOC_SETOPTIONS)
  /usr/include/linux/compat_ioctl.h:608:COMPATIBLE_IOCTL(WDIOC_KEEPALIVE)
  /usr/include/linux/compat_ioctl.h:609:COMPATIBLE_IOCTL(WDIOC_SETTIMEOUT)
  /usr/include/linux/compat_ioctl.h:610:COMPATIBLE_IOCTL(WDIOC_GETTIMEOUT)
  /usr/include/linux/watchdog.h:23:#define        WDIOC_GETSUPPORT        _IOR(WATCHDOG_IOCTL_BASE, 0, struct watchdog_info)
  /usr/include/linux/watchdog.h:24:#define        WDIOC_GETSTATUS         _IOR(WATCHDOG_IOCTL_BASE, 1, int)
  /usr/include/linux/watchdog.h:25:#define        WDIOC_GETBOOTSTATUS     _IOR(WATCHDOG_IOCTL_BASE, 2, int)
  /usr/include/linux/watchdog.h:26:#define        WDIOC_GETTEMP           _IOR(WATCHDOG_IOCTL_BASE, 3, int)
  /usr/include/linux/watchdog.h:27:#define        WDIOC_SETOPTIONS        _IOR(WATCHDOG_IOCTL_BASE, 4, int)
  /usr/include/linux/watchdog.h:28:#define        WDIOC_KEEPALIVE         _IOR(WATCHDOG_IOCTL_BASE, 5, int)
  /usr/include/linux/watchdog.h:29:#define        WDIOC_SETTIMEOUT        _IOWR(WATCHDOG_IOCTL_BASE, 6, int)
  /usr/include/linux/watchdog.h:30:#define        WDIOC_GETTIMEOUT        _IOR(WATCHDOG_IOCTL_BASE, 7, int)

To add to the misery, it isn't possible to disable the build of wdctl
AFAICT.

System info:

> cat /etc/SuSE-release
SUSE Linux Enterprise Server 10 (x86_64)
VERSION = 10
PATCHLEVEL = 3
> uname -r
2.6.16.60-0.58.1.3835.0.PTF.638363-smp


Thanks,
Moritz

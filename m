Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:61606 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592AbcCNLjD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Mar 2016 07:39:03 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Andreas Henriksson <andreas@fatal.se>
Subject: Re: [PATCH] build: uuidd requires linux now, uses signalfd
Date: Mon, 14 Mar 2016 12:38:58 +0100
Cc: util-linux@vger.kernel.org
References: <1457891767-16753-1-git-send-email-andreas@fatal.se> <201603132145.44967.sweet_f_a@gmx.de> <20160314064255.GA19644@fatal.se>
In-Reply-To: <20160314064255.GA19644@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201603141238.58351.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 14 March 2016, Andreas Henriksson wrote:
> Hello Ruediger Meier.
>
> On Sun, Mar 13, 2016 at 09:45:44PM +0100, Ruediger Meier wrote:
> > On Sunday 13 March 2016, Andreas Henriksson wrote:
> > > Specify that uuidd can only be built on Linux now since
> >
> > Did you managed to build ipcs and ipcrm and do they work
> > correctly? Which system have you tried?
>
> No I have not. This was simply a reaction to the immediate problems
> found in the build daemon logs after uploading 2.28-rc1 to
> Debian Experimental, see
> https://buildd.debian.org/status/package.php?p=util-linux&suite=exper
>imental
>

Nice build logs!
BTW since you are running the tests with --verbose you could also force
--parallel=1 to not mix output of certain tests.

> It's possible additional fixes are needed. I don't run non-Linux
> myself.

Hurd has no WEXITED:
  login-utils/sulogin.c:1073:35: error: 'WEXITED' undeclared
     ret = waitid(P_ALL, 0, &status, WEXITED);

Maybe to be fixed like this (ifdef'ed)
https://lists.debian.org/debian-hurd/2013/07/msg00046.html


And I see my old question answered regarding 565964a9.
fdisk/bsd test fails on alpha because of

libfdisk/src/bsd.c:
#ifdef __alpha__
        {BSD_FS_EXT2,   "ext2"},
#else
        {BSD_FS_MSDOS,  "MS-DOS"},
#endif

Could be simply skipped for now like this:

diff --git a/tests/ts/fdisk/bsd b/tests/ts/fdisk/bsd
index cd7a6c6..386402a 100755
--- a/tests/ts/fdisk/bsd
+++ b/tests/ts/fdisk/bsd
@@ -137,4 +137,5 @@ echo -e "${FDISK_CMD_BSD_LIST_TYPES}" | \

 fdisk_bsd_offset_and_byte_order_clean
 ts_fdisk_clean ${TEST_IMAGE_NAME}
+grep "3  Version 7        8  ext2             c  ISO-9660        10  AdvFS" $TS_OUTPUT && ts_skip "alpha undefined"
 ts_finalize


cu,
Rudi

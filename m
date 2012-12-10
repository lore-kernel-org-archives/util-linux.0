Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60104 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752920Ab2LJMoy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 10 Dec 2012 07:44:54 -0500
Date: Mon, 10 Dec 2012 13:44:48 +0100
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] libmount: avoid endless loop in,
 mnt_get_kernel_cmdline_option
Message-ID: <20121210124448.GF21405@x2.net.home>
References: <50B8DB65.60505@bernhard-voelker.de>
 <50BE151A.9090608@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50BE151A.9090608@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Dec 04, 2012 at 04:22:02PM +0100, Bernhard Voelker wrote:
> On 11/30/2012 05:14 PM, Bernhard Voelker wrote:
> > From 4ddf21607847570e1da3b692276f2a8242bd5af6 Mon Sep 17 00:00:00 2001
> > From: Bernhard Voelker <mail@bernhard-voelker.de>
> > Date: Fri, 30 Nov 2012 17:12:12 +0100
> > Subject: [PATCH] libmount: avoid endless loop in
> >  mnt_get_kernel_cmdline_option
> 
> Hi Karel,
> 
> BTW: the #ifdef in mnt_get_kernel_cmdline_option doesn't seem
> to work to make use of the LIBMOUNT_KERNEL_CMDLINE env var:
> 
> --- tests/expected/libmount/utils-kernel-cmdline       2012-11-22 10:41:18.424077009 +0100
> +++ tests/output/libmount/utils-kernel-cmdline   2012-12-04 16:17:49.629199061 +0100
> @@ -1,5 +1,5 @@
> -'selinux=' found, argument: '0'
> +'selinux=' not found
>  'selinux' not found
> -'ro' found
> +'ro' not found
>  'ro=' not found
> -'root=' found, argument: 'UUID=33230ae2-1093-4353-824c-f7ca09a2a882'
> +'root=' found, argument: '/dev/sda1'
> 
> And ltraced:
> 
>  $ export LIBMOUNT_KERNEL_CMDLINE=`pwd`/tests/ts/libmount/files/kernel_cmdline
>  $ ltrace -e getenv,fopen -f ./test_mount_utils  --kernel-cmdline selinux=
>  getenv("LIBMOUNT_DEBUG")                                                                    = NULL
>  fopen("/proc/cmdline", "r")                                                                 = 0x609010
>  'selinux=' not found
>  +++ exited (status 0) +++

 It works, the problem is safe_getenv(), it requires root
 permissions.

 I had the test originally without the #ifdef TEST_PROGRAM, so the
 safe_getenv() was good idea, now it's overkill. Fixed, thanks!

 $ LIBMOUNT_KERNEL_CMDLINE=tests/ts/libmount/files/kernel_cmdline \
   ltrace -e fopen,getenv ./test_mount_utils --kernel-cmdline selinux=

 getenv("LIBMOUNT_DEBUG")                          = NULL
 getenv("LIBMOUNT_KERNEL_CMDLINE")                 = "tests/ts/libmount/files/kernel_c"...
 fopen("tests/ts/libmount/files/kernel_c"..., "r") = 0x1c99010

> I.e. the utils test may only work on your PC. ;-)

  :-)

> BTW2: the libmount tests all fail when the user has set
> LIBMOUNT_DEBUG=0xffff, because the produced output differs.
> Maybe LIBMOUNT_DEBUG should be unset in tests/run.sh?

 Good idea. Implemented.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

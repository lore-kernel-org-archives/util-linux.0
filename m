Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.9]:50746 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479Ab2LDPWG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 4 Dec 2012 10:22:06 -0500
Message-ID: <50BE151A.9090608@bernhard-voelker.de>
Date: Tue, 04 Dec 2012 16:22:02 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] libmount: avoid endless loop in, mnt_get_kernel_cmdline_option
References: <50B8DB65.60505@bernhard-voelker.de>
In-Reply-To: <50B8DB65.60505@bernhard-voelker.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 11/30/2012 05:14 PM, Bernhard Voelker wrote:
> From 4ddf21607847570e1da3b692276f2a8242bd5af6 Mon Sep 17 00:00:00 2001
> From: Bernhard Voelker <mail@bernhard-voelker.de>
> Date: Fri, 30 Nov 2012 17:12:12 +0100
> Subject: [PATCH] libmount: avoid endless loop in
>  mnt_get_kernel_cmdline_option

Hi Karel,

BTW: the #ifdef in mnt_get_kernel_cmdline_option doesn't seem
to work to make use of the LIBMOUNT_KERNEL_CMDLINE env var:

--- tests/expected/libmount/utils-kernel-cmdline       2012-11-22 10:41:18.424077009 +0100
+++ tests/output/libmount/utils-kernel-cmdline   2012-12-04 16:17:49.629199061 +0100
@@ -1,5 +1,5 @@
-'selinux=' found, argument: '0'
+'selinux=' not found
 'selinux' not found
-'ro' found
+'ro' not found
 'ro=' not found
-'root=' found, argument: 'UUID=33230ae2-1093-4353-824c-f7ca09a2a882'
+'root=' found, argument: '/dev/sda1'

And ltraced:

 $ export LIBMOUNT_KERNEL_CMDLINE=`pwd`/tests/ts/libmount/files/kernel_cmdline
 $ ltrace -e getenv,fopen -f ./test_mount_utils  --kernel-cmdline selinux=
 getenv("LIBMOUNT_DEBUG")                                                                    = NULL
 fopen("/proc/cmdline", "r")                                                                 = 0x609010
 'selinux=' not found
 +++ exited (status 0) +++

I.e. the utils test may only work on your PC. ;-)


BTW2: the libmount tests all fail when the user has set
LIBMOUNT_DEBUG=0xffff, because the produced output differs.
Maybe LIBMOUNT_DEBUG should be unset in tests/run.sh?

Have a nice day,
Berny

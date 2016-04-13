Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:55289 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753650AbcDMU6i convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 13 Apr 2016 16:58:38 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: v2.29 plan: kill mtab
Date: Wed, 13 Apr 2016 22:58:28 +0200
Cc: util-linux@vger.kernel.org
References: <20160407105400.jn66tldxy7s3rqyc@ws.net.home>
In-Reply-To: <20160407105400.jn66tldxy7s3rqyc@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <201604132258.28216.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 07 April 2016, Karel Zak wrote:
> libmount supports three scenarios:
>
>  1) regular classic /etc/mtab
>
>  2) /etc/mtab symlink to /proc/self/mount -- in this case libmount
> uses /proc/self/mountinfo and /run/mount/utab
>
>  The current default is to detect symlink and on-the-fly switch
>  between 1) and 2).
>
>  3) --enable-libmount-force-mountinfo -- don't care about the symlink
> and always use /proc/self/mountinfo. This is robust solution required
> for example by systemd, because unfortunately sometimes people use
> broken stuff (init scripts, tools, etc.) which removes the symlink.
>
>
>  I'd like to make 3) default, the question is what with mtab code:
>
>     a) #ifdef all mtab code (and add --enable-libmount-support-mtab)
>
>     b) remove mtab support at all (because it's evil and horrible
> code)
>
>  Comments?
>
>     Karel


What about this first step:

>From e6c17f35a8d63f129c5bbd722995b97d050e4151 Mon Sep 17 00:00:00 2001
From: Ruediger Meier <ruediger.meier@ga-group.nl>
Date: Wed, 13 Apr 2016 22:33:06 +0200
Subject: [PATCH] libmount: deprecate /etc/mtab file

Default is now --enable-libmount-force-mountinfo.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 31a1911..e4e6996 100644
--- a/configure.ac
+++ b/configure.ac
@@ -958,8 +958,8 @@ AC_SUBST([LIBMOUNT_VERSION_INFO])
 AC_DEFINE_UNQUOTED([LIBMOUNT_VERSION], ["$LIBMOUNT_VERSION"], [libmount version string])

 AC_ARG_ENABLE([libmount-force-mountinfo],
-  AS_HELP_STRING([--enable-libmount-force-mountinfo], [ignore /etc/mtab in all situations (recommended for systemd)]),
-  [], [enable_libmount_force_mountinfo=no]
+  AS_HELP_STRING([--disable-libmount-force-mountinfo], [use deprecated /etc/mtab file (not recommended and incompatible with openrc or systemd)]),
+  [], [enable_libmount_force_mountinfo=yes]
 )

 AS_IF([test "x$enable_libmount_force_mountinfo" == xyes], [
--
1.8.4.5

Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:64195 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752783AbcCMUpv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 13 Mar 2016 16:45:51 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Andreas Henriksson <andreas@fatal.se>
Subject: Re: [PATCH] build: uuidd requires linux now, uses signalfd
Date: Sun, 13 Mar 2016 21:45:44 +0100
Cc: util-linux@vger.kernel.org
References: <1457891767-16753-1-git-send-email-andreas@fatal.se>
In-Reply-To: <1457891767-16753-1-git-send-email-andreas@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201603132145.44967.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sunday 13 March 2016, Andreas Henriksson wrote:
> Specify that uuidd can only be built on Linux now since

Did you managed to build ipcs and ipcrm and do they work
correctly? Which system have you tried?

> commit 25d66b4e3232d7b "uuidd: use signalfd() and setup_timer()"
>
> Signed-off-by: Andreas Henriksson <andreas@fatal.se>
> ---
>  configure.ac | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configure.ac b/configure.ac
> index 8d808b7..e5ee3fb 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1079,6 +1079,7 @@ AC_ARG_ENABLE([uuidd],
>    [], [UL_DEFAULT_ENABLE([uuidd], [check])]
>  )
>  UL_BUILD_INIT([uuidd])
> +UL_REQUIRES_LINUX([uuidd])
>  UL_REQUIRES_BUILD([uuidd], [libuuid])
>  AS_IF([test "x$build_uuidd" = xyes], [
>    AC_DEFINE([HAVE_UUIDD], [1], [Define to 1 if you want to use uuid
> daemon.])


I have an alternative patch and would push it until tomorrow:

-----------
build-sys: improve uuidd and script build conditions

diff --git a/configure.ac b/configure.ac
index 5e89e3b..fafe762 100644
--- a/configure.ac
+++ b/configure.ac
@@ -244,6 +244,7 @@ AC_CHECK_HEADERS([ \
 	sys/param.h \
 	sys/prctl.h \
 	sys/resource.h \
+	sys/signalfd.h \
 	sys/socket.h \
 	sys/sockio.h \
 	sys/stat.h \
@@ -289,6 +290,7 @@ 
have_security_pam_appl_h=$ac_cv_header_security_pam_appl_h
 have_security_pam_misc_h=$ac_cv_header_security_pam_misc_h
 have_security_openpam_h=$ac_cv_header_security_openpam_h
 have_shadow_h=$ac_cv_header_shadow_h
+have_sys_signalfd_h=$ac_cv_header_sys_signalfd_h
 have_utmp_h=$ac_cv_header_utmp_h
 
 AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
@@ -1079,6 +1081,8 @@ AC_ARG_ENABLE([uuidd],
 )
 UL_BUILD_INIT([uuidd])
 UL_REQUIRES_BUILD([uuidd], [libuuid])
+UL_REQUIRES_HAVE([uuidd], [timer], [timer_create function])
+UL_REQUIRES_HAVE([uuidd], [sys_signalfd_h], [sys/signalfd.h header])
 AS_IF([test "x$build_uuidd" = xyes], [
   AC_DEFINE([HAVE_UUIDD], [1], [Define to 1 if you want to use uuid 
daemon.])
 ])
@@ -1494,7 +1498,7 @@ UL_REQUIRES_LINUX([setarch])
 AM_CONDITIONAL([BUILD_SETARCH], [test "x$build_setarch" = xyes])
 
 UL_BUILD_INIT([script], [check])
-UL_REQUIRES_LINUX([script])
+UL_REQUIRES_HAVE([script], [sys_signalfd_h], [sys/signalfd.h header])
 AM_CONDITIONAL([BUILD_SCRIPT], [test "x$build_script" = xyes])
 
 UL_BUILD_INIT([scriptreplay], [yes])
-----------

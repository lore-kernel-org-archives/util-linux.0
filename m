Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:58342 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932725AbcBIRTc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 9 Feb 2016 12:19:32 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: J William Piggott <elseifthen@gmx.com>
Subject: Re: Configure fails on single builds
Date: Tue, 9 Feb 2016 18:19:29 +0100
Cc: "util-linux" <util-linux@vger.kernel.org>
References: <56BA1630.7090106@gmx.com>
In-Reply-To: <56BA1630.7090106@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201602091819.29558.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 09 February 2016, J William Piggott wrote:
> commit 15167589fb40be9479e1afe261bea0bf23b33a83 causing single
> builds (other than chrt) to fail:
>
> ./configure --disable-all-programs --enable-hwclock
>
> conditional \"HAVE_SCHED_SETATTR\" was never defined.
> Usually this means the macro was only invoked conditionally.

I have fixed it for me like this, quick and dirty:


diff --git a/configure.ac b/configure.ac
index 4559573..cc9eb55 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1774,9 +1774,7 @@ UL_BUILD_INIT([chrt], [check])
 UL_REQUIRES_BUILD([chrt], [schedutils])
 AM_CONDITIONAL([BUILD_CHRT], [test "x$build_chrt" = xyes])

-AS_IF([test "x$build_chrt" = xyes], [
-       UL_CHECK_SYSCALL([sched_setattr])
-])
+UL_CHECK_SYSCALL([sched_setattr])


 AC_ARG_ENABLE([wall],


cu,
Rudi

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52483 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755771AbbKRM7K (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 18 Nov 2015 07:59:10 -0500
Date: Wed, 18 Nov 2015 13:59:08 +0100
From: Karel Zak <kzak@redhat.com>
To: "Casper Ti. Vector" <caspervector@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] linux_reboot.h: support 1-argument reboot() from
 alternative libc.
Message-ID: <20151118125904.GB19508@ws.net.home>
References: <3122dea1b0bbfab174b9e1cc70aec72676568f52.1447762216.git.CasperVector@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3122dea1b0bbfab174b9e1cc70aec72676568f52.1447762216.git.CasperVector@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Nov 17, 2015 at 04:54:15PM +0800, Casper Ti. Vector wrote:
> Original code assumes 1-argument reboot() is only provided by glibc 2.x
> and later; but as far as the patch author knows, at least the following
> alternative C libraries for linux also provide the 1-argument variant:
> 
> * uclibc: all public releases.
> * dietlibc: 0.7.2 and all later releases; reboot() was not provided in
>             0.7.1 and earlier versions.
> * musl: all public releases.
> * klibc: all public releases.
> * bionic: all public releases.
> 
> ... which should already cover most use cases.
> ---
>  include/linux_reboot.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

I think Christoph is right, let's remove all the wrappers from
linux_reboot.h and use directly reboot() in the code.

It's always fragile to check for libc version in source code. The
better solution is to use ./configure and care about the function/feature 
than about any version number.

 AC_CHECK_FUNCS([reboot], [have_open_reboot=yes],[have_open_reboot=no])
 ...

 UL_BUILD_INIT([ctrlaltdel], [check])
 UL_REQUIRES_LINUX([ctrlaltdel])
 UL_REQUIRES_HAVE([ctrlaltdel], [reboot])
 AM_CONDITIONAL([BUILD_CTRLALTDEL], [test "x$build_ctrlaltdel" = xyes])

then it will compile ctrlaltdel only when we have reboot().

And if you want to be really pedantic then you can use
AC_COMPILE_IFELSE() to check for 1-argument reboot(), but it seems
it's unnecessary.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

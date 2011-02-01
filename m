Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35794 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753227Ab1BANFS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 1 Feb 2011 08:05:18 -0500
Date: Tue, 1 Feb 2011 14:05:14 +0100
From: Karel Zak <kzak@redhat.com>
To: Marek Otahal <markotahal@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] configure.ac : remove enable_foo checks for non-linux
	OSs
Message-ID: <20110201130514.GO1787@nb.net.home>
References: <201102011213.23641.markotahal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201102011213.23641.markotahal@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 01, 2011 at 12:12:45PM +0100, Marek Otahal wrote:
> PS: The TODO list is a good thing, if you write the task more detailed (like 
> this one), more people can easily implement it. 

 OK :-)

> +# we do not build these for non-linux os
> +if test "x$linux_os" = xno
>      AC_MSG_WARN([non-linux system; do not build mount utilities])
>      build_mount=no
> +  AC_MSG_WARN([non-linux system; do not build libmount])
> +  build_libmount=no
> +  AC_MSG_WARN([non-linux system; do not build switch_root])
> +  build_switch_root=no
> +  AC_MSG_WARN([non-linux system; do not build pivot_root])
> +  build_pivot_root=no
> +  AC_MSG_WARN([non-linux system; do not build fallocate])
> +  build_fallocate=no
> +  AC_MSG_WARN([non-linux system; do not build unshare])
> +  build_unshare=no
>    fi

 This is not exactly what I mean. In your implementation are
 Linux-only things disable at all, so if you explicitly

    ./configure --enable-unshare

 then the configure script will ignore this request and unshare(1)
 will be disabled. That's wrong (and for some utils is the current
 implementation wrong too).
 
 The configure script should not be more smart than user. We need to
 care about default settings (if --disable/enable is not specified)
 only. Currently the default is "check", I'd like to modify the
 default according to $linux_os.

 Something like:

    linuxonly_default=check

    if test "x$linux_os" = xno
        AC_MSG_WARN([non-linux system; unshare(1), libmount, ... 
                     are disabled by default. Use --enable-<name>
                     to enable required util(s)])
        linuxonly_default=no
    fi


    AC_ARG_ENABLE([unshare],
        AS_HELP_STRING([--disable-unshare], [do not build unshare]),
        [], enable_unshare=$linuxonly_default)

    AM_CONDITIONAL(BUILD_UNSHARE, test "x$enable_unshare" != xno)


 maybe that for some utils it will be necessary to do some extra
 checks before AM_CONDITIONAL() -- for example to detect that systems
 has proper syscall (e.g. switch_root depends on openat()).

 Note that this is nothing urgent, it's too late for v2.19 release.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

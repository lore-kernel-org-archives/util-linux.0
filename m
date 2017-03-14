Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34060 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750749AbdCNKQY (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 14 Mar 2017 06:16:24 -0400
Date: Tue, 14 Mar 2017 11:16:18 +0100
From: Karel Zak <kzak@redhat.com>
To: L A Walsh <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Subject: Re: ideas of what lib might be missing?  (2.29.2 has missing symbols
 @ link)
Message-ID: <20170314101618.zzk4lbkjatud63et@ws.net.home>
References: <58C3F064.4060904@tlinx.org>
 <20170313114135.riuh2pahfs3v4jkp@ws.net.home>
 <58C74F74.4040007@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <58C74F74.4040007@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 13, 2017 at 07:03:32PM -0700, L A Walsh wrote:
> 
> >  This copy & past from some build system, or what? It would be better
> >  to have ./configure command line.
> ---
>    Attached configure and summary lines to
> https://bugzilla.kernel.org/show_bug.cgi?id=194857
> 
> Are those sufficient to reproduce things?

I see many:

    ar: plugin needed to handle lto object

and
    ranlib: plugin needed to handle lto object

warnings... It seems that your CFLAGS and LDFLAGS are too messy. If I
try just your configure without CFLAGS and LDFLAGS than all works as
expected.

make clean

./configure \
--prefix=/ \
--exec-prefix=/ --bindir=/bin --sbindir=/sbin --datadir=/share \
--datarootdir=/share --includedir=/include --oldincludedir=/include \
--libdir=/lib64 --libexecdir=/lib64/util-linux --localstatedir=/var \
--sharedstatedir=/com --sysconfdir=/etc --docdir=/share/doc --prefix=/ \
--bindir=/bin --sbindir=/sbin --datadir=/share --datarootdir=/share \
--docdir=/share/doc --includedir=/include --oldincludedir=/include \
--libdir=/lib64 --libexecdir=/lib64/util-linux --localstatedir=/var \
--sharedstatedir=/com --sysconfdir=/etc --enable-chfn-chsh \
--enable-dependency-tracking --enable-fs-paths-default --enable-last \
--enable-libmount-support-mtab --enable-line --enable-newgrp --enable-pg \
--enable-reset --enable-static-programs=mount --enable-sulogin-emergency-mount \
--enable-tunelp --enable-vipw --enable-write --disable-assert --disable-nls \
--disable-plymouth_support --disable-pylibmount --disable-symvers --with-audit \
--with-bashcompletiondir=/usr/share/bash-completion --with-gnu-ld \
--with-ncursesw --with-readline --without-python --without-systemd

make

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752857AbdLRN2n (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 18 Dec 2017 08:28:43 -0500
Date: Mon, 18 Dec 2017 14:28:39 +0100
From: Karel Zak <kzak@redhat.com>
To: L A Walsh <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Subject: Re: Build problem in 2.31
Message-ID: <20171218132839.x5gvn5ucdepfawee@ws.net.home>
References: <5A37371F.5070307@tlinx.org>
 <20171218123805.tkhhuyemgntv4gie@ws.net.home>
 <5A37BB4F.9080004@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5A37BB4F.9080004@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Dec 18, 2017 at 04:57:51AM -0800, L A Walsh wrote:
> Running Config:
> > ../config-231.sh#69> ./configure 'CFLAGS=-fpic -march=native -pipe -Og'
> 'LDFLAGS=-fpic -march=native -pipe -Og -Wl,--default-symver -Wl,--stats '
                                         ^^^^^^^^^^^^^^^^^^^^
 This is the evil. Try it without "-Wl,--default-symver"

> --prefix=/ --exec-prefix=/ --bindir=/bin --sbindir=/sbin --datadir=/share
> --includedir=/include --oldincludedir=/include --libdir=/lib64
> --libexecdir=/lib64/util-linux --localstatedir=/var --sharedstatedir=/com
> --sysconfdir=/etc --prefix=/ --bindir=/bin --sbindir=/sbin --datadir=/share
> --includedir=/include --oldincludedir=/include --libdir=/lib64
> --libexecdir=/lib64/util-linux --localstatedir=/var --sharedstatedir=/com
> --sysconfdir=/etc --enable-chfn-chsh --enable-fs-paths-default --enable-last
> --enable-libmount-support-mtab --enable-line --enable-newgrp --enable-pg
                ^^^^^^^^^^^^^^
                  really? :-)

> --enable-silent-rules --enable-sulogin-emergency-mount --enable-vipw
> --enable-write --disable-assert --disable-nls --disable-plymouth_support
> --disable-pylibmount --disable-symvers
> --with-bashcompletiondir=/usr/share/bash-completion --with-gnu-ld
> --with-ncursesw --with-readline --without-python --without-systemd

I'm able to reproduce the problem with your ./configure options. I'll
try to play with it more at evening.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750993AbdEaJRD (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 31 May 2017 05:17:03 -0400
Date: Wed, 31 May 2017 11:16:48 +0200
From: Karel Zak <kzak@redhat.com>
To: Assaf Gordon <assafgordon@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.30-rc2
Message-ID: <20170531091648.3eql47zhfo6sy6sd@ws.net.home>
References: <20170523105038.hm3ryvwvghgife4j@ws.net.home>
 <E6F9AA27-1BC9-4595-9FB2-30F1BA3663CA@gmail.com>
 <20170530151814.wm26bajmdihwaryo@ws.net.home>
 <89E326AC-7FC7-48E9-8781-02791E0E8A7F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <89E326AC-7FC7-48E9-8781-02791E0E8A7F@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 30, 2017 at 11:48:46PM -0400, Assaf Gordon wrote:
> Hello,
> 
> > On May 30, 2017, at 11:18, Karel Zak <kzak@redhat.com> wrote:
> > 
> > On Tue, May 30, 2017 at 01:03:53AM -0400, Assaf Gordon wrote:
> >> /usr/bin/ld: cannot find -lncursesw
> >> collect2: error: ld returned 1 exit status
> >> make[2]: *** [cfdisk] Error 1
> >> ===
> > 
> > OK, I had nice afternoon with Debian (after 10 years;-)
> 
> 
> I'm still seeing this error (tested with util-linux-2.30-rc2-16-2ac1b on
> same Debian 8.1 system).

Ah, I had another issues with ncurses on debian, so I forget to very
this one. Fixed now (I hope).

> +++-=======================-================-================-====================================================
> un  libncurses-dev          <none>           <none>           (no description available)
> ii  libncurses5:amd64       5.9+20140913-1+b amd64            shared libraries for terminal handling
> ii  libncurses5-dev:amd64   5.9+20140913-1+b amd64            developer's libraries for ncurses
> ii  libncursesw5:amd64      5.9+20140913-1+b amd64            shared libraries for terminal handling (wide charact

The issue is that we get -lncursesw from pkg-config (probably due to
installed ncursesw-config), but the rest of the build system assumes
non-widechar version. It seems better to use pkg-config as fallback
solution only.

> Also,
> On alpine-linux, the compilation now fails with:
> ===
> CC       sys-utils/dmesg-dmesg.o
> sys-utils/dmesg.c:9:26: fatal error: linux/unistd.h: No such file or directory
> compilation terminated.
> Makefile:9274: recipe for target 'sys-utils/dmesg-dmesg.o' failed
> make[2]: *** [sys-utils/dmesg-dmesg.o] Error 1
> ===
> Again, this could be due to missing "linux-headers" package - but is it really the kernel's
> "unistd.h" that's needed, or could this work with the standard one?

The file linux/unistd.h is unnecessary for dmesg (fixed), but we have
many another places where kernel header files are required.

So, now the header file <linux/version.h> is required by ./configure
on Linux. I guess it's not overkill.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

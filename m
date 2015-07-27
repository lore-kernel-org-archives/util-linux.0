Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33484 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753148AbbG0JzL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 27 Jul 2015 05:55:11 -0400
Date: Mon, 27 Jul 2015 11:55:07 +0200
From: Karel Zak <kzak@redhat.com>
To: Joel Holdsworth <joel@airwebreathe.org.uk>
Cc: Bernhard Voelker <mail@bernhard-voelker.de>, util-linux@vger.kernel.org,
        Joel Holdsworth <joel.holdsworth@vcatechnology.com>
Subject: Re: [PATCH] build-sys: cal requires both ncurses and tinfo
Message-ID: <20150727095507.GA6865@ws.net.home>
References: <1437692199-7557-1-git-send-email-joel.holdsworth@vcatechnology.com>
 <55B1D9F7.4040109@bernhard-voelker.de>
 <20150724075612.GE3432@ws.net.home>
 <55B276F1.5070706@airwebreathe.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <55B276F1.5070706@airwebreathe.org.uk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 24, 2015 at 06:33:37PM +0100, Joel Holdsworth wrote:
> Ok, so cal can build without ncurses and/or tinfo - fine ok.
> 
> The problem I have is with misc-utils/Makemodule.am:14
> 
> https://git.kernel.org/cgit/utils/util-linux/util-linux.git/tree/misc-utils/Makemodule.am?h=stable%2Fv2.26#n14
> 
> ...this is making it link with -ltinfo, which fails because I'm not
> providing it. Would it be more correct to make NCURSES_LIBS and
> TINFO_LIBS become empty when they're not available? 

It should be empty, see configure. It sets TINFO_LIBS by
PKG_CHECK_MODULES() or AC_CHECK_LIB().

> I'm slightly suspicious of my cross-build setup if configure is picking
> up "-ltinfo" dependencies from the host system, but even with
> '--disable-tinfo', TINFO_LIBS is still not set to "".

You want to use --without-tinfo (see configure --help):

$ ./configure &> /dev/null
$ grep "TINFO_LIBS =" Makefile
TINFO_LIBS = -ltinfo 

$ ./configure --without-tinfo &> /dev/null
$ grep "TINFO_LIBS =" Makefile
TINFO_LIBS =


> Also having UL_BUILD_INIT([cal], [yes]) to force cal to always be built
> seem ridiculous; in fact why should any of the tools be forced? The user
> should be able to mix and match whatever programs they want to have.

Well, the script uses [yes] because cal does not have any strict
dependence, so [check] does not have any sense here.

> Another related issue is that I was hoping to be able to do
> '--disable-all-programs', then '--enable-XXX' the ones I need one by one
> - but the disable-all flag seems to take precedence right now.

I don't think so. For example:

 ./configure --disable-all-programs --enable-unshare

works as expected. The problem is that we currently don't have
--enable- for all stuff, for example --enable-cal is missing.

Fixed now. I have added --disable-cal because it seems that cal(1) is
tricky enough due to compilation with/without ncurses/termpac/tinfo.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

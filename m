Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:61496 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756001AbcJTQ2M (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 20 Oct 2016 12:28:12 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [ANNOUNCE] util-linux v2.29-rc2
Date: Thu, 20 Oct 2016 18:28:05 +0200
Cc: util-linux@vger.kernel.org
References: <20161019132505.cumn37cmgazlumcu@ws.net.home> <201610201334.24945.sweet_f_a@gmx.de> <20161020151948.3y47rv5lwmqppubf@ws.net.home>
In-Reply-To: <20161020151948.3y47rv5lwmqppubf@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201610201828.05511.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 20 October 2016, Karel Zak wrote:
> On Thu, Oct 20, 2016 at 01:34:24PM +0200, Ruediger Meier wrote:
> > For me it looks like the even the ncurses authors do not like their
> > own pc files. Disabled by default and it's a pain to get them built
> > with correct names and installed in the right location. Even
> > --prefix does not work for their pc files. Plus the backward
> > compatibility problem ...
>
> OK, I have applied:
>   
> https://github.com/karelzak/util-linux/commit/e5cc93b5a8854fce80537f8
>6a244977df212dcb5
>
> with ncurses-config and fallback to old good AC_CHECK_LIB.

Thanks!

> We can add fallback to pkg-config too, but it sounds like overkill if
> ncurses-config is everywhere.
>
> It seems drone.io don't like the change
> https://drone.io/github.com/karelzak/util-linux/641 but not sure if
> the problem is our build-system or drone.io.

It finds ncursesw5-config but not the lib. Looks like a packaging bug in 
Ubuntu 12.04.

I guess libncursesw5-dev is not installed but ncursesw5-config is from 
the installed ncurses-bin. The config script should be in the dev 
packages as well as the .pc files.

http://packages.ubuntu.com/precise/amd64/ncurses-bin/filelist
http://packages.ubuntu.com/precise/amd64/libncursesw5-dev/filelist

We don't need to handle such broken installation. In drone.io script you 
could try
  apt-get install -qq libncursesw5-dev

cu,
Rudi
   

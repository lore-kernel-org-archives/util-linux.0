Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964840AbcJTPTu (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 20 Oct 2016 11:19:50 -0400
Date: Thu, 20 Oct 2016 17:19:48 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.29-rc2
Message-ID: <20161020151948.3y47rv5lwmqppubf@ws.net.home>
References: <20161019132505.cumn37cmgazlumcu@ws.net.home>
 <201610201225.31755.sweet_f_a@gmx.de>
 <20161020110003.if5kjodyjqezynzp@ws.net.home>
 <201610201334.24945.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201610201334.24945.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 20, 2016 at 01:34:24PM +0200, Ruediger Meier wrote:
> For me it looks like the even the ncurses authors do not like their own 
> pc files. Disabled by default and it's a pain to get them built with 
> correct names and installed in the right location. Even --prefix does 
> not work for their pc files. Plus the backward compatibility 
> problem ... 

OK, I have applied:
   https://github.com/karelzak/util-linux/commit/e5cc93b5a8854fce80537f86a244977df212dcb5

with ncurses-config and fallback to old good AC_CHECK_LIB. 

We can add fallback to pkg-config too, but it sounds like overkill if
ncurses-config is everywhere.

It seems drone.io don't like the change https://drone.io/github.com/karelzak/util-linux/641
but not sure if the problem is our build-system or drone.io.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

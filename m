Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753069AbdC0NIg (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 27 Mar 2017 09:08:36 -0400
Date: Mon, 27 Mar 2017 15:08:04 +0200
From: Karel Zak <kzak@redhat.com>
To: Michael Tretter <m.tretter@pengutronix.de>
Cc: util-linux@vger.kernel.org, Stef Walter <stefw@redhat.com>
Subject: Re: agetty reorders characters in login prompt
Message-ID: <20170327130804.xjqfpnw434dtuol5@ws.net.home>
References: <20170317123053.37e73a6a@litschi.hi.pengutronix.de>
 <20170317121055.c4hv6rb5y4tbpt2c@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170317121055.c4hv6rb5y4tbpt2c@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 17, 2017 at 01:10:55PM +0100, Karel Zak wrote:
> Maybe it would be better to remember already read bytes within agetty
> rather than use TIOCSTI.
 
 Implemented, please test:

  git clone git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git
  cd util-linux
  ./autogen.sh
  ./configure
  make agetty

  sudo cp /sbin/agetty /sbin/agetty.org
  sudo cp agetty /sbin/agetty

 .. you will probably need to stop already running agetty(s) before
 the sudo commands, and start after cp(1). (for example "systemctl
 stop/stop getty@tty*" on Fedora).

 Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

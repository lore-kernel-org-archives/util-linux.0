Return-Path: m.tretter@pengutronix.de
Date: Tue, 28 Mar 2017 18:32:51 +0200
From: Michael Tretter <m.tretter@pengutronix.de>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Stef Walter <stefw@redhat.com>
Subject: Re: agetty reorders characters in login prompt
Message-ID: <20170328183251.649bdb29@litschi.hi.pengutronix.de>
In-Reply-To: <20170327130804.xjqfpnw434dtuol5@ws.net.home>
References: <20170317123053.37e73a6a@litschi.hi.pengutronix.de>
 <20170317121055.c4hv6rb5y4tbpt2c@ws.net.home>
 <20170327130804.xjqfpnw434dtuol5@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <util-linux.vger.kernel.org>

On Mon, 27 Mar 2017 15:08:04 +0200, Karel Zak wrote:
> On Fri, Mar 17, 2017 at 01:10:55PM +0100, Karel Zak wrote:
> > Maybe it would be better to remember already read bytes within
> > agetty rather than use TIOCSTI.
>  
>  Implemented, please test:
> 
>   git clone
> git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git cd
> util-linux ./autogen.sh
>   ./configure
>   make agetty
> 
>   sudo cp /sbin/agetty /sbin/agetty.org
>   sudo cp agetty /sbin/agetty
> 
>  .. you will probably need to stop already running agetty(s) before
>  the sudo commands, and start after cp(1). (for example "systemctl
>  stop/stop getty@tty*" on Fedora).

Thanks. I tested master and it works now. The echoed user name is
correct in the automated tests and my manual tests and the login was
always successful.

Michael

>  Thanks!
> 
>     Karel
> 

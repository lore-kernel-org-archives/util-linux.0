Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751035AbdCQMLB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 17 Mar 2017 08:11:01 -0400
Date: Fri, 17 Mar 2017 13:10:55 +0100
From: Karel Zak <kzak@redhat.com>
To: Michael Tretter <m.tretter@pengutronix.de>
Cc: util-linux@vger.kernel.org, kernel@pengutronix.de,
        Stef Walter <stefw@redhat.com>
Subject: Re: agetty reorders characters in login prompt
Message-ID: <20170317121055.c4hv6rb5y4tbpt2c@ws.net.home>
References: <20170317123053.37e73a6a@litschi.hi.pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170317123053.37e73a6a@litschi.hi.pengutronix.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 17, 2017 at 12:30:53PM +0100, Michael Tretter wrote:
> Hello,
> 
> agetty sometimes changes the order of the characters of the username in
> the login prompt. For example, if I enter 'root' as username, the echo
> reads 'orot' and the login fails, because the user does not exist.
> 
> A little bit background on the issue: I am running automated tests on
> an embedded device with an i.MX6 processor which connects to the board
> via serial console with 115200 baud. The test waits for the login
> prompt and then sends the username via the serial console. In about
> 20 % of the test runs the echoed username slightly differs from the
> sent username and the test fails.
> 
> I can also reproduce the issue when connecting to the serial console
> via screen and pasting the username into the prompt. If I enter the
> username manually or connect strace to agetty, the username is always
> correct. I reproduced the problem on multiple different device
> (although all with the same SoC).
> 
> I tested it with util-linux 2.29 with Linux 4.11-rc2 and 4.4.52.
> 
> I was able to trace the issue to the wait_for_term_input() function.
> This function reads the first (few) bytes from the input queue and
> after reading reinserts the bytes with the TIOCSTI ioctl back into the
> queue. If new bytes are inserted into the input queue before the
> TIOCSTI happens, the input queue will contain the bytes in the wrong
> order and later reads on the input queue will not yield the original
> input.

Hmm... the issue is that we use non-canonical mode when wait for user
activity, then we need to switch back to canonical mode. I guess
(according to the code) that we can lost unread data by tcsetattr().
So agetty read before tcsetattr() and re-enter by TIOCSTI after
tcsetattr(). This is probably pretty fragile.

Maybe it would be better to remember already read bytes within agetty
rather than use TIOCSTI.

Stef, any idea?

> I also opened a bug in the kernel Bugzilla [1], because I am not sure
> about the correct way to report bugs in util-linux.

We do no use kernel BZ, see "BUG REPORTING" in the README.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

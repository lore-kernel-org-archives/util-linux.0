Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35548 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576Ab3LBMyY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Dec 2013 07:54:24 -0500
Date: Mon, 2 Dec 2013 13:54:21 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: script input redirection / eof handling
Message-ID: <20131202125421.GF5572@x2.net.home>
References: <52726756.8060205@ubuntu.com>
 <20131202123659.GE5572@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131202123659.GE5572@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Dec 02, 2013 at 01:36:59PM +0100, Karel Zak wrote:
> On Thu, Oct 31, 2013 at 10:21:10AM -0400, Phillip Susi wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > I came across an old bug filed in debian about script being redirected
> > from a file misbehaving. 
> 
> Do you mean something like:
> 
>    echo "ps uf" | script
> 
> .. if yes, then it's pretty unexpected usage. The code expects that
> stdin is terminal. (For example it copy the current terminal
> attributes the new pseudo-terminal.)
> 
> Unfortunately it does not check tcgetatt() return code so the problem 
> is not visible. I'll fix it.

Note, that if you want to support this scenario (stdin is not a
terminal) then send a patch ;-) 

I guess you have to initialize the terminal (see inlude/ttyutils.h, 
reset_virtual_console()) and use this dummy struct termios instead of
the current 'tt'.

> Yep, I think it would be enough to add 
> 
>        kill(0, SIGTERM);
> 
> before done() in doinput() to avoid orphans.

 This is probably not the best solution (because shell will print
 "Terminated" etc.), but it's definitely better than orphans.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
